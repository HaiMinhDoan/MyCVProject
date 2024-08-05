<%-- 
    Document   : fail
    Created on : Jul 10, 2024, 8:57:54 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Failure</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2 class="mt-4">Failure</h2>
    <div class="alert alert-danger mt-4">
        There was an error submitting your request. Please try again later.
    </div>
    <a href="../submitRequest" class="btn btn-primary">Try Again</a>
</div>
</body>
</html>