<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : SubjectList
    Created on : May 26, 2024, 8:44:06 AM
    Author     : user
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Subject</title>
        <style>

            #searchByName .input-group {
                border-radius: 20px;
                overflow: hidden;
            }

            #searchByName input {
                border: 1px solid #ced4da;
                box-shadow: inset 0 1px 2px rgb(0 0 0 / 8%);
                transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
            }

            #searchByName input:focus {
                border-color: #80bdff;
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
            }

            #searchByName .btn-primary {
                border-radius: 0;
                box-shadow: none;
            }

            #searchByName .btn-primary .fa-search {
                margin-right: -6px;
            }

            #searchByName .btn-primary:focus {
                box-shadow: none;
            }
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f5f5f5;
                color: #333;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            h1 {
                font-weight: 600;
                text-align: center;
                margin-bottom: 30px;
            }
            .btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                text-align: center;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s;
            }
            .btn:hover {
                background-color: #0056b3;
            }
            form {
                display: inline-block;
                vertical-align: middle;
                margin-left: 20px;
            }
            .input-group {
                display: flex;
            }
            .form-control {
                flex: 1;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .input-group-append {
                padding: 0 10px;
            }
            .fa-search {
                font-size: 18px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <div class="container">
        <h1>Subject</h1>


        <div class="container">
            <div class="row">
                <div class="col text-center mb-3">
                    <a href="${sessionScope.userAuthorization.roleLevel == 1?"DashBoard":"TeacherDashBoard"}" class="btn btn-info" style="background-color: green">Back to DashBoard</a>
                    <a href="AddSubject" class="btn btn-primary">Insert a new Subject </a>
                    
                </div>
            </div>
        </div>

        <c:if test="${not empty allSubject}">
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th style="background-color: #bfd1ec">ID</th>
                            <th style="background-color: #bfd1ec">Subject Code</th>
                            <th style="background-color: #bfd1ec">Subject Name</th>
                            <th style="background-color: #bfd1ec">Image</th>
                            <th style="background-color: #bfd1ec">Price</th>
                            <th style="background-color: #bfd1ec">Sale Price</th>
                            <th style="background-color: #bfd1ec">Status</th>
                            <th style="background-color: #bfd1ec">Update</th>
                            <th style="background-color: #bfd1ec">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${allSubject}" var="subject">
                            <tr>
                                <td>${subject.subjectId}</td>
                                <td>${subject.subjectCode}</a></td>
                                <td><a href="./Lessons?actionCheck=viewLessonList&subjectId=${subject.subjectId}" target="_blank">${subject.subjectName}</a></td>
                                <td><img src="${subject.subjectImage}" style="max-width: 40px;max-height: 40px"/></td>
                                <td>${subject.subjectPrice}</td>
                                <td>${subject.salePrice}</td>
                                <td>${subject.isActive()==true?"Active":"Inactive"}</td>
                                <td><a href="UpdateSubject?sid=${subject.subjectId}" class="btn btn-warning">Update</a></td>
                                <c:if test="${subject.isActive()}">
                                    <td><button  style="background-color:  red; border: none"  class="btn btn-danger"  onclick="confirmDelete(${subject.subjectId},${subject.isActive()})">Delete</button></td>
                                </c:if>
                                <c:if test="${!subject.isActive()}">
                                    <td><button  style="background-color:  red; border: none"  class="btn btn-danger"  onclick="confirmDelete(${subject.subjectId},${subject.isActive()})">Restore</button></td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <script>
                function confirmDelete(productId,isDelete) {
                 
                    if (confirm("Are you sure you want to update this Subject (ID = " + productId + ") ?")) {
                            window.location.href   = "DeleteSubject?sid="+productId+"&delete="+isDelete;
                    } else {
                    }
                     
                }
            </script>
        </c:if>
    </div>
</body>
</html>
