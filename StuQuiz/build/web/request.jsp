<%-- 
    Document   : request
    Created on : Jul 10, 2024, 8:52:30 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Form</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2 class="mt-4">Request Form</h2>
    <form class="request-form row mt-4" method="post" action="submitRequest">
        <div class="col-md-12">
            <div class="form-group">
                <label for="bankName">Payment:</label>
                <select id="bankName" name="bankName" class="form-control" required>
                    <option selected disabled>--- Choose bank ---</option>
                    <option value="Vietcombank">Vietcombank</option>
                    <option value="Vietinbank">Vietinbank</option>
                    <option value="BIDV">BIDV</option>
                    <option value="Sacombank">Sacombank</option>
                    <option value="Á Châu">Á Châu</option>
                    <option value="MBBank">MBBank</option>
                    <option value="Techcombank">Techcombank</option>
                    <option value="DongA">Đông Á</option>
                    <option value="VP bank">VP bank</option>
                    <option value="Eximbank">Eximbank</option>
                    <option value="TP bank">TP bank</option>
                    <option value="Ocean bank">Ocean bank</option>
                    <option value="OCB">OCB</option>
                    <option value="SHBank">SHBank</option>
                </select>
            </div>
            <div class="form-group">
                <label for="bankAccountNumber">Account Number:</label>
                <input type="text" id="bankAccountNumber" name="bankAccountNumber" class="form-control" required placeholder="Example: 0123456789" maxlength="100" autocomplete="off">
            </div>

            <div class="form-group">
                <label for="requestContent">Upload CV:</label>
                <textarea id="requestContent" name="requestContent" class="form-control" rows="5" required placeholder="Up CV"></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Request</button>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>