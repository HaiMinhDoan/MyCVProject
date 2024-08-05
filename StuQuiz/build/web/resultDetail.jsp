<%-- 
    Document   : resultDetail
    Created on : Jun 30, 2024, 4:21:43 PM
    Author     : vtdle
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stuquiz - View Result Detail</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 20px;
            }
            .table {
                margin-top: 20px;
            }
            .correct-answer {
                background-color: #fff3cd;
                border-radius: 5px;
                padding: 5px;
            }
            .question-title {
                font-size: 1.5rem;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .question-container {
                margin-bottom: 20px;
            }
            .question-text {
                padding-right: 20px;
            }
            .answer-cell {
                border-right: 1px solid #ccc;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>${examResultDetail.quiz.quizName}</h1>
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-bordered">
                        <tr>
                            <th>Time limit</th>
                            <td>${examResultDetail.quiz.quizDuration} min</td>
                        </tr>
                        <tr>
                            <th>Marks</th>
                            <td>${examResult.totalMarks} / ${examResultDetail.quiz.getEQuestion() + examResultDetail.quiz.getMQuestion() + examResultDetail.quiz.getHQuestion()}</td>
                        </tr>
                        <tr>
                            <th>Grade</th>
                            <td>
                                <strong>
                                    <fmt:formatNumber value="${examResultDetail.exam.examRate*10}" pattern="#0.00" />
                                </strong> 
                                out of 10.00 
                                (<strong>
                                    <fmt:formatNumber value="${(examResult.totalMarks / (examResultDetail.quiz.getEQuestion() + examResultDetail.quiz.getMQuestion() + examResultDetail.quiz.getHQuestion())) * 100}" pattern="#0.00" />%
                                </strong>)
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="table-result-detail">
                <c:forEach items="${examResultDetail.listResultObjects}" var="reObjcet" varStatus="loop">
                    <table class="table table-bordered">
                        <tr class="question-container">
                            <td colspan="2">
                                <h2 class="question-title">Question ${loop.index + 1}</h2>
                            </td>
                        </tr>
                        <tr class="question-container">
                            <td class="col-md-3 question-text">
                                <c:forEach items="${reObjcet.customQuestion.listAnswers}" var="answer">
                                    <c:if test="${answer.answerId == reObjcet.selectAnswer}">
                                        <p>${answer.isTrue() ? "True" : "False"}</p>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${reObjcet.selectAnswer==0}">
                                    <p>False</p>
                                </c:if>
                            </td>
                            <td class="col-md-9 answer-cell">
                                <ul class="list-unstyled">
                                    <li>
                                        <strong>${reObjcet.customQuestion.question.questionContent}</strong>
                                    </li>
                                    <c:if test="${not empty reObjcet.customQuestion.question.questionImage}">
                                        <li>
                                            <img src="${reObjcet.customQuestion.question.questionImage}" alt="Question-Image" />
                                        </li><hr>
                                    </c:if>
                                    <c:forEach items="${reObjcet.customQuestion.listAnswers}" var="answer">
                                        <li ${answer.isTrue() ? "class='correct-answer'" : ""}>
                                            <input type="radio" name="q${loop.index + 1}" disabled ${answer.answerId == reObjcet.selectAnswer ? "checked" : ""}>${answer.answerContent}
                                        </li>
                                    </c:forEach>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </c:forEach>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>