<%-- 
    Document   : editUser
    Created on : Jun 10, 2024, 4:08:01 PM
    Author     : HP
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Edit User</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="mb-4">Edit User</h2>
            <c:if  test="${error != null}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>
            <form method="post" action="../admin/account">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="userId" value="${user.userId}" />
                <div class="form-group">
                    <label for="userEmail">Email:</label>
                    <input type="email" class="form-control" id="userEmail" name="userEmail" value="${user.userEmail}" readonly>
                </div>
                <div class="form-group">
                    <label for="userName">Name:</label>
                    <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" required>
                </div>

                <div class="form-group">
                    <label for="roleLevel">Role Level:</label>
                    <input type="number" class="form-control" id="roleLevel" name="roleLevel" value="${user.roleLevel}" required>
                </div>

                <div class="form-group">
                    <label for="userAvatar">Avatar URL:</label>
                    <input type="text" class="form-control" id="userAvatar" name="userAvatar" value="${user.userAvatar}">
                </div>

                <div class="form-group">
                    <label for="userBank">Bank:</label>
                    <input type="text" class="form-control" id="userBank" name="userBank" value="${user.userBank}">
                </div>

                <div class="form-group">
                    <label for="userBankCode">Bank Code:</label>
                    <input type="text" class="form-control" id="userBankCode" name="userBankCode" value="${user.userBankCode}">
                </div>
                <div class="form-group">
                    <label for="activeCode">Active Code:</label>
                    <input type="text" class="form-control" id="activeCode" name="activeCode" value="${user.activeCode}">
                </div>
                <div class="form-group">
                    <label for="isActive">Active:</label>
                    <select class="form-control" id="isActive" name="isActive">
                        <option value="true" ${user.isActive() ? 'selected' : ''}>Yes</option>
                        <option value="false" ${!user.isActive() ? 'selected' : ''}>No</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Save</button>
                <a href="../admin/account" class="btn btn-secondary">Cancel</a>
            </form>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>