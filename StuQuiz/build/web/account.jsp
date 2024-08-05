<%-- 
    Document   : account
    Created on : Jun 10, 2024, 2:51:49 PM
    Author     : HP
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>User List</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .badge {
                color: #fff;
            }
            .badge-1 {
                background-color: red; /* Admin */
            }

            .badge-2 {
                background-color: blue; /* Sale */
            }

            .badge-3 {
                background-color: green; /* Teacher */
            }

            .badge-4 {
                background-color: grey; /* User */
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="mb-4">User List </h2>
            <c:if  test="${param.message != null}">
                <div class="alert alert-success" role="alert">
                    ${param.message}
                </div>

            </c:if>
            <c:if  test="${param.error != null}">
                <div class="alert alert-danger" role="alert">
                    ${param.error}
                </div>

            </c:if>
            <form method="post" action="../admin/account" style="background-color: #ddd; padding: 10px; margin-bottom: 10px">
                <input type="hidden" name="action" value="filter" />
                <div class="form-group">
                    <label for="search">Search:</label>
                    <input type="text" name="search" id="search" class="form-control" value="${search}" placeholder="Enter user name or email" />
                </div>
                <div class="row">
                    <div class="form-group col-lg-4">
                        <label for="filter">Filter by Active Status:</label>
                        <select name="filter" id="filter" onchange="this.form.submit()" class="form-control">
                            <option value="all" ${filter == 'all' ? 'selected' : ''}>All</option>
                            <option value="true" ${filter == 'true' ? 'selected' : ''}>Active</option>
                            <option value="false" ${filter == 'false' ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                    <div class="form-group col-lg-4">
                        <label for="sort-time">Sort by Created Time:</label>
                        <select name="sort-time" id="sort-time" onchange="this.form.submit()" class="form-control">
                            <option value="desc" ${sortTime == 'desc' ? 'selected' : ''}>Desc</option>
                            <option value="asc" ${sortTime == 'asc' ? 'selected' : ''}>Asc</option>
                        </select>
                    </div>
                    <div class="form-group col-lg-4">
                        <label for="sort-name">Sort by name:</label>
                        <select name="sort-name" id="sort-name" onchange="this.form.submit()" class="form-control">
                            <option value="desc" ${sortName == 'desc' ? 'selected' : ''}>Desc</option>
                            <option value="asc" ${sortName == 'asc' ? 'selected' : ''}>Asc</option>
                        </select>
                    </div>  
                </div>
            </form>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role Level</th>
                        <th>Avatar</th>
                        <th>Bank</th>
                        <th>Bank Code</th>
                        <th>Created Time</th>
                        <th>Active</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.userName}</td>
                            <td>${user.userEmail}</td>
                            <td>
                                <span class="badge badge-${user.roleLevel}">
                                    <c:choose>
                                        <c:when test="${user.roleLevel == 1}">Admin</c:when>
                                        <c:when test="${user.roleLevel == 2}">Sale</c:when>
                                        <c:when test="${user.roleLevel == 3}">Teacher</c:when>
                                        <c:otherwise>User</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td><img src="${user.userAvatar}" alt="Avatar" style="width:50px;height:50px;"></td>
                            <td>${user.userBank}</td>
                            <td>${user.userBankCode}</td>
                            <td>${user.createdTime}</td>
                            <td>
                                <c:if test="${user.isActive() == true}">
                                    <span class="badge badge-success">Active</span>
                                </c:if>
                                <c:if test="${user.isActive() == false}">
                                    <span class="badge badge-danger">Inactive</span>
                                </c:if>
                            <td>
                                <a class="btn btn-warning" href="../admin/account?action=view&userId=${user.userId}">Detail</a>
                                <a class="btn btn-primary" href="../admin/account?action=edit&userId=${user.userId}">Edit</a>
                                <c:if test="${user.isActive() == true}">
                                    <a onclick="return confirm('Are you sure to delete?')" class="btn btn-danger" href="../admin/account?action=delete&userId=${user.userId}">Delete</a>
                                </c:if>
                                <c:if test="${user.isActive() == false}">
                                    <a onclick="return confirm('Are you sure to restore?')" class="btn btn-success" href="../admin/account?action=restore&userId=${user.userId}">Restore</a>
                                </c:if>

                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${userList.size() == 0}">
                    <td colspan="10" style="text-align: center">
                        No have user
                    </td>
                </c:if>
                </tbody>
            </table>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>