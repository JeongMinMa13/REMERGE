<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공유 캘린더</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8bbc3ea0a937b0baf9ab04c7ad6b1970&libraries=services,clusterer"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
    .fc .fc-daygrid-day-number,
    .fc .fc-col-header-cell-cushion{
    	color : black;
    	text-decoration : none;
    }
    </style>
    
</head>
<body>
    <div class="container">
        <div id="calendar"></div>
    </div>
	
    <!-- 일정 추가 Modal -->
    <div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="eventModalLabel">일정 추가하기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addScheduleForm">
                        <div class="mb-3">
                            <label for="scheduleTitle" class="form-label">일정 제목</label>
                            <input type="text" class="form-control" id="scheduleTitle" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="scheduleStart" class="form-label">일정 시작일</label>
                            <input type="datetime-local" class="form-control" id="scheduleStart" name="start" required>
                        </div>
                        <div class="mb-3">
                            <label for="scheduleEnd" class="form-label">일정 종료일</label>
                            <input type="datetime-local" class="form-control" id="scheduleEnd" name="end">
                        </div>
                        <div class="mb-3">
                        	<label for="scheduleLocation" class="form-label"></label>
                        	<input type="text" placeholder="위치" id="scheduleLocation" name="location" style="width:300px;">
                        	<input type="button" onclick="searchAddress();" value="위치 검색">
                        </div>
                      	<div class="mb-3">
                      		<label for="scheduleMemo" class="form-label">메모</label>
                            <textarea id="scheduleMemo" name="memo"></textarea>
                      	</div>
                        
                        <button type="submit" class="btn btn-primary">일정 추가하기</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- detail Modal -->
    <div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="detailModalLabel">일정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="updateScheduleForm" action="updateSchedule.sc">
                    	<input type="hidden" id="detailScheduleNo">
                        <div class="mb-3">
                            <label for="detailTitle" class="form-label">일정 제목</label>
                            <input type="text" class="form-control" id="detailTitle" name="title" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="detailStart" class="form-label">일정 시작일</label>
                            <input type="datetime-local" class="form-control" id="detailStart" name="start" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="detailEnd" class="form-label">일정 종료일</label>
                            <input type="datetime-local" class="form-control" id="detailEnd" name="end" readonly>
                        </div>
                        <div class="mb-3">
                        	<label for="detailLocation" class="form-label"></label>
                        	<input type="text" placeholder="위치" id="detailLocation" name="location" style="width:300px;" readonly>
                        	<div id="map"></div>
                        </div>
                      	<div class="mb-3">
                      		<label for="detailMemo" class="form-label">메모</label>
                            <textarea id="detailMemo" name="memo" readonly></textarea>
                      	</div>
                      	<div class="mb-3">
                      		<label for="detailUserId" class="form-label">아이디</label>
                            <input type="text" id="detailUserId" name="memo" readonly>
                      	</div>
                        <button type="submit" class="btn btn-primary">수정하기</button>
                        <button type="button" class="btn btn-danger" onclick="deleteSchedule();">일정 삭제</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
	    
    	document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                selectable: true,
                dateClick: function(info) {
                	document.getElementById('addScheduleForm').reset();
                	//console.log(info.dateStr); 입력값 확인
                	var dateStr =info.dateStr+'T00:00';//날짜만 입력 되기에 시간은 초기화
                    // 모달 창 열기
                    var scheduleModal = new bootstrap.Modal(document.getElementById('scheduleModal'));
                    //console.log(dateStr);//입력값 확인
                    document.getElementById('scheduleStart').value = dateStr;
                    document.getElementById('scheduleEnd').value = ''; // 종료 날짜 초기화
                    scheduleModal.show();
                    
                },
                eventClick:function(info){
                
                	var id = info.event.id;//조회해올때 내 db에서 만들어진 squence id값 뽑기
                	//console.log(id); //console로 확인
                	$.ajax({ //확인해봤으니 ajax로 조회해서 모달창 띄워 정보 보여주기
                		url:"detailSchedule.sc",
                		type:"get",
                		data:{
                			scheduleNo:id
                		},
                		success:function(data){
                			//console.log(data); 조회해온 데이터 확인
                			//모달창 열기
                			var detailModal = new bootstrap.Modal(document.getElementById('detailModal'));
                			document.getElementById('detailScheduleNo').value = data.scheduleNo;
                			document.getElementById('detailTitle').value = data.title;
                            document.getElementById('detailStart').value = data.startDate;
                            document.getElementById('detailEnd').value = data.endDate;
                            if(data.location!=null){//필수 요소가 아니기때문에 확인작업
                            	document.getElementById('detailLocation').value= data.location;//위치 input창에 값 넣어주기
                            	
                            	//map 띄워주기 위한 카카오 api script
                            	var mapContainer = document.getElementById('map'); // 지도를 표시할 div
                            	mapContainer.style.width = '100%';
                                mapContainer.style.height = '350px';
                            	var mapOption = {
                                    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                                    level: 3 // 지도의 확대 레벨
                                };  
                                 
                                // 지도를 생성합니다    
                                var map = new kakao.maps.Map(mapContainer, mapOption); 
								
                                function relayout(){
                                	map.relayout();
                                }
                                // 주소-좌표 변환 객체를 생성합니다
                                var geocoder = new kakao.maps.services.Geocoder();
                               
                                // 주소로 좌표를 검색합니다
                                geocoder.addressSearch(data.location, function(result, status) {
                                	 
                                    // 정상적으로 검색이 완료됐으면 
                                     if (status === kakao.maps.services.Status.OK) {

                                        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                                        // 결과값으로 받은 위치를 마커로 표시합니다
                                        var marker = new kakao.maps.Marker({
                                            map: map,
                                            position: coords
                                        });

                                        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                                        map.setCenter(coords);
                                    } 
                                });  
                            }
                            if(data.memo!=null){
	                            document.getElementById('detailMemo').value= data.memo;
                            }
                            document.getElementById('detailUserId').value= data.userId;
                          
                            detailModal.show();
                		},
                		error:function(){
                			console.log("통신실패");
                		}
                	}); 
                },
                locale: 'ko',
                events: function(fetchInfo, successCallback, failureCallback) {
                    $.ajax({
                        url: "selectSchedule.sc", 
                        method: "GET",
                        dataType: "json",
                        success: function(data) {
                            var events = [];
                            data.forEach(function(event) {
                                events.push({
                                    id: event.scheduleNo,
                                    title: event.title,
                                    start: event.startDate,
                                    end: event.endDate,
                                    description: event.memo
                                });
                            });
                            successCallback(events);
                        },
                        error: function() {
                            failureCallback();
                        }
                    });
                }
            });
            calendar.render();
        });

            // 일정 추가 폼 submit 시 이벤트 추가
            document.getElementById('addScheduleForm').addEventListener('submit', function(e) {
               e.preventDefault();

                // 폼 데이터 가져오기
                var title = document.getElementById('scheduleTitle').value;
                var start = document.getElementById('scheduleStart').value;
                var end = document.getElementById('scheduleEnd').value;
                var location = document.getElementById('scheduleLocation').value;
                var memo = document.getElementById('scheduleMemo').value;
				
                $.ajax({
                	url:"insertSchedule.sc",
                	type:"post",
                	data:{
                		title:title,
                		startDate:start,
                		endDate:end,
                		location:location,
                		memo:memo
                	},
                	success:function(result){
                		if(result>0){
                			alert('성공적으로 등록되었습니다.');
                		}else{
                			alert('등록 실패, 관리자에게 문의하세요.')
                		}
                	},
                	error:function(){
                		console.log("통신오류");
                	}
                });

                // 모달 창 닫기
                var scheduleModal = bootstrap.Modal.getInstance(document.getElementById('scheduleModal'));
                scheduleModal.hide();

                // 폼 초기화
                document.getElementById('addScheduleForm').reset();
                
                //
               	setTimeout(function() {
	                window.location.reload();
				}, 3000);
                
            });
            
            function searchAddress(){
            	var geocoder = new daum.maps.services.Geocoder();
            	new daum.Postcode({
                    oncomplete: function(data) {
                        var addr = data.address; // 최종 주소 변수

                        // 주소 정보를 해당 필드에 넣는다.
                        document.getElementById("scheduleLocation").value = addr;
                        // 주소로 상세 정보를 검색
                        geocoder.addressSearch(data.address, function(results, status) {
                            // 정상적으로 검색이 완료됐으면
                            if (status === daum.maps.services.Status.OK) {

                                var result = results[0]; //첫번째 결과의 값을 활용
                            }
                        });
                    }
                }).open();
            }
    	    
            function deleteSchedule(){
            	var scheduleNo = document.getElementById("detailScheduleNo").value;
            	location.href="deleteSchedule.sc?scheduleNo="+scheduleNo;
            }
	</script>
	  
</body>
</html>