<%-- 
    Document   : ExamPage
    Created on : Jun 6, 2024, 7:57:36 AM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <style>
            .count-time {
                color: red;
                margin-top: 300px;
                margin-left: 100px;
                font-weight: 500;
                font-size: larger;
            }

            .question-img {
                width: 480px;
                height: 250px;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg bg-body-tertiary container">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">StuQuiz</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked"
                           onchange="switchTheme()">
                </div>
            </div>
        </nav>
        <span class="count-time position-fixed top-1 mb-3" id="count-time" style="z-index: 9999;">${customizeExam.quiz.quizDuration>9?(customizeExam.quiz.quizDuration+""):("0"+customizeExam.quiz.quizDuration)}:00</span>
        <h1 class="container" style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
            ${customizeExam.quiz.quizName}</h1> <br><br>
        <div class="container" style="color: red;display: flex; flex-direction: column; justify-content: center; align-items: center;font-weight: 500; font-size: larger;">${customizeExam.quiz.quizDescription}</div>
        <br><br><br>
        <%int a=0;%>
        <form action="ExamPage" class="container" method="post" id="form-exam">
            <input type="text" name="quizId" id="" value="${customizeExam.quiz.quizId}" hidden>
            <input type="text" name="passRate" value="${customizeExam.quiz.passRate}" hidden>
            <input type="text" id="quizDuration" name="quizDuration" value="${customizeExam.quiz.quizDuration}" hidden readonly>
            <c:forEach items="${customizeExam.listCusQuestions}" var="cusQuestion">
                <%a++;%>
                <div class="question-combo" id="question-combo-<%=a%>">
                    <div class="question-content"><%=a%>. ${cusQuestion.question.questionContent}</div><br><br>
                    <c:if test='${cusQuestion.question.questionImage!=null&&cusQuestion.question.questionImage!=""}'>
                        <img src="https://img.pikbest.com/ai/illus_our/20230418/64e0e89c52dec903ce07bb1821b4bcc8.jpg!w700wp" alt="ảnh đẹp" class="question-img">
                    </c:if>
                    <div hidden><input type="radio" name="question_<%=a%>" id="anwser-id-${answer.answerId}" value="${cusQuestion.question.questionId}_0" checked></div>
                        <c:forEach items="${cusQuestion.listAnswers}" var="answer">
                        <div><input type="radio" name="question_<%=a%>" id="anwser-id-${answer.answerId}" value="${cusQuestion.question.questionId}_${answer.answerId}"> 
                            <label for="anwser-id-${answer.answerId}">${answer.answerContent}</label></div>
                        </c:forEach>
                </div><br><br>
            </c:forEach>
            <input type="text" name="numberOfQuestions" value="<%=a%>" hidden>
            <div class="container"
                 style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
                <button class="btn btn-danger" type="button" onclick="submitExam()">Submit</button>
            </div>
            <br><br><br><br>
        </form>
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
                    function setCookie(name, value, days) {
                        const expires = new Date();
                        expires.setTime(expires.getTime() + (days * 24 * 60 * 60 * 1000));
                        document.cookie = name + "=" + value + ";expires=" + expires.toUTCString() + ";path=/";
                    }

                    function submitExam() {
                        let userChoice = window.confirm("Do you want to finish?");
                        if (userChoice)
                            document.getElementById("form-exam").submit();
                    }
                    var duration = document.getElementById("quizDuration").value;
                    var endTime = new Date().getTime() + (parseInt(duration) * 60 + 1) * 1000;

                    var x = setInterval(function () {
                        var now = new Date().getTime();
                        var distance = endTime - now;
                        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                        var seconds = Math.floor((distance % (1000 * 60)) / 1000);
                        document.getElementById("count-time").innerHTML = minutes + ":" + seconds;

                        if (distance < 0) {
                            document.getElementById("count-time").innerHTML = "Hết giờ!";
                        }
                        if (distance <= -1000) {
                            clearInterval(x);
                            document.getElementById("form-exam").submit();
                        }
                    }, 1000);
    </script>

</html>
