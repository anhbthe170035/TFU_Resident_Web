<%-- 
    Document   : register
    Created on : Sep 22, 2024, 10:34:16 PM
    Author     : Admin
--%>

<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <link rel="stylesheet" href="./assets/logincss.css">
        <title>DRUGSTORE</title>
    </head>
    <body>
        <div id="logreg-forms">
            <form action="register" class="form-register" style="display: block" method="post">
                <h1 class="h3 mb-3 font-weight-normal" style="text-align: center"> Register</h1>
                <input type="text" id="username" class="form-control" placeholder="Username" required autofocus="" name="username">
                <br/>
                <input type="email" id="email" class="form-control" placeholder="Email" required autofocus="" name="email">
                <br/>
                <input type="password" id="password" class="form-control" placeholder="Password" required autofocus="" name="password">
                <br/>
                <input type="password" id="repeatpassword" class="form-control" placeholder="Reset Password" required autofocus="" name="re_password">
                <br/>
                <h6>${error}</h6>
                <button class="btn btn-primary btn-block" type="submit"><i class="fas fa-user-plus"></i> Register</button>

            </form>
            <br>

        </div>
        <!--        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>-->

    </body>
</html>

