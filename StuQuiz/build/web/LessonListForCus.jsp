<%-- 
    Document   : LessonList
    Created on : May 30, 2024, 1:48:22 PM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${subject.subjectName}</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <style>
            .container {
                width: 90%;
                max-width: 1200px;
                margin: 20px auto;
                display: flex;
            }
            .content {
                flex: 3;
                padding: 20px;
                border-radius: 8px;
                border: 1px solid black;
                box-shadow: 0 0 10px rgba(255, 255, 255, 0.4);
            }

            .content .button {
                background-color: white;
                border: none;
                font-size: 16px;
                cursor: pointer;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 4px;
                transition: box-shadow 0.3s ease;
                color: black;
            }

            .content .button:hover {
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .content .button:active {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .sidebar {
                flex: 1;
                margin-left: 20px;
            }
            .sidebar .card {
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(255, 255, 255, 0.4);
                border: 1px solid black;
                margin-bottom: 20px;
            }
            
            .course-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                border-bottom: 1px solid #ddd;
                padding-bottom: 10px;
                margin-bottom: 20px;
            }
            .course-header h1 {
                margin: 0;
                font-size: 24px;
            }
            .course-header .rating {
                font-size: 18px;
            }
            .curriculum, .related-courses {
                margin-top: 20px;
            }
            .curriculum h2, .related-courses h2 {
                font-size: 20px;
                margin-bottom: 10px;
            }
            .curriculum ul, .related-courses ul {
                list-style-type: none;
                padding: 0;
            }
            .curriculum li, .related-courses li {
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-bottom: 10px;
                display: flex;
                justify-content: space-between;
            }
            .related-courses img {
                max-width: 100%;
                border-radius: 4px;
            }
            .related-courses li {
                display: flex;
                align-items: center;
            }
            .related-courses .course-info {
                margin-left: 10px;
            }
            .related-courses .course-info h3 {
                margin: 0;
                font-size: 16px;
            }
            .related-courses .course-info p {
                margin: 5px 0 0;
                text-align: right;
                color: #777;
            }
            .enroll-button {
                display: block;
                background-color: #007bff;
                color: #fff;
                text-align: center;
                padding: 10px;
                border-radius: 4px;
                text-decoration: none;
            }
            .course-details {
                margin-top: 20px;
            }
            .course-details h3 {
                margin-bottom: 10px;
                font-size: 18px;
            }
            .course-details ul {
                list-style-type: none;
                padding: 0;
            }
            .course-details li {
                margin-bottom: 10px;
            }
            .form-switch .form-check-input:focus {
                border-color: rgba(255, 255, 255, 0.192);
                box-shadow: 0 0 0 0 rgba(0, 0, 0, 0);
                background-image: url("data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'><circle r='3' fill='rgba(0,0,0,0.25)'/></svg>");
            }

            .form-switch .form-check-input:checked {
                background-color: #30D158;
                border-color: #30D158;
                background-image: url("data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'><circle r='3' fill='rgba(255,255,255,1.0)'/></svg>");
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

        <div class="container">
            <div class="content">
                <div class="course-header">
                    <h1>${subject.subjectName}</h1>
                    <div class="rating">
                        <c:forEach var="vote" items="${totalVotes}">
                            <span style="font-weight: bold">${vote} rating</span><br>
                        </c:forEach>
                    </div>
                </div>

                <div class="curriculum">
                    <div class="d-flex justify-content-between align-items-center">
                        <h2>Curriculum</h2>
                        <c:if test="${subject.ownerId == sessionScope.userAuthorization.userId}">
                            <div class="btn-group" role="group">
                                <a style="margin-right: 10px;" href="./AddLesson?subjectId=${subject.subjectId}" class="btn btn-primary">Add Lesson</a>
                                <a href="./EditLesson?subjectId=${subject.subjectId}" class="btn btn-primary">Edit Lesson</a>
                                <a href="./question?action=show-question&subjectId=${subject.subjectId}" class="btn btn-primary" target="_blank">Add Question</a>
                            </div>
                        </c:if>
                    </div>
                    <br>
                    <c:set var="lectureCount" value="0" />
                    <c:forEach items="${listLesson}" var="listlesson">
                        <ul>
                            <li>
                                <span>${listlesson.lessonName}</span>
                                <form action="Lessons" method="get">
                                    <input type="hidden" name="actionCheck" value="viewLesson">
                                    <input type="hidden" name="lessonId" value="${listlesson.lessonId}">
                                    <button type="submit" class="button">Learn</button>
                                </form>
                            </li>
                        </ul>
                        <c:set var="lectureCount" value="${lectureCount + 1}" />
                    </c:forEach>
                </div>
            </div>

            <div class="sidebar">
                <div class="card">
                    <img style="max-height: 200px; max-width: 300px" src="${subject.subjectImage}">
                    <div class="course-details">
                        <h3>Course details</h3>
                        <ul>
                            <li>Lectures: ${lectureCount}</li>
                                <c:if test="${subject.subjectId == item.subjectId && sessionScope.userAuthorization.userId == item.buyerId}">
                                <li>${item.startDate} to ${item.endDate}</li>
                                </c:if>
                            <li>Access on mobile and TV</li>
                        </ul>
                    </div>
                </div>
                <div class="related-courses card">
                    <h2>Related Subject</h2>
                    <c:forEach items="${relatedSubject}" var="relatedSubject">
                        <ul>
                            <li>
                                <img style="max-width: 100px; max-height: 100px; min-height: 100px; min-width: 100px;" src="${relatedSubject.subjectImage}" alt="Course">
                                <div class="course-info">
                                    <a href="./Lessons?actionCheck=viewLessonList&subjectId=${relatedSubject.subjectId}">${relatedSubject.subjectName}</a>
                                    <p>${relatedSubject.subjectPrice}</p>
                                </div>
                            </li>
                        </ul>
                    </c:forEach>
                </div>
            </div>
        </div>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
                                   changeColorInputBox()
                                   function setCookie(name, value, days) {
                                       const expires = new Date();
                                       expires.setTime(expires.getTime() + (days * 24 * 60 * 60 * 1000));
                                       document.cookie = name + "=" + value + ";expires=" + expires.toUTCString() + ";path=/";
                                   }
    </script>
</html>