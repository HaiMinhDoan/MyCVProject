<%-- 
    Document   : course
    Created on : Jul 3, 2024, 10:57:01 AM
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
        <title>Stuquiz - Course</title>
        <style>
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.4);
            }

            .modal-content {
                background-color: #fefefe;
                margin: 15% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 100%;
                max-width: 500px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .modal-header, .modal-body, .modal-footer {
                padding: 20px;
            }

            .modal-header {
                border-bottom: 1px solid #dee2e6;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .modal-title {
                margin: 0;
                font-size: 20px;
            }

            .close {
                background: none;
                border: none;
                font-size: 20px;
                cursor: pointer;
            }

            .modal.show {
                display: block;
            }

            .btn-primary {
                background-color: #007bff;
                border: none;
            }

            .btn-secondary {
                background-color: #6c757d;
                border: none;
            }

            .btn-danger {
                background-color: #dc3545;
                border: none;
            }
        </style>
    </head>
    <body>
        <% int count = 1; %>
        <div class="container">
            <h1 style="margin-bottom: 20px">Course List</h1>
            <c:if test="${sessionScope.userAuthorization!=null&&sessionScope.userAuthorization.roleLevel==1}">
                <div class="container">
                    <button type="button" class="btn btn-primary" onclick="openAddCourseModal()" data-bs-toggle="modal" data-bs-target="#add-course-modal">
                        <strong>Add Course</strong>
                    </button>
                </div>
            </c:if>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Code</th>
                        <th>Active</th>
                            <c:if test="${sessionScope.userAuthorization!=null&&sessionScope.userAuthorization.roleLevel==1}">
                            <th>Actions</th>
                            </c:if>

                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="course" items="${courses}">
                        <tr>
                            <td><%= count %></td>
                            <td id="courseName-${course.courseId}">${course.courseName}</td>
                            <td id="courseCode-${course.courseId}">${course.courseCode}</td>
                            <td id="courseActive-${course.courseId}">${course.active ? 'Yes' : 'No'}</td>
                            <c:if test="${sessionScope.userAuthorization!=null&&sessionScope.userAuthorization.roleLevel==1}">
                                <td>
                                    <button onclick="openCourseEditor(${course.courseId})" type="button" class="btn btn-warning btn-sm"><strong>Update</strong></button>
                                    <button onclick="openCourseDeleter(${course.courseId})" type="button" class="btn btn-danger btn-sm"><strong>Delete</strong></button>
                                </td>
                            </c:if>
                        </tr>
                        <% count++; %>
                    </c:forEach>
                </tbody>
            </table>
        </div>


        <!-- Add Course Modal -->
        <div class="modal fade" id="add-course-modal" tabindex="-1" aria-labelledby="addCourseModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCourseModalLabel">Add New Course</h5>
                        <button type="button" class="close" onclick="closeAddModal()" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">
                        <form id="addCourseForm" method="post" action="EditCourseForAdmin">
                            <div class="mb-3">
                                <label for="addCourseName" class="form-label">Course Name</label>
                                <input type="text" class="form-control" id="addCourseName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="addCourseCode" class="form-label">Course Code</label>
                                <input type="text" class="form-control" id="addCourseCode" name="code" required>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="addIsActive" name="active" checked>
                                <label class="form-check-label" for="addIsActive">Active</label>
                            </div>
                            <button type="submit" name="action" value="add" class="btn btn-primary">Add Course</button>

                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Update Course Modal -->
        <div class="modal fade" id="edit-course-modal" tabindex="-1" aria-labelledby="editCourseModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editCourseModalLabel">Edit Course</h5>
                        <button type="button" class="close" onclick="closeBtnEditor()" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">
                        <form id="edit-course" method="post" action="EditCourseForAdmin">
                            <input type="hidden" id="editCourseId" name="id">
                            <div class="mb-3">
                                <label for="editCourseName" class="form-label">Course Name</label>
                                <input type="text" class="form-control" id="editCourseName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="editCourseCode" class="form-label">Course Code</label>
                                <input type="text" class="form-control" id="editCourseCode" name="code" required>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="editCourseActive" name="active">
                                <label class="form-check-label" for="editCourseActive">Active</label>
                            </div>
                            <button type="submit" class="btn btn-primary" name="action" value="update">Save Update Course</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="delete-confirm-modal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteConfirmModalLabel">Delete Course</h5>
                        <button type="button" class="close" onclick="closeDeleterModal()" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete this course?</p>
                        <form id="deleteCourseForm" method="post" action="EditCourseForAdmin">
                            <input type="hidden" id="deleteCourseId" name="id">
                            <button type="submit" name="action" value="delete" class="btn btn-danger">Yes, Delete</button>
                            <button type="button" class="btn btn-secondary" onclick="closeDeleterModal()">Cancel</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Course Button -->



        <script>
            function openAddCourseModal() {
                document.getElementById('add-course-modal').classList.add('show');
            }

            function closeAddModal() {
                document.getElementById('add-course-modal').classList.remove('show');
            }

            function openCourseEditor(courseId) {
                var courseName = document.getElementById('courseName-' + courseId).textContent;
                var courseCode = document.getElementById('courseCode-' + courseId).textContent;
                var courseActive = document.getElementById('courseActive-' + courseId).textContent === 'Yes';

                document.getElementById('editCourseId').value = courseId;
                document.getElementById('editCourseName').value = courseName;
                document.getElementById('editCourseCode').value = courseCode;
                document.getElementById('editCourseActive').checked = courseActive;

                document.getElementById('edit-course-modal').classList.add('show');
            }

            function closeBtnEditor() {
                document.getElementById('edit-course-modal').classList.remove('show');
            }

            function openCourseDeleter(courseId) {
                document.getElementById('deleteCourseId').value = courseId;
                document.getElementById('delete-confirm-modal').classList.add('show');
            }

            function closeDeleterModal() {
                document.getElementById('delete-confirm-modal').classList.remove('show');
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-p2ItCBEex3fL/1kD5YdJgqPhNjKEx8h/rfdn7m52L5r9R6u6DeFi6Wpd1zQ53hZ7" crossorigin="anonymous"></script>
    </body>
</html>


