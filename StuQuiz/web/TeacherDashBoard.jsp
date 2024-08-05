<%-- 
    Document   : DashBoard
    Created on : Jun 24, 2024, 1:07:39 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible"
              content="IE=edge">
        <meta name="viewport" 
              content="width=device-width, 
              initial-scale=1.0">
        <title>StuQuiz</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Poppins", sans-serif;
            }
            :root {
                --background-color1: #fafaff;
                --background-color2: #ffffff;
                --background-color3: #ededed;
                --background-color4: #cad7fda4;
                --primary-color: #4b49ac;
                --secondary-color: #0c007d;
                --Border-color: #3f0097;
                --one-use-color: #3f0097;
                --two-use-color: #5500cb;
            }
            body {
                background-color: var(--background-color4);
                max-width: 100%;
                overflow-x: hidden;
            }

            header {
                height: 70px;
                width: 100vw;
                padding: 0 30px;
                background-color: var(--background-color1);
                position: fixed;
                z-index: 100;
                box-shadow: 1px 1px 15px rgba(161, 182, 253, 0.825);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {

            }

            .logo a{
                text-decoration: none;
                color: rgb(47, 141, 70);
                font-size: 27px;
                font-weight: 600;
            }

            .icn {
                height: 30px;
            }
            .menuicn {
                cursor: pointer;
            }

            .searchbar,
            .message,
            .logosec {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .searchbar2 {
                display: none;
            }

            .logosec {
                gap: 60px;
            }

            .searchbar input {
                width: 250px;
                height: 42px;
                border-radius: 50px 0 0 50px;
                background-color: var(--background-color3);
                padding: 0 20px;
                font-size: 15px;
                outline: none;
                border: none;
            }
            .searchbtn {
                width: 50px;
                height: 42px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 0px 50px 50px 0px;
                background-color: var(--secondary-color);
                cursor: pointer;
            }

            .message {
                gap: 40px;
                position: relative;
                cursor: pointer;
            }
            .circle {
                height: 7px;
                width: 7px;
                position: absolute;
                background-color: #fa7bb4;
                border-radius: 50%;
                left: 19px;
                top: 8px;
            }
            .dp {
                height: 40px;
                width: 40px;
                background-color: #626262;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                overflow: hidden;
            }
            .main-container {
                display: flex;
                width: 100vw;
                position: relative;
                top: 70px;
                z-index: 1;
            }
            .dpicn {
                height: 42px;
            }

            .main {
                height: calc(100vh - 70px);
                width: 100%;
                overflow-y: scroll;
                overflow-x: hidden;
                padding: 40px 30px 30px 30px;
            }

            .main::-webkit-scrollbar-thumb {
                background-image:
                    linear-gradient(to bottom, rgb(0, 0, 85), rgb(0, 0, 50));
            }
            .main::-webkit-scrollbar {
                width: 5px;
            }
            .main::-webkit-scrollbar-track {
                background-color: #9e9e9eb2;
            }

            .box-container {
                display: flex;
                justify-content: space-evenly;
                align-items: center;
                flex-wrap: wrap;
                gap: 50px;
            }
            .nav {
                min-height: 91vh;
                width: 250px;
                background-color: var(--background-color2);
                position: absolute;
                top: 0px;
                left: 00;
                box-shadow: 1px 1px 10px rgba(198, 189, 248, 0.825);
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                overflow: hidden;
                padding: 30px 0 20px 10px;
            }
            .navcontainer {
                height: calc(100vh - 70px);
                width: 250px;
                position: relative;
                overflow-y: scroll;
                overflow-x: hidden;
                transition: all 0.5s ease-in-out;
            }
            .navcontainer::-webkit-scrollbar {
                display: none;
            }
            .navclose {
                width: 77px;
            }
            .nav-option {
                width: 250px;
                height: 60px;
                display: flex;
                align-items: center;
                padding: 0 30px 0 20px;
                gap: 20px;
                transition: all 0.1s ease-in-out;
            }
            .nav-option:hover {
                border-left: 5px solid #a2a2a2;
                background-color: #dadada;
                cursor: pointer;
            }
            .nav-img {
                height: 30px;
            }

            .nav-upper-options {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 30px;
            }

            .option1 {
                border-left: 5px solid #010058af;
                background-color: var(--Border-color);
                color: white;
                cursor: pointer;
            }
            .option1:hover {
                border-left: 5px solid #010058af;
                background-color: var(--Border-color);
            }
            .box {
                height: 130px;
                width: 300px;
                border-radius: 20px;
                box-shadow: 3px 3px 10px rgba(0, 30, 87, 0.751);
                padding: 20px;
                display: flex;
                align-items: center;
                justify-content: space-around;
                cursor: pointer;
                transition: transform 0.3s ease-in-out;
            }
            .box:hover {
                transform: scale(1.08);
            }

            .box:nth-child(1) {
                background-color: var(--one-use-color);
            }
            .box:nth-child(2) {
                background-color: var(--two-use-color);
            }
            .box:nth-child(3) {
                background-color: var(--one-use-color);
            }

            .box img {
                height: 50px;
            }
            .box .text {
                color: white;
            }
            .topic {
                font-size: 13px;
                font-weight: 400;
                letter-spacing: 1px;
            }

            .topic-heading {
                font-size: 30px;
                letter-spacing: 3px;
            }

            .report-container {
                min-height: 300px;
                max-width: 1500px;
                margin: 70px auto 0px auto;
                background-color: #ffffff;
                border-radius: 30px;
                box-shadow: 3px 3px 10px rgb(188, 188, 188);
                padding: 0px 20px 20px 20px;
            }
            .report-header {
                height: 80px;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 20px 20px 10px 20px;
                border-bottom: 2px solid rgba(0, 20, 151, 0.59);
            }

            .recent-Articles {
                font-size: 30px;
                font-weight: 600;
                color: #5500cb;
            }
            .view{
                display: flex;
            }

            .view button{
                margin-left: 20px;
                height: 35px;
                width: 90px;
                border-radius: 8px;
                background-color: #5500cb;
                color: white;
                font-size: 15px;
                border: none;
                cursor: pointer;
            }

            .report-body {
                width: 100%;
                overflow-x: auto;
                padding: 20px;
            }
            .report-topic-heading,
            .item1 {
                width: 100%;
                display: flex;
                align-items: center;
            }
            .t-op {
                font-size: 18px;
                letter-spacing: 0px;
            }
            .tbl-header{
                display: flex;
                flex-direction: row;
                justify-content: space-between;
                width: 100%;
            }
            .items {
                width: 100%;
                margin-top: 15px;
            }

            .item1 {
                margin-top: 20px;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
            }

            .item1 a{
                text-decoration: none;
                color: black;
            }
            .t-op-nextlvl {
                font-size: 14px;
                letter-spacing: 0px;
                font-weight: 600;
            }

            .label-tag {
                width: 100px;
                text-align: center;
                background-color: rgb(0, 177, 0);
                color: white;
                border-radius: 4px;
            }
            .col-name{
                min-width: 500px;
                overflow: hidden;
            }

            .col-name:hover{
                text-decoration: underline;
            }
            .r-subject{
                display: flex;
                flex-direction: row;
                overflow-y: visible;

            }

        </style>
    </head>

    <body>

        <!-- for header part -->
        <header>

            <div class="logosec">
                <div class="logo">
                    <a href="./TeacherDashBoard">StuQuiz</a>
                </div>
                <img src=
                     "https://media.geeksforgeeks.org/wp-content/uploads/20221210182541/Untitled-design-(30).png"
                     class="icn menuicn" 
                     id="menuicn" 
                     alt="menu-icon">
            </div>

            <div class="searchbar">
                <form method="get" action="TeacherDashBoard" id="searchBox">
                    <input type="hidden" name="actionCheck" value="searching">
                    <input type="text" name="searchText" value="${searchText}" placeholder="Search">
                </form>
                <div class="searchbtn" onclick="submitSearch()">
                    <img src=
                         "https://media.geeksforgeeks.org/wp-content/uploads/20221210180758/Untitled-design-(28).png"
                         class="icn srchicn" 
                         alt="search-icon">
                </div>
            </div>


            <div class="message">
                <div class="circle"></div>
                <img src=
                     "https://media.geeksforgeeks.org/wp-content/uploads/20221210183322/8.png" 
                     class="icn" 
                     alt="">
                <div class="dp">
                    <img src=
                         "https://media.geeksforgeeks.org/wp-content/uploads/20221210180014/profile-removebg-preview.png"
                         class="dpicn" 
                         alt="dp">
                </div>
            </div>

        </header>

        <div class="main-container">
            <div class="navcontainer">
                <nav class="nav">
                    <div class="nav-upper-options">
                        <div class="nav-option option1">
                            <img src=
                                 "https://media.geeksforgeeks.org/wp-content/uploads/20221210182148/Untitled-design-(29).png"
                                 class="nav-img" 
                                 alt="dashboard">
                            <h3> Dashboard</h3>
                        </div>

                        <div class="option2 nav-option">
                            <img src=
                                 "https://media.geeksforgeeks.org/wp-content/uploads/20221210183322/9.png"
                                 class="nav-img" 
                                 alt="articles">
                            <a href="./SubjectList"><h3>My Subjects</h3></a>
                        </div>

                        <div class="nav-option option3">
                            <img style="z-index: 1" src=
                                 "https://media.geeksforgeeks.org/wp-content/uploads/20221210183320/5.png"
                                 class="nav-img" 
                                 alt="report">
                           <small style="color: white; position: absolute; z-index: 9999; margin-left: 30px; margin-bottom: 30px; font-weight: bold;height: 17px; width: 17px; border-radius: 50%; background-color: red; display: flex; flex-direction: row; justify-content: center; align-content: center">12</small>
                            <h3 class="r-subject">Request Subject</h3>
                        </div>

                        <div class="nav-option option4">
                            <img src=
                                 "https://media.geeksforgeeks.org/wp-content/uploads/20221210183321/6.png"
                                 class="nav-img" 
                                 alt="institution">
                            <h3> Institution</h3>
                        </div>

                        <div class="nav-option option5">
                            <img src=
                                 "https://media.geeksforgeeks.org/wp-content/uploads/20221210183323/10.png"
                                 class="nav-img" 
                                 alt="blog">
                            <h3> <a href="ViewProfile" target="_blank">Profile</a></h3>
                        </div>

                        <div class="nav-option option6">
                            <img src=
                                 "https://media.geeksforgeeks.org/wp-content/uploads/20221210183320/4.png"
                                 class="nav-img" 
                                 alt="settings">
                            <h3> Settings</h3>
                        </div>

                        <div class="nav-option logout">
                            <img src=
                                 "https://media.geeksforgeeks.org/wp-content/uploads/20221210183321/7.png"
                                 class="nav-img" 
                                 alt="logout">
                            <h3><a href="Logout" target="_blank">Logout</a></h3>
                        </div>

                    </div>
                </nav>
            </div>
            <div class="main">

                <div class="searchbar2">
                    <input type="text" 
                           name="" 
                           id="" 
                           placeholder="Search">
                    <div class="searchbtn">
                        <img src=
                             "https://media.geeksforgeeks.org/wp-content/uploads/20221210180758/Untitled-design-(28).png"
                             class="icn srchicn" 
                             alt="search-button">
                    </div>
                </div>

                <div class="box-container">

                    <div class="box box1">
                        <div class="text">
                            <h2 class="topic-heading">${totalView}</h2>
                            <h2 class="topic">Lesson Views</h2>
                        </div>
                    </div>

                    <div class="box box2">
                        <div class="text">
                            <h2 class="topic-heading">${totalRevenue}VND</h2>
                            <h2 class="topic">Total Sales</h2>
                        </div>
                    </div>

                    <div class="box box3">
                        <div class="text">
                            <h2 class="topic-heading">${monthlySales}VND</h2>
                            <h2 class="topic">Monthly Sales</h2>
                        </div>
                    </div>
                </div>


                <div class="report-container">
                    <div class="report-header">
                        <h1 class="recent-Articles">${actionCheck!=null?"List Subject":"Top Subjects"}</h1>
                        <div class="view">
                            <form method="get" action="TeacherDashBoard" id="sortForm">
                                <input type="hidden" name="actionCheck" value="sort">
                                <select id="sortBy" name="sortBy" onchange="submitForm()">
                                    <option value="subject" ${param.sortBy == 'subject' ? 'selected' : ''}>Subjects</option>
                                    <option value="view" ${param.sortBy == 'view' ? 'selected' : ''}>Views</option>
                                    <option value="vote" ${param.sortBy == 'vote' ? 'selected' : ''}>Votes</option>
                                    <option value="purchase" ${param.sortBy == 'purchase' ? 'selected' : ''}>Purchases</option>
                                    <option value="sale" ${param.sortBy == 'sale' ? 'selected' : ''}>Sales</option>
                                </select>
                                <select id="orderBy" name="orderBy" onchange="submitForm()">
                                    <option value="low" ${param.orderBy == 'low' ? 'selected' : ''}>From High to Low</option>
                                    <option value="high" ${param.orderBy == 'high' ? 'selected' : ''}>From Low to High</option>
                                </select>
                            </form>
                            <form method="get" action="TeacherDashBoard" id="sortForm">
                                <button type="submit" value="reset">Clear All</button>
                            </form>
                            <form method="get" action="TeacherDashBoard">
                                <input type="text" name="actionCheck" value="viewAll" hidden>
                                <button>View All</button>
                            </form>
                        </div>
                    </div>

                    <table class="report-body">
                        <thead class="report-topic-heading">
                            <tr class="tbl-header">
                                <td class="t-op col-name">Subjects</td>
                                <td class="t-op">Views</td>
                                <td class="t-op">Votes</td>
                                <td class="t-op">Purchases</td>
                                <td class="t-op">Sales</td>
                            </tr>
                        </thead>

                        <tbody class="items">
                            <c:forEach items="${subStatistic}" var="subStat">
                                <tr class="item1">
                                    <td class="t-op-nextlvl col-name"><a href="./Lessons?actionCheck=viewLessonList&subjectId=${subStat.subjectStatistic.subjectId}">${subStat.subject.subjectName}</a></td>
                                    <td class="t-op-nextlvl col-views">${subStat.subjectStatistic.views}</td>
                                    <td class="t-op-nextlvl col-avg-votes">${avgVote[subStat.subjectStatistic.subjectId]}</td>
                                    <td class="t-op-nextlvl col-purchases">${subStat.subjectStatistic.purchases}</td>
                                    <td class="t-op-nextlvl label-tag col-revenue">${subStat.subjectStatistic.revenue}VND</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            let menuicn = document.querySelector(".menuicn");
            let nav = document.querySelector(".navcontainer");

            menuicn.addEventListener("click", () => {
                nav.classList.toggle("navclose");
            });

            function submitForm() {
                document.getElementById('sortForm').submit();
            }
            function submitSearch() {
                document.getElementById("searchBox").submit();
            }
        </script>
    </body>
</html>
