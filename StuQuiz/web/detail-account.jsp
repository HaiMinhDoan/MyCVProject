<%-- 
    Document   : detail-account
    Created on : Jun 10, 2024, 3:56:00 PM
    Author     : HP
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>User Details</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="mb-4">User Details</h2>

            <table class="table table-bordered">
                <tr>
                    <th>ID</th>
                    <td>${user.userId}</td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td>${user.userName}</td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td>${user.userEmail}</td>
                </tr>
                <tr>
                    <th>Role Level</th>
                    <td>${user.roleLevel}</td>
                </tr>
                <tr>
                    <th>Avatar</th>
                    <td><img src="${user.userAvatar}" alt="Avatar" style="width:100px;height:100px;"></td>
                </tr>
                <tr>
                    <th>Bank</th>
                    <td>${user.userBank}</td>
                </tr>
                <tr>
                    <th>Bank Code</th>
                    <td>${user.userBankCode}</td>
                </tr>
                <tr>
                    <th>Created Time</th>
                    <td>${user.createdTime}</td>
                </tr>
                <tr>
                    <th>Active Code</th>
                    <td>${user.activeCode}</td>
                </tr>
                <tr>
                    <th>Active</th>
                    <td>${user.isActive() ? 'Yes' : 'No'}</td>
                </tr>
            </table>

            <a href="../admin/account" class="btn btn-primary">Back to User List</a>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>