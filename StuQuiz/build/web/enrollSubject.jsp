<%-- 
    Document   : enrollSubject
    Created on : Jun 19, 2024, 11:58:29 PM
    Author     : vtdle
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer">       
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stuquiz - Enroll Subject</title>
        <style>
            .card {
                border: 1px solid #ddd;
                border-radius: 8px;
                margin-bottom: 20px;
                overflow: hidden;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            .card-body {
                padding: 20px;
            }

            .card-code, .card-title {
                font-size: 18px;
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
                text-align: center;
            }

            .card-text {
                font-size: 16px;
                line-height: 1.6;
                margin-bottom: 15px;
                color: #666;
            }

            .card-img {
                max-width: 100%;
                height: auto;
                display: block;
                margin: 0 auto;
                border-radius: 8px 8px 0 0;
            }

            .btn-primary {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                border-radius: 5px;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            .enroll-btn {
                background-color: #28a745;
                color: #fff;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                border-radius: 5px;
            }

            .enroll-btn:hover {
                background-color: #218838;
            }

            .title-enroll ,h1{
                text-align: center;
                color: red;
                margin: 5%;
            }

            .enroll-container{
                text-align: center;
                margin-bottom: 5%;
            }

            .card-img {
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
                height: 200px;
                object-fit: cover;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg bg-body-tertiary container">
            <div class="container-fluid">
                <a class="navbar-brand" href="./HomePage">StuQuiz</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="search navbar-collapse" id="navbarSupportedContent"
                     style="display: flex; flex-direction: row-reverse;">

                    <ul class="navbar-nav ml-auto mb-3 mb-lg-0" style="">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                               aria-expanded="false">
                                <c:if test="${sessionScope.userAuthorization==null}">
                                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGU0uf9RH5npQE6jWFRwRHNWoTTyy4NuxPo0rzkJm8tA&s"
                                         alt="" style="height: 30px;width: 30px; border-radius: 50%;">
                                </c:if>
                                <c:if test="${sessionScope.userAuthorization!=null}">
                                    <img src="https://gcs.tripi.vn/public-tripi/tripi-feed/img/474074hYy/anh-nen-hoa-anh-dao-dep-nhat_025505349.jpg"
                                         alt="" style="height: 30px;width: 30px; border-radius: 50%;">
                                </c:if>
                            </a>
                            <ul class="dropdown-menu">
                                <c:if test="${sessionScope.userAuthorization!=null}">
                                    <li><a class="dropdown-item" href="./ViewProfile">View Profile</a></li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.userAuthorization!=null}">
                                    <li><a class="dropdown-item" href="./Logout">Logout</a></li>
                                    </c:if>
                                    <c:if test="${sessionScope.userAuthorization==null}">
                                    <li><a class="dropdown-item"
                                           href="./Account">Login/Register</a></li>
                                    </c:if>
                            </ul>
                        </li>
                    </ul>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked"
                               onchange="switchTheme()">
                    </div>
                </div>
            </div>
        </nav>
        <h1 class="title-enroll"><strong>CHOOSE YOUR PATH & LEARN TOGETHER!</strong></h1>
        <div class="container" style="display: flex; justify-content: center; align-content: center;">   
            <c:forEach var="subjectEnrolledAndStatus" items="${subjects}">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-code">${subjectEnrolledAndStatus.subject.subjectCode}</h5>
                        <img src="${subjectEnrolledAndStatus.subject.subjectImage}" class="card-img-top card-img" alt="Subject-Img">
                        <div class="card-body">
                            <h5 class="card-title">${subjectEnrolledAndStatus.subject.subjectName}</h5>
                            <p class="card-text">${subjectEnrolledAndStatus.subject.subjectDescription}</p>
                            <p class="card-text">Price:
                                <c:choose>
                                    <c:when test="${subjectEnrolledAndStatus.salePrice != null && subjectEnrolledAndStatus.salePrice > 0}">
                                        <span style="text-decoration: line-through;">${subjectEnrolledAndStatus.subject.subjectPrice} VND</span>                               
                                        <span style="color: red;">
                                            <c:out value="${subjectEnrolledAndStatus.subject.subjectPrice * subjectEnrolledAndStatus.salePrice / 100}"/> VND                                           
                                        </span>
                                        <span style="color: green;">(${100 - subjectEnrolledAndStatus.salePrice}%) off</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: red;">${subjectEnrolledAndStatus.subject.subjectPrice} VND</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>                         
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="container" style="display: flex; justify-content: center; align-content: center;">
            <c:forEach var="subjectEnrolledAndStatus" items="${subjects}">
                <form id="enrollForm${subjectEnrolledAndStatus.subject.subjectId}" action="BuySubjectPage" method="get" >
                    <input type="hidden" name="subjectId" value="${subjectEnrolledAndStatus.subject.subjectId}">
                    <input type="radio" name="amount" value="1" id="v3" checked="">  <label for="v3">3 Mounths</label>
                    <input type="radio" name="amount" value="2" id="v6">  <label for="v6">6 Mounths</label>
                    <input type="hidden" name="subjectName" value="${subjectEnrolledAndStatus.subject.subjectName}">                        
                    <button type="submit" class="btn btn-primary enroll-btn">Enroll</button>
                </form>
            </c:forEach>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
    <script>
                                   function switchTheme() {
                                       var checked = document.getElementById("flexSwitchCheckChecked").checked;
                                       console.log('Da xu ly qua day');
                                       if (checked) {
                                           document.documentElement.setAttribute("data-bs-theme", "light");
                                           changeColorInputBox()
                                           setCookie('currentTheme', 'light', 1);
                                       } else {
                                           document.documentElement.setAttribute("data-bs-theme", "dark");
                                           changeColorInputBox()
                                           setCookie('currentTheme', 'dark', 1);
                                       }
                                   }
                                   const getPreferredTheme = () => {
                                       return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
                                   }

                                   const setTheme = theme => {
                                       if (document.cookie.includes('currentTheme=light') || document.cookie.includes('currentTheme=dark')) {
                                           document.getElementById("flexSwitchCheckChecked").checked = (document.cookie.includes('currentTheme=light'));
                                           document.documentElement.setAttribute('data-bs-theme', document.cookie.includes('currentTheme=light') ? 'light' : 'dark');
                                       } else {
                                           if (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
                                               document.documentElement.setAttribute('data-bs-theme', 'dark')
                                           } else {
                                               document.documentElement.setAttribute('data-bs-theme', theme);
                                           }
                                       }
                                   }
                                   setTheme(getPreferredTheme());
                                   function setCookie(name, value, days) {
                                       const expires = new Date();
                                       expires.setTime(expires.getTime() + (days * 24 * 60 * 60 * 1000));
                                       document.cookie = name + "=" + value + ";expires=" + expires.toUTCString() + ";path=/";
                                   }

    </script>
</html>

