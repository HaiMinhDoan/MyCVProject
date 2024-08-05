<%-- 
    Document   : LessonDetail
    Created on : May 20, 2024, 5:03:24 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <style>
            .form-container {
                background-color: #2A2A2A;
                padding: 10px 50px;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .form-container label {
                font-size: 18px;
                margin: 10px 10px;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
                width: 100%;
            }

            .form-group label {
                font-weight: bold;
            }

            .form-control {
                border-radius: 15px;
                border-color: #ced4da;
                padding: 10px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 15px;
            }

            table,
            th,
            td {
                border: 1px solid #ddd;
            }

            th,
            td {
                padding: 10px;
                text-align: left;
            }

            td input[type="text"],
            td input[type="number"] {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
                border: none;
                margin: 0;
                background-color: #2A2A2A;
            }

            .form-actions {
                text-align: right;
            }

            .form-actions button {
                padding: 10px 20px;
                border: none;
                border-radius: 3px;
                background-color: #5cb85c;
                color: #fff;
                cursor: pointer;
            }

            .form-actions button[type="button"] {
                background-color: #d9534f;
            }

            .form-actions button+button {
                margin-left: 10px;
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

        <div class="container form-group form-container mt-5 col">
            <form id="lessonForm" action="AddLesson" method="post" onsubmit="return validateForm()">
                <input type="text" name="maxL" id="maxL" value="1" hidden="">
                <input type="hidden" name="subjectId" value="${subjectId}">
                <label for="lessons">Add Lesson</label>
                <div class="form-group">
                    <table>
                        <thead>
                            <tr>
                                <th>Lesson Name</th>
                                <th>Video Link</th>
                                <th>Description</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" name="lessonName1"></td>
                                <td><input type="text" name="videoLink1"></td>
                                <td><input type="text" name="lessonDescription1" readonly onclick="openDescriptionModal(this)"></td>
                                <td><button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)"><i class="fas fa-trash"></i></button></td>
                            </tr>
                        </tbody>
                    </table>
                    <button type="button" class="btn btn-primary" onclick="addRow()">Add Lesson</button>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary">Back</button>
                    <button type="submit" class="btn btn-success">Submit</button>
                </div>
            </form>
        </div>

        <!-- Description Modal -->
        <div class="modal fade" id="descriptionModal" tabindex="-1" aria-labelledby="descriptionModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="descriptionModalLabel">Add Description</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <textarea class="form-control" id="modalDescription" rows="5"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" onclick="saveDescription()">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let currentDescriptionInput;
            var i = 1;

            function addRow() {
                i++;
                document.getElementById("maxL").value = i;
                const table = document.querySelector('table tbody');
                const rowCount = table.rows.length;
                console.log(rowCount);
                const row = table.insertRow();

                const cell1 = row.insertCell(0);
                const cell2 = row.insertCell(1);
                const cell3 = row.insertCell(2);
                const cell4 = row.insertCell(3);

                cell1.innerHTML = '<input type="text" name="lessonName' + i + '">';
                cell2.innerHTML = '<input type="text" name="videoLink' + i + '">';
                cell3.innerHTML = '<input type="text" name="lessonDescription' + i + '" readonly onclick="openDescriptionModal(this)">';
                cell4.innerHTML = `<button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)"><i class="fas fa-trash"></i></button>`;
            }

            function removeRow(button) {
                const row = button.parentNode.parentNode;
                row.parentNode.removeChild(row)
                i--;
            }

            function openDescriptionModal(input) {
                currentDescriptionInput = input;
                const modal = new bootstrap.Modal(document.getElementById('descriptionModal'));
                document.getElementById('modalDescription').value = currentDescriptionInput.value;
                modal.show();
            }

            function saveDescription() {
                const modal = bootstrap.Modal.getInstance(document.getElementById('descriptionModal'));
                currentDescriptionInput.value = document.getElementById('modalDescription').value;
                modal.hide();
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
            changeColorInputBox()

            function setCookie(name, value, days) {
                const expires = new Date();
                expires.setTime(expires.getTime() + (days * 24 * 60 * 60 * 1000));
                document.cookie = name + "=" + value + ";expires=" + expires.toUTCString() + ";path=/";
            }

            function validateForm() {
                const inputs = document.querySelectorAll('input[type="text"]');
                for (let input of inputs) {
                    if (input.value.trim() === "") {
                        alert("Add lesson failed. Please fill in all fields.");
                        return false;
                    }
                }
                return true;
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </body>
</html>



