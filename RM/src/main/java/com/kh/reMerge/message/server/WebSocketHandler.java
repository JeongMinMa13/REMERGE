//package com.kh.reMerge.message.server;
//
//import java.util.ArrayList;
//import java.util.Map;
//import java.util.concurrent.ConcurrentHashMap;
// 
//import org.springframework.beans.factory.InitializingBean;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.socket.CloseStatus;
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
// 
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.kh.reMerge.message.model.service.MessageServiceImpl;
//import com.kh.reMerge.message.model.vo.Message;
//import com.kh.reMerge.message.model.vo.MessageRoomNo;
// 
//@Controller
//public class WebSocketHandler extends TextWebSocketHandler implements InitializingBean {
//    
//    @Autowired
//    MessageServiceImpl msi;
//    
//    private final ObjectMapper objectMapper = new ObjectMapper();
//    
//    // 채팅방 목록 <방 번호, ArrayList<session> >이 들어간다.
//    private Map<String, ArrayList<WebSocketSession>> RoomList = new ConcurrentHashMap<String, ArrayList<WebSocketSession>>();
//    // session, 방 번호가 들어간다.
//    private Map<WebSocketSession, String> sessionList = new ConcurrentHashMap<WebSocketSession, String>();
//    
//    private static int i;
//    /**
//     * websocket 연결 성공 시
//     */
//    @Override
//    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//        i++;
//        System.out.println(session.getId() + " 연결 성공 => 총 접속 인원 : " + i + "명");
//    }
// 
//    /**
//     * websocket 연결 종료 시
//     */
//    @Override
//    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//        i--;
//        System.out.println(session.getId() + " 연결 종료 => 총 접속 인원 : " + i + "명");
//        // sessionList에 session이 있다면
//        if(sessionList.get(session) != null) {
//            // 해당 session의 방 번호를 가져와서, 방을 찾고, 그 방의 ArrayList<session>에서 해당 session을 지운다.
//            RoomList.get(sessionList.get(session)).remove(session);
//            sessionList.remove(session);
//        }
//    }
// 
//    @Override
//    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
// 
//        // 전달받은 메세지
//        String msg = message.getPayload();
//        
//        // Json객체 → Java객체
//        // 출력값 : [roomId=123, messageId=null, message=asd, name=천동민, email=cheon@gmail.com, unReadCount=0]
//        Message Message = objectMapper.readValue(msg,Message.class);
//        
//        // 받은 메세지에 담긴 roomId로 해당 채팅방을 찾아온다.
//        MessageRoomNo roomNo = msi.selectChatRoom(Message.getContent());
//        
//        // 채팅 세션 목록에 채팅방이 존재하지 않고, 처음 들어왔고, DB에서의 채팅방이 있을 때
//        // 채팅방 생성
//        if(RoomList.get(roomNo.getMessageRoomNo()) == null && Message.getContent().equals("ENTER-CHAT") && roomNo != null) {
//            
//            // 채팅방에 들어갈 session들
//            ArrayList<WebSocketSession> sessionTwo = new ArrayList<>();
//            // session 추가
//            sessionTwo.add(session);
//            // sessionList에 추가
//            sessionList.put(session, roomNo.getMessageRoomNo());
//            // RoomList에 추가
//            RoomList.put(roomNo.getMessageRoomNo(), sessionTwo);
//            // 확인용
//            System.out.println("채팅방 생성");
//        }
//        
//        // 채팅방이 존재 할 때
//        else if(RoomList.get(roomNo.getMessageRoomNo()) != null && Message.getContent().equals("ENTER-CHAT") && roomNo != null) {
//            
//            // RoomList에서 해당 방번호를 가진 방이 있는지 확인.
//            RoomList.get(roomNo.getMessageRoomNo()).add(session);
//            // sessionList에 추가
//            sessionList.put(session, roomNo.getMessageRoomNo());
//            // 확인용
//            System.out.println("생성된 채팅방으로 입장");
//        }
//        
//        // 채팅 메세지 입력 시
//        else if(RoomList.get(roomNo.getMessageRoomNo()) != null && !Message.getContent().equals("ENTER-CHAT") && roomNo != null) {
//            
//            // 메세지에 이름, 이메일, 내용을 담는다.
//            TextMessage textMessage = new TextMessage(Message.getSendId() + "," + Message.getContent());
//            
//            // 현재 session 수
//            int readCheck = 0;
// 
//            // 해당 채팅방의 session에 뿌려준다.
//            for(WebSocketSession sess : RoomList.get(roomNo.getMessageRoomNo())) {
//                sess.sendMessage(textMessage);
//                readCheck++;
//            }
//            
//            // 동적쿼리에서 사용할 sessionCount 저장
//            // sessionCount == 2 일 때는 unReadCount = 0,
//            // sessionCount == 1 일 때는 unReadCount = 1
//            Message.setReadCheck(readCheck);
//            
//            // DB에 저장한다.
//            int a = msi.insertMessage(Message);
//            
//            if(a == 1) {
//                System.out.println("메세지 전송 및 DB 저장 성공");
//            }else {
//                System.out.println("메세지 전송 실패!!! & DB 저장 실패!!");
//            }
//        }
//    }
//    
//    @Override
//    public void afterPropertiesSet() throws Exception {}
//}
