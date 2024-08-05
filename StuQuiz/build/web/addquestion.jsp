<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>StuQuiz</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                padding-top: 56px;
            }
            header {
                background-color: #333;
                color: #fff;
                padding: 10px 15px; /* Reduced padding */
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
            }
            header h1 {
                margin: 0;
                font-size: 20px; /* Reduced font size */
            }
            header .search-bar {
                margin-left: auto;
                margin-right: 15px; /* Reduced margin */
                width: 200px; /* Adjust width if needed */
                font-size: 14px; /* Reduced font size */
                height: 30px; /* Reduced height */
                padding: 5px; /* Reduced padding */
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
            <h2 class="mb-4">Quiz Questions</h2>
            <div class="mb-3">
                <a href="question?action=add" class="btn btn-primary">Add new</a>
            </div>
            <div class="mb-3">
                <select onChange="filterQuestion(this.value)" class="form-select">
                    <option value="0">Choose subject</option>
                    <c:forEach items="${SUBJECT}" var="subject">
                        <option value="${subject.subjectId}">${subject.subjectName}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="color: green">${MESSAGE}</div>
            <div style="color: red">${ERROR}</div>
            <div class="table-responsive">
                <table id="questionTable" class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Subject</th>
                            <th>Level</th>
                            <th>Question</th>
                            <th>Answers</th>
                            <th>Image</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <form action="question" method="post">
                                <input type="hidden" name="action" value="add"/>
                                <td>
                                    <select id="subjectId" name="subjectId" class="form-select">
                                        <c:forEach items="${SUBJECT}" var="s">
                                            <option value="${s.subjectId}">${s.subjectName}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <select id="levelId" name="levelId" class="form-select">
                                        <option value="1">1</option>          
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                    </select>
                                </td>
                                <td>
                                    <textarea id="question1" rows="3" class="form-control" name="content" placeholder="Enter question here"></textarea>
                                </td>
                                <td>
                                    <div class="form-check">
                                        <input type="radio" name="correct" value="1" class="form-check-input" id="answer1a_correct">
                                        <input name="answer-1" type="text" class="form-control" id="answer1a" placeholder="Answer 1"><br>
                                    </div>
                                    <div class="form-check">
                                        <input type="radio" name="correct" value="2" class="form-check-input" id="answer1b_correct">
                                        <input name="answer-2" type="text" class="form-control" id="answer1b" placeholder="Answer 2"><br>
                                    </div>
                                    <div class="form-check">
                                        <input type="radio" name="correct" value="3" class="form-check-input" id="answer1c_correct">
                                        <input name="answer-3" type="text" class="form-control" id="answer1c" placeholder="Answer 3"><br>
                                    </div>
                                    <div class="form-check">
                                        <input type="radio" name="correct" value="4" class="form-check-input" id="answer1d_correct">
                                        <input name="answer-4" type="text" class="form-control" id="answer1d" placeholder="Answer 4">
                                    </div>
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="image1" name="imageURL" placeholder="Enter image URL">
                                </td>
                                <td>
                                    <button type="submit" class="btn btn-success">Save</button>
                                    <button type="button" class="btn btn-secondary" onclick="addNewQuestion()">New Question</button>
                                </td>
                            </form>
                        </tr>
                    </tbody>
                </table>
            </div>
            <form action="quizHome" method="get">
                <input type="submit" value="Back to Home" class="btn btn-secondary mt-4">
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
        <script>
            let questionCount = 2;


            function saveQuestion(questionNum) {
                const level = document.getElementById(`level${questionNum}`).value;
                const question = document.getElementById(`question${questionNum}`).value;
                const answers = [
                    {
                        text: document.getElementById(`answer${questionNum}a`).value,
                        correct: document.getElementById(`answer${questionNum}a_correct`).checked
                    },
                    {
                        text: document.getElementById(`answer${questionNum}b`).value,
                        correct: document.getElementById(`answer${questionNum}b_correct`).checked
                    },
                    {
                        text: document.getElementById(`answer${questionNum}c`).value,
                        correct: document.getElementById(`answer${questionNum}c_correct`).checked
                    },
                    {
                        text: document.getElementById(`answer${questionNum}d`).value,
                        correct: document.getElementById(`answer${questionNum}d_correct`).checked
                    }
                ];
                const imageUrl = document.getElementById(`image${questionNum}`).value;


                console.log(`Saving question ${questionNum}:`);
                console.log(`Level: ${level}`);
                console.log(`Question: ${question}`);
                console.log(`Answers:`);
                answers.forEach((answer, index) => {
                    console.log(`${index + 1}. ${answer.text} (Correct: ${answer.correct})`);
                });
                console.log(`Image URL: ${imageUrl}`);
            }


            function addNewQuestion() {
                const table = document.getElementById('questionTable').getElementsByTagName('tbody')[0];
                const row = table.insertRow(-1);
                const cell1 = row.insertCell(0);
                const cell2 = row.insertCell(1);
                const cell3 = row.insertCell(2);
                const cell4 = row.insertCell(3);
                const cell5 = row.insertCell(4);
                const cell6 = row.insertCell(5);


                cell1.innerHTML = `
                    <select id="subjectId${questionCount}" name="subjectId" class="form-select">
                        <c:forEach items="${SUBJECT}" var="s">
                            <option value="${s.subjectId}">${s.subjectName}</option>
                        </c:forEach>
                    </select>
                `;
                cell2.innerHTML = `
                    <select id="level${questionCount}" name="levelId" class="form-select">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                    </select>
                `;
                cell3.innerHTML = `<textarea id="question${questionCount}" rows="3" class="form-control" placeholder="Enter question here"></textarea>`;
                cell4.innerHTML = `
                    <div class="form-check">
                        <input type="radio" name="correct${questionCount}" value="1" class="form-check-input" id="answer${questionCount}a_correct">
                        <input type="text" class="form-control" id="answer${questionCount}a" placeholder="Answer 1"><br>
                    </div>
                    <div class="form-check">
                        <input type="radio" name="correct${questionCount}" value="2" class="form-check-input" id="answer${questionCount}b_correct">
                        <input type="text" class="form-control" id="answer${questionCount}b" placeholder="Answer 2"><br>
                    </div>
                    <div class="form-check">
                        <input type="radio" name="correct${questionCount}" value="3" class="form-check-input" id="answer${questionCount}c_correct">
                        <input type="text" class="form-control" id="answer${questionCount}c" placeholder="Answer 3"><br>
                    </div>
                    <div class="form-check">
                        <input type="radio" name="correct${questionCount}" value="4" class="form-check-input" id="answer${questionCount}d_correct">
                        <input type="text" class="form-control" id="answer${questionCount}d" placeholder="Answer 4">
                    </div>
                `;
                cell5.innerHTML = `<input type="text" id="image${questionCount}" class="form-control" placeholder="Enter image URL">`;
                cell6.innerHTML = `
                    <button type="button" class="btn btn-success" onclick="saveQuestion(${questionCount})">Save</button>
                    <button type="button" class="btn btn-secondary" onclick="addNewQuestion()">New Question</button>
                `;


                questionCount++;
            }
        </script>
    </body>
</html>