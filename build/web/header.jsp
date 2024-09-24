<%-- 
    Document   : header
    Created on : Sep 22, 2024, 4:52:24 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="header">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="home">
            <img src="./assets/drugstore.png" width="50" height="50" alt="">
        </a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">

                <li class="nav-item dropdown">
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </li>

                <li class="nav-item active">
                    <c:if test="${sessionScope.user != null}">
                        <a class="nav-link" href="ProductList?userName=${sessionScope.user.username}">Product List <span class="sr-only">(current)</span></a>
                    </c:if>
                </li>

                <li class="nav-item active">
                    <c:if test="${sessionScope.user == null}">
                        <a class="nav-link" href="login.jsp">Cart <span class="sr-only">(current)</span></a>
                    </c:if>
                    <c:if test="${sessionScope.user != null}">
                        <a class="nav-link" href="cart">Cart <span class="sr-only">(current)</span></a>
                    </c:if>
                </li>

            </ul>
            <form class="form-inline my-2 my-lg-0 search" action="Search" method="Get">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="name">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
            <c:if test="${sessionScope.user == null}">
                <form class="form-inline my-2 my-lg-0">
                    <a href="login.jsp" class="btn btn-outline-success my-2 my-sm-0 btn-nav">Login</a>
                    <a href="register.jsp" class="btn btn-outline-success my-2 my-sm-0 btn-nav">Register</a>
                </form>
            </c:if>
            <c:if test="${sessionScope.user != null}">
                <form class="form-inline my-2 my-lg-0">
                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            ${sessionScope.user.username}
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="profile.jsp">Profile</a>
                            <a class="dropdown-item" href="changepwd">Change Password</a>
                            <a class="dropdown-item" href="logout">Logout</a>
                        </div>
                    </div>
                </form>
            </c:if>
        </div>
    </nav>
</div>