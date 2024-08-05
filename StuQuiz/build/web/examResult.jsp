<%-- 
    Document   : examResult
    Created on : Jun 23, 2024, 9:51:39 PM
    Author     : vtdle
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stuquiz - View List Exam Results</title>      
    </head>
    <body>
        <div class="container mt-5">
            <h1 class="mb-4">List Exam Results</h1>
            <h2>Student name: ${user.userName}</h2>
            <h3>${quiz.quizName}</h3>
            <h5>Time limit: ${quiz.quizDuration} min</h5>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Attempt</th>                       
                        <th>Exam Rate</th>
                        <th>Marks / ${quiz.getEQuestion() + quiz.getMQuestion() + quiz.getHQuestion()}</th>
                        <th>Is pass</th>
                        <th>Review</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="examResult" items="${examResults}">
                        <tr>
                            <td>${examResult.exam.examId}</td>                          
                            <td><fmt:formatNumber value="${(examResult.totalMarks / (quiz.getEQuestion() + quiz.getMQuestion() + quiz.getHQuestion())) * 100}" pattern="#0.00" />%</td>          
                            <td>${examResult.totalMarks}</td>
                            <td>${examResult.exam.examRate >= 5.00 ? 'Pass' : 'Fail'}</td>
                            <td><a href="ViewResultDetail?examId=${examResult.exam.examId}&userId=${user.userId}&quizId=${quiz.quizId}" class="text-danger" target="_blank">Review</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="mt-4">   
                <h4>Highest grade: <fmt:formatNumber value="${maxExamRate*10}" pattern="#0.00" /> / 10.00</h4>
                <a class="btn btn-primary" target="_blank" href="ExamPage?quizId=${quiz.quizId}">${examResults.size()>0?"RE-ATTEMPT QUIZ":"ATTEMPT QUIZ"}</a>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>       
    </body>
</html>


