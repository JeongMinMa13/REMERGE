
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* style.css */
body {
    font-family: Arial, sans-serif;
    background-color: #fafafa;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.container {
    display: flex;
    max-width: 935px;
    width: 100%;
    justify-content: center;
    align-items: center;
}

.phone {
    display: none;
}

.phone img {
    max-width: 100%;
    height: auto;
}

.login-form {
    max-width: 350px;
    width: 100%;
    background: white;
    padding: 40px 20px;
    border: 1px solid #dbdbdb;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    text-align: center;
}

.login-form h1 {
    font-family: 'Billabong', cursive;
    font-size: 2.5rem;
    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 15px;
}

.form-group input {
    width: 100%;
    padding: 10px;
    border: 1px solid #dbdbdb;
    border-radius: 3px;
    background-color: #fafafa;
}

button[type="submit"] {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 3px;
    background-color: #3897f0;
    color: white;
    font-weight: bold;
    cursor: pointer;
    margin-bottom: 10px;
}

.divider {
    display: flex;
    align-items: center;
    text-align: center;
    margin: 10px 0;
}

.divider::before,
.divider::after {
    content: '';
    flex: 1;
    border-bottom: 1px solid #dbdbdb;
}

.divider::before {
    margin-right: .25em;
}

.divider::after {
    margin-left: .25em;
}

.facebook-login {
    background: none;
    border: none;
    color: #3897f0;
    font-weight: bold;
    cursor: pointer;
}

.facebook-login i {
    margin-right: 5px;
}

.forgot-password {
    color: #00376b;
    text-decoration: none;
    font-size: 12px;
    margin-top: 10px;
    display: block;
}

.forgot-password:hover {
    text-decoration: underline;
}

@media screen and (min-width: 600px) {
    .container {
        justify-content: space-between;
    }

    .phone {
        display: block;
    }
}


</style>
</head>
<body>

</body>

</html>