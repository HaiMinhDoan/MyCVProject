<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<jsp:useBean id="getAnswer" class="root.DAO.AnswerDAO" />
<!DOCTYPE html>
<html>
    <head>
        <title>StuQuiz</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                padding-top: 56px;
            }
            header {
                background-color: #343a40;
                color: #fff;
                padding: 10px 15px;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
            }
            header h1 {
                margin: 0;
                font-size: 20px;
            }
            header .search-bar {
                margin-left: auto;
                margin-right: 15px;
                width: 200px;
                font-size: 14px;
                height: 30px;
                padding: 5px;
            }
            .main-content {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .form-select,
            .form-control {
                margin-bottom: 15px;
            }
            table th, table td {
                vertical-align: middle;
                text-align: center;
            }
            table img {
                max-width: 100px;
                height: auto;
            }
            .btn-group .btn {
                margin-right: 5px;
            }
            .btn-group .btn:last-child {
                margin-right: 0;
            }
        </style>
    </head>
    <body>
        <header class="d-flex align-items-center">
            <h1>StuQuiz</h1>
            <input type="text" class="form-control search-bar" placeholder="Search">
        </header>
        <div class="container main-content mt-5">
            <h2 class="mb-4">List Questions</h2>
            <div class="mb-3">
                <a href="question?action=add" class="btn btn-primary">Add new</a>
                <form id="formHome" action="HomePage" method="get"></form>
                <h2>Upload File Excel</h2>
                <form method="post" action="AddQuestionByExcel" enctype="multipart/form-data">
                    <input id="file" type="file" name="file" accept=".xls,.xlsx"/>
                    <input type="text" readonly name="subjectId" value="${currentSubject.subjectId}" hidden>
                    <button type="submit">Upload</button>
                </form>
                <a href="DownloadForm">DownLoad Form</a>
            </div>
            <div class="mb-3">
                <select onChange="filterQuestion(this.value)" class="form-select">
                    <option value="0">Choose subject</option>
                    <c:forEach items="${subjects}" var="subject">
                        <option value="${subject.subjectId}" ${typeSubject == subject.subjectId ? "selected" : ""}>${subject.subjectName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="table-responsive">
                <table id="questionTable" class="table table-bordered">
                    <thead>
                        <tr>
                            <th>.No</th>
                            <th>Level</th>
                            <th>Subject</th>
                            <th>Content</th>
                            <th>Answer</th>
                            <th>Image</th>
                            <th>Active</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${questions}" var="question" varStatus="status">
                        <form action="question?action=edit" method="post" class="mb-4">
                            <tr id="question-${question.questionId}">
                                <td>${status.index + 1}</td>
                                <td>
                                    <select id="levelId" name="levelId" class="form-select">
                                        <option value="1" ${question.questionLevel == 1 ? "selected" : ""}>1</option>
                                        <option value="2" ${question.questionLevel == 2 ? "selected" : ""}>2</option>
                                        <option value="3" ${question.questionLevel == 3 ? "selected" : ""}>3</option>
                                    </select>
                                </td>
                                <td>
                                    <select name="subjectId" class="form-select">
                                        <c:forEach items="${subjects}" var="subject">
                                            <option value="${subject.subjectId}" ${typeSubject == subject.subjectId ? "selected" : ""}>${subject.subjectName}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <textarea name="questionContent" id="question1" rows="3" class="form-control" placeholder="Enter question here">${question.questionContent}</textarea>
                                </td>
                                <td>
                                    <c:set var="answers" value="${getAnswer.getAnswerByQuestion(question.questionId)}" />
                                    <c:forEach items="${answers}" var="item">
                                        <div class="form-check">
                                            <input type="radio" id="answer1a_correct" value="${item.answerId}" name="correct" class="form-check-input" ${item.isTrue() ? "checked" : ""}>
                                            <input name="answer-text-${item.answerId}" type="text" id="answer1a" class="form-control" placeholder="Answer here" value="${item.answerContent}">
                                        </div>
                                    </c:forEach>
                                </td>
                                <td>
                                    <input type="text" id="image1" name="questionImage" class="form-control" placeholder="Enter image URL" value="${question.questionImage}">
                                    <img src="${question.questionImage}" class="mt-2" alt="Image"/>
                                </td>
                                <td>
                                    <select name="isActive" class="form-select">
                                        <option value="true" ${question.isActive() ? "selected" : ""}>Active</option>
                                        <option value="false" ${!question.isActive() ? "selected" : ""}>Hidden</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="hidden" value="${question.questionId}" name="questionId">
                                    <input type="hidden" value="${typeSubject}" name="subjectIdBack">
                                    <div class="btn-group" role="group">
                                        <button class="btn btn-warning" type="submit" name="btn-edit-question">Edit</button>
                                        <a onclick="return confirm('Are you sure to delete this question?')" href="question?action=delete&subjectId=${typeSubject}&questionId=${question.questionId}" class="btn btn-danger">Delete</a>
                                    </div>
                                </td>
                            </tr>
                        </form>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <form action="quizHome" method="get" class="mt-4">
                <input type="submit" value="Back to Home" class="btn btn-secondary">
            </form>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>
                                            const filterQuestion = (id) => {
                                                const myHost = location.host;
                                                const hre = "http://" + myHost + "/StuQuiz/question?action=show-question&subjectId=" + id;
                                                window.location.href = hre;
                                            }
                                            window.onload = function () {
                                                const editedQuestionId = "${param.questionId}";
                                                const message = "${param.message}";
                                                const success = "${param.success}";
                                                const error = "${param.error}";


                                                if (editedQuestionId) {
                                                    const getToView = document.getElementById('question-' + editedQuestionId);
                                                    if (getToView) {
                                                        getToView.scrollIntoView();
                                                    }


                                                }


                                                if (message) {
                                                    if (success === 'true') {
                                                        swal({
                                                            title: "Success!",
                                                            text: message,
                                                            icon: "success",
                                                            button: "OK",
                                                        });
                                                    } else if (error === 'true') {
                                                        swal({
                                                            title: "Error!",
                                                            text: message,
                                                            icon: "error",
                                                            button: "OK",
                                                        });
                                                    }
                                                }
                                            }
        </script>
    </body>
</html>