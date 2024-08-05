<%-- 
    Document   : AddQuiz
    Created on : Jul 26, 2024, 4:32:21 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Quiz</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <style>
            .container {
                width: 90%;
                max-width: 1200px;
                margin: 20px auto;
            }

            .content {
                max-width: 1200px;
                margin: 20px auto;
                width: 90%;
                padding: 10px;
                border-radius: 8px;
                border: 1px solid black;
                box-shadow: 0 0 10px rgba(255, 255, 255, 0.4);
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .checkbox-container {
                display: flex;
                align-items: center;
            }
            .checkbox-container p {
                margin: 0 10px;
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
                                    <li><a class="dropdown-item" href="#">View Profile</a></li>
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
        <br><br>

        <div class="content">
            <div class="container form-group form-container mt-5 col">
                <h2>Add Quiz to Lesson</h2>
                <br>
                <form action="AddQuiz" method="post">
                    <input type="text" name="lessonId" value="${lessonId}" hidden="">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizName">Quiz Name:</label>
                                <input type="text" class="form-control" id="quizName" name="quizName" required>
                            </div>
                            <div class="form-group">
                                <label for="quizLevel">Quiz Level:</label>
                                <input type="text" class="form-control" id="quizLevel" name="quizLevel" required>
                            </div>
                            <div class="form-group">
                                <label for="quizDuration">Quiz Duration (minutes):</label>
                                <input type="number" class="form-control" id="quizDuration" name="quizDuration" required>
                            </div>
                            <div class="form-group">
                                <label for="passRate">Pass Rate (%):</label>
                                <input type="number" class="form-control" id="passRate" name="passRate" required>
                            </div>
                            <div class="form-group">
                                <label for="quizType">Quiz Type:</label>
                                <select class="form-control" id="quizType" name="quizType" required>
                                    <option value="1">Easy</option>
                                    <option value="2">Medium</option>
                                    <option value="3">Hard</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizDescription">Quiz Description:</label>
                                <textarea class="form-control" id="quizDescription" name="quizDescription" rows="3" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="numEasyQuestions">Number of Easy Questions:</label>
                                <input type="number" class="form-control" id="numEasyQuestions" name="eQuestion" required>
                            </div>
                            <div class="form-group">
                                <label for="numMediumQuestions">Number of Medium Questions:</label>
                                <input type="number" class="form-control" id="numMediumQuestions" name="mQuestion" required>
                            </div>
                            <div class="form-group">
                                <label for="numHardQuestions">Number of Hard Questions:</label>
                                <input type="number" class="form-control" id="numHardQuestions" name="hQuestion" required>
                            </div>
                        </div>
                    </div>
                    <input type="text" name="arrayBank" value="" id="arrayBank">
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary mt-3">Submit</button>
                    </div>
                </form>

                <h5>Select Question to Exam</h5>
                <br>

                <c:forEach var="question" items="${questionList}">
                    <div class="checkbox-container">
                        <input type="checkbox" id="option1" name="examOption" value="option1" onclick="addArray(${question.questionId})">
                        <p>${question.questionContent}<p>
                    </div>
                </c:forEach>
            </div>

        </div>

        <script>
            var arrayBank = new Array();
            function addArray(questionId) {
                var count = 0;
                var check = true;
                arrayBank.forEach(function (element) {
                    if (element === questionId) {
                        var tempArr = arrayBank.splice(count, 1);
                        check = false;
                    }
                    count++;
                });
                if (check) {
                    arrayBank.push(questionId);
                }
                count = 0;
                arrayBank.forEach(function (element) {
                    if (count === 0) {
                        document.getElementById("arrayBank").value = element.toString();
                    } else {
                        document.getElementById("arrayBank").value += ("," + element.toString());
                    }
                    count++;
                });
            }
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
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </body>
</html>