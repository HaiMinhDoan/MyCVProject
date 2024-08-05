<%-- 
    Document   : BuySubjectPage
    Created on : Jun 15, 2024, 9:07:16 AM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <title>Document</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <style>
            @import url(https://fonts.googleapis.com/css?family=Lato:400,300,700);

            .window {
                height: 750px;
                width: 100%;
                display: -webkit-box;
                display: -webkit-flex;
                display: -ms-flexbox;
                display: flex;
                box-shadow: 0px 10px 50px 10px;
                border-radius: 30px;
                margin-top: 100px;
                margin-bottom: 100px;
            }

            .order-info {
                height: 100%;
                width: 50%;
                padding-left: 25px;
                padding-right: 25px;
                box-sizing: border-box;
                display: -webkit-box;
                display: -webkit-flex;
                display: -ms-flexbox;
                display: flex;
                -webkit-box-pack: center;
                -webkit-justify-content: center;
                -ms-flex-pack: center;
                justify-content: center;
                position: relative;
            }

            .price {
                bottom: 0px;
                position: absolute;
                right: 0px;
                color: #4488dd;
            }

            .order-table td:first-of-type {
                width: 25%;
            }

            .order-table {
                position: relative;
            }

            .line {
                height: 1px;
                width: 100%;
                margin-top: 10px;
                margin-bottom: 10px;
                background: #ddd;
            }

            .order-table td:last-of-type {
                vertical-align: top;
                padding-left: 25px;
            }

            .order-info-content {
                table-layout: fixed;

            }

            .full-width {
                width: 100%;
            }

            .pay-btn {
                border: none;
                background: #22b877;
                line-height: 2em;
                border-radius: 10px;
                font-size: 19px;
                font-size: 1.2rem;
                color: #fff;
                cursor: pointer;
                position: absolute;
                bottom: 25px;
                width: calc(100% - 50px);
                -webkit-transition: all .2s ease;
                transition: all .2s ease;
            }

            .pay-btn:hover {
                background: #22a877;
                color: #eee;
                -webkit-transition: all .2s ease;
                transition: all .2s ease;
            }

            .total {
                margin-top: 25px;
                font-size: 20px;
                font-size: 1.3rem;
                position: absolute;
                bottom: 30px;
                right: 27px;
                left: 35px;
            }

            .dense {
                margin-bottom: 20px;
                line-height: 1.2em;
                font-size: 16px;
                font-size: 1rem;
            }

            .input-field {
                background: rgba(255, 255, 255, 0.1);
                margin-bottom: 10px;
                margin-top: 3px;
                line-height: 1.5em;
                font-size: 20px;
                font-size: 1.3rem;
                border: none;
                padding: 5px 10px 5px 10px;
                color: #fff;
                box-sizing: border-box;
                width: 100%;
                margin-left: auto;
                margin-right: auto;
            }

            .credit-info {
                height: 100%;
                width: 50%;
                -webkit-box-pack: center;
                -webkit-justify-content: center;
                -ms-flex-pack: center;
                justify-content: center;
                font-size: 14px;
                font-size: .9rem;
                display: -webkit-box;
                display: -webkit-flex;
                display: -ms-flexbox;
                display: flex;
                box-sizing: border-box;
                padding-left: 25px;
                padding-right: 25px;
                border-top-right-radius: 30px;
                border-bottom-right-radius: 30px;
                position: relative;
            }
            .credit-info-content {
                margin-top: 25px;
                -webkit-flex-flow: column;
                -ms-flex-flow: column;
                flex-flow: column;
                display: -webkit-box;
                display: -webkit-flex;
                display: -ms-flexbox;
                display: flex;
                width: 100%;
            }

            .center-text {
                display: flex;
                flex-direction: column;
                text-align: center;
                text-justify: distribute;
            }

            .course-list {
                justify-content: space-around;
            }

            .button-hower {
                color: #4D5E6F;
            }

            .button-hower:hover {
                background-color: white;
                width: 250px;
                transition: all 0.3s ease-in-out;
            }

            .button-hower-selected {
                background-color: white;
                width: 250px;
                transition: all 0.3s ease-in-out;
            }

            .course-list {
                background-color: #DBE0E9;
                border-radius: 4px;
            }

            .subject-list {
                display: flex;
                flex-direction: row;
                flex-wrap: wrap;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                grid-gap: 20px;
            }

            .card-img {
                height: 215px;
            }

            .card-body-permanent {
                height: 160px;
                width: 298px;
                overflow: hidden;
            }

            .card-lesson {
                width: 300px;
            }

            .form-switch .form-check-input:focus {
                border-color: rgba(255, 255, 255, 0.192);
                box-shadow: 0 0 0 0 rgba(0, 0, 0, 0);
                background-image: url("data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'><circle r='3' fill='rgba(0,0,0,0.25)'/></svg>");
            }

            .form-switch .form-check-input:checked {
                background-color: #30D158;
                border-color: #30D158;
                background-image: url("data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'><circle r='3' fill='rgba(255,255,255,1.0)'/></svg>");
            }
        </style>
    </head>

    <body>
        <nav class="navbar navbar-expand-lg bg-body-tertiary container">
            <div class="container-fluid">
                <a class="navbar-brand" href="./HomePage">StuQuiz</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="search navbar-collapse" id="navbarSupportedContent"
                     style="display: flex; flex-direction: row-reverse;">

                    <ul class="navbar-nav ml-auto mb-3 mb-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                               aria-expanded="false">
                                <c:if test="${sessionScope.userAuthorization==null}">
                                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGU0uf9RH5npQE6jWFRwRHNWoTTyy4NuxPo0rzkJm8tA&s"
                                         alt="" style="height: 30px;width: 30px; border-radius: 50%;">
                                </c:if>
                                <c:if test="${sessionScope.userAuthorization!=null}">
                                    <img src="https://gcs.tripi.vn/public-tripi/tripi-feed/img/474074hYy/anh-nen-hoa-anh-dao-dep-nhat_025505349.jpg"
                                         alt="" style="height: 30px;width: 30px; border-radius: 50%;">
                                </c:if>
                            </a>
                            <ul class="dropdown-menu">
                                <c:if test="${sessionScope.userAuthorization!=null}">
                                    <li><a class="dropdown-item" href="#">View Profile</a></li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.userAuthorization!=null}">
                                    <li><a class="dropdown-item" href="./Logout">Logout</a></li>
                                    </c:if>
                                    <c:if test="${sessionScope.userAuthorization==null}">
                                    <li><a class="dropdown-item" href="./Account">Login/Register</a></li>
                                    </c:if>
                            </ul>
                        </li>
                    </ul>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked"
                               onchange="switchTheme()">
                    </div>
                </div>
            </div>
        </nav>
        <div class='container' style="display: flex; flex-direction: column; align-items: end; justify-content: center;">
            <div class='window'>
                <div class='order-info'>
                    <div class='order-info-content'>
                        <br>
                        <h1 class="center-text">Item information</h1>
                        <img src='${subject.subjectImage!=null?subject.subjectImage:"https://images2.thanhnien.vn/528068263637045248/2024/1/25/e093e9cfc9027d6a142358d24d2ee350-65a11ac2af785880-17061562929701875684912.jpg"}' alt="..." style="max-width: 500px; max-height: 400px;">
                        <span></span>
                        <div class='total'>
                            <span style='float:left;'>
                                <div class='thin dense'>Subject Code:</div>
                                <div class='thin dense'>Subject Name:</div>
                                <div class='thin dense'>Time:</div>
                                <div class='thin dense'>Cost:</div>
                                <div class='thin dense'>Discount:</div>
                                <h4>TOTAL</h4>
                            </span>
                            <span style='float:right; text-align:right;'>
                                <div class='thin dense'>${subject.subjectCode}</div>
                                <div class='thin dense'>${subject.getSubjectName()}</div>
                                <div class='thin dense'>${amount*3} Months</div>
                                <div class='thin dense'>${subject.subjectPrice}VND</div>
                                <div class='thin dense'>${subject.salePrice}%</div>
                                <h4>${item.itemPrice}VND</h4>
                            </span>
                        </div>
                    </div>
                </div>
                <div class='credit-info'>
                    <div class='credit-info-content'>
                        <h1 style="display: flex; flex-direction: column; justify-content: center; align-items: center;">Scan to Pay</h1>
                        <img src='https://img.vietqr.io/image/MB-686669999999-qr_only.jpg?amount=${item.itemPrice}&addInfo=start${item.transactionCode}end&accountName=Doan%20Hai%20Minh' class="rounded mx-auto d-block" alt="...">
                    </div>
                </div>
            </div>
        </div>
                    <form action="Lesson" hidden>
                        <input type="text" name="actionCheck" value="viewLessonList">
                        <input type="text" name="subjectId" value="${subject.subjectId}">
                    </form>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
                                   function switchTheme() {
                                       var checked = document.getElementById("flexSwitchCheckChecked").checked;
                                       console.log('Da xu ly qua day');
                                       if (checked) {
                                           document.documentElement.setAttribute("data-bs-theme", "light");
                                           setCookie('currentTheme', 'light', 1);
                                       } else {
                                           document.documentElement.setAttribute("data-bs-theme", "dark");
                                           setCookie('currentTheme', 'dark', 1);
                                       }
                                   }
                                   const getPreferredTheme = () => {
                                       return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
                                   }

                                   const setTheme = theme => {
                                       if (document.cookie.includes('currentTheme=light') || document.cookie.includes('currentTheme=dark')) {
                                           document.getElementById("flexSwitchCheckChecked").checked = (document.cookie.includes('currentTheme=light'));
                                           document.documentElement.setAttribute('data-bs-theme', document.cookie.includes('currentTheme=light') ? 'light' : 'dark');
                                       } else {
                                           if (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
                                               document.documentElement.setAttribute('data-bs-theme', 'dark')
                                           } else {
                                               document.documentElement.setAttribute('data-bs-theme', theme);
                                           }
                                       }
                                   }
                                   setTheme(getPreferredTheme());
                                   function setCookie(name, value, days) {
                                       const expires = new Date();
                                       expires.setTime(expires.getTime() + (days * 24 * 60 * 60 * 1000));
                                       document.cookie = name + "=" + value + ";expires=" + expires.toUTCString() + ";path=/";
                                   }
                                   const HEAD_URL = "https://docs.google.com/spreadsheets/d/";
                                   const SHEET_ID = "18G3krZrdNECgyumhlri5NNVuB7hCDlq3Z3UJv1Q-j94";
                                   const GID_STRING = "gviz/tq?sheet=DataPage";
                                   function callTransactionData(sizeOfCell) {
                                       let sheet_range = "A2:F" + (sizeOfCell + 1);
                                       let full_link = HEAD_URL + SHEET_ID + "/" + GID_STRING + "&range=" + sheet_range;
                                       fetch(full_link)
                                               .then(res => res.text())
                                               .then(rep => {
                                                   var dataOfSheet = JSON.parse(rep.substr(47).slice(0, -2)).table.rows;
                                                   dataOfSheet.forEach(r_data => {
                                                       console.log(r_data);
                                                       if (parseFloat(r_data.c[2].v + "") >=${item.itemPrice*0.99}) {
                                                           let tran = r_data.c[1].v.match(/start(.*?)end/);
                                                           if (tran) {
                                                               if (tran[1] == '${item.transactionCode}') {
                                                                   sendBuySignal(tran[1]);
                                                               }
                                                           }
                                                       }
                                                   });
                                               });
                                   }

                                   function sendBuySignal(transactionCode) {
                                       fetch('/StuQuiz/BuyAccept?transactionCode=' + transactionCode + "&amount=" + '${amount}', {
                                           method: 'GET'
                                       }).then(function (response) {
                                           if (response.status != 200) {
                                               console.log('Lỗi, mã lỗi ' + response.status);
                                               return;
                                           }
                                           response.text().then(data => {
                                               console.log(data)
                                               
//                                               if (e.status == "success") {
//                                                   
//                                               } else {
//                                               }
                                               window.open('./Lessons?actionCheck=viewLessonList&subjectId=${subject.subjectId}', '_self');
                                           })
                                       }).catch(err => {
                                           console.log('Error :-S', err)
                                       })

                                   }
                                   function testCall() {
                                       console.log("Hello");
                                   }
                                   setInterval(function () {
                                       callTransactionData(4);
                                   }, 2000);
    </script>

</html>
