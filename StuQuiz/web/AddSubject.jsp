<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : SubjectDetails
    Created on : May 19, 2024, 3:12:43 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Project</title>
        <style>
            body {
                background-color: #ffe8a1;
                font-family: Arial, sans-serif;
                color: #2b3e51;
                margin: 0;
                display: flex;
                padding: 0;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                max-width: 900px;
                margin: 20px auto;
                padding: 20px;
                background: #fff3cd;
                border: 1px solid #ccc;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .tabs {
                display: flex;
                margin-bottom: 20px;
            }
            .tab {
                padding: 10px 20px;
                border: 1px solid #ccc;
                cursor: pointer;
                border-bottom: none;
                border-radius: 5px 5px 0 0;
                background: #e7e7e7;
            }
            .tab.active {
                background-color: #333;
                color: white;
            }
            h2 {
                text-align: center;
                margin: 20px 0;
            }
            .form-container {
                display: flex;
            }
            .form-left {
                flex: 2;
                margin-right: 20px;
            }
            .form-right {
                flex: 1;
                text-align: center;
            }
            .form-group {
                margin-bottom: 15px;
                display: flex;
                align-items: center;
            }
            .form-group label {
                width: 150px;
                margin-right: 10px;
            }
            .form-group input, .form-group select, .form-group textarea {
                flex: 1;
                padding: 8px;
                box-sizing: border-box;
            }
            .form-group img {
                display: block;
                max-width: 100%;
                height: auto;
                margin: 0 auto;
            }
            .form-group .upload {
                text-align: center;
                margin-top: 10px;
            }
            .form-actions {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }
            .form-actions button {
                padding: 10px 20px;
                cursor: pointer;
                border: 1px solid #ccc;
                border-radius: 5px;
                background: #e7e7e7;
            }
            .form-actions button:hover {
                background: #d7d7d7;
            }
            .form-row {
                display: flex;
                justify-content: space-between;
            }
            .form-row .form-group {
                flex: 1;
                display: flex;
                align-items: center;
            }
            .form-row .form-group:first-child {
                margin-right: 10px;
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
        </style>
    </head>
    <body>

        <div class="container">
            <div class="tabs">
                <div class="tab active">Overview</div>
            </div>

            <h2>Subject Add</h2>

            <div class="form-container" style="padding: 20px">
                <div class="form-left" style="width: 100%">
                    <form action="AddSubject" method="POST">
                        <div class="form-row">
                            <div class="form-group ">
                                <label for="subject-name">Subject Name</label>
                                <input type="text" id="subject-name" name="subject-name">
                            </div>
                            <div class="form-group ">
                                <label for="subject-name">Subject code</label>
                                <input type="text" id="subject-code" name="subject-code">
                            </div>
                        </div>

                        <div class="form-group ">
                            <label for="course">Course</label>
                            <select name="course">
                                <c:forEach var="c" items="${cl}">
                                    <option value="${c.courseId}">${c.courseName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="price">Price</label>
                                <input type="text" id="price" name="price">
                            </div>
                            <div class="form-group">
                                <label for="price">Sale Price</label>
                                <input type="text" id="salePrice" name="salePrice">
                            </div>

                        </div>
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea id="description" name="description" rows="4"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="status">Status</label>
                            <select id="status" name="status">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                        <div>Image:</div>
                        <img class="img-fluid" id="imgContent" style="max-width: 400px;min-width: 300px" src="${s.subjectImage!=null?s.subjectImage:"https://nhakhoavanthanh.com.vn/wp-content/themes/apexclinic/images/no-image/No-Image-Found-400x264.png"}" alt="img"/>
                        <div class="">
                            <label for="byBase64">Upload File</label>
                            <input type="radio" name="imgBy" id="byBase64" value="byBase64" onchange="disableField('img', 'link')">
                            <input type="file" id="img" name="img"  accept="image/*" disabled onchange="convertToBase64()"><br><br>

                            <label for="byLink">Import Link</label>
                            <input type="radio" name="imgBy" id="byLink" value="byLink" onchange="disableField('link', 'img')">
                            <input type="text" name="link" value="" id="link" disabled="" onkeyup="disableField('link', 'img')" ><br><br>
                            
                            <input type="text" hidden=""  id="imgText" value="" name="imgText">
                            <div hidden id="temp64"></div>
                        </div>
                        <div class="form-actions">
                            <a  href="SubjectList" class="btn" type="button">Back</a>
                            
                            <button type="submit"   value="save" >Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <script>
        function convertToBase64() {
            var input = document.getElementById('img');
            var file = input.files[0];
            var base64String = '';
            document.getElementById("link").disabled = true;
            document.getElementById("img").disabled = false;
            if (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    base64String = e.target.result;
                    document.getElementById("imgContent").src = base64String;
                    document.getElementById("temp64").innerHTML = base64String;
                    document.getElementById("imgText").value = base64String;
                };
                reader.readAsDataURL(file);
            }
        }

        function disableField(focusField, disableField1) {
            document.getElementById(disableField1 + "").disabled = true;
            document.getElementById(focusField + "").disabled = false;
            var srcString = '';
            if (focusField === "img") {
                document.getElementById("imgText").value = document.getElementById("temp64").innerHTML;
                document.getElementById("imgContent").src = document.getElementById("temp64").innerHTML;
            } else if (focusField === "link") {
                srcString = document.getElementById("link").value;
                document.getElementById("imgContent").src = srcString;
                document.getElementById("imgText").value = srcString;
            } else {
                srcString = "https://nhakhoavanthanh.com.vn/wp-content/themes/apexclinic/images/no-image/No-Image-Found-400x264.png";
                document.getElementById("imgContent").src = srcString;
            }
            
        }



        function changeImgContent(focusField) {
            var srcString = '';
            if (focusField === "img") {
                convertToBase64();
            } else if (focusField === "link") {
                srcString = document.getElementById("link").value;
                document.getElementById("imgContent").src = srcString;
                document.getElementById("imgText").value = srcString;
            } else {
                srcString = "https://nhakhoavanthanh.com.vn/wp-content/themes/apexclinic/images/no-image/No-Image-Found-400x264.png";
                document.getElementById("imgContent").src = srcString;
                document.getElementById("imgText").value = srcString;
            }
            console.log(srcString);
            
        }
        
        function changeImgText(){
            var isUpFile = document.getElementById('byBase64').checked;
            var isUpLink = document.getElementById('byLink').checked;
            if(isUpFile){
                document.getElementById('imgText').value = document.getElementById('imgContent').src;
            } else if(isUpFile){
                document.getElementById('imgText').value = document.getElementById('imgContent').src;
            } else {
                
            }
            document.getElementById('formSubmit').submit();
        }
    </script>
</html>
