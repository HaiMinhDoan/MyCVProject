<%-- 
    Document   : requestTecher
    Created on : Jul 10, 2024, 7:12:50 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Request Teacher List</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container">
            <h2>Request Teacher List</h2>
            <c:if test="${param.error != null}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Error: </strong> ${param.error}
                </div>
            </c:if>
            <c:if test="${param.success != null}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>Success: </strong> ${param.success}
                </div>
            </c:if>
            <table class="table table-bordered">
                <thead style="background: #7be37f; color: #fff">
                    <tr>
                        <th>ID</th>
                        <th>Maker ID</th>
                        <th>User Bank</th>
                        <th>User Bank Code</th>
                        <th>Content</th>
                        <th>Created Time</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="request" items="${listRequestTeacher}">
                        <tr>
                            <td>${request.reqestTeacherId}</td>
                            <td>${request.user.userName}</td>
                            <td>${request.userBank}</td>
                            <td>${request.userBankCode}</td>
                            <td>${request.reqestContent}</td>
                            <td>${request.createdTime}</td>
                            <td>${request.getIsAccept() == 0 ? "Pending" : request.getIsAccept() == 1 ?"Accepted" : "Rejected"}</td>
                            <td>
                                <c:if test="${request.getIsAccept() == 0}">
                                    <form method="post" action="request-teacher" style="display:inline;">
                                        <input type="hidden" name="id" value="${request.reqestTeacherId}">
                                        <button onclick="return confirm('Are you sure to accept')" type="submit" name="action" value="accept" class="btn btn-success">Accept</button>
                                    </form>
                                    <form method="post" action="request-teacher" style="display:inline;">
                                        <input type="hidden" name="id" value="${request.reqestTeacherId}">
                                        <button onclick="return confirm('Are you sure to delete')" type="submit" name="action" value="reject" class="btn btn-danger">Delete</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${listRequestTeacher.size() == 0}">
                        <tr>
                            <td colspan="10" style="text-align: center">No have request</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </body>
</html>



