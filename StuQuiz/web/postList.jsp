<%-- 
    Document   : HomePage
    Created on : May 19, 2024, 11:43:11 PM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <style>
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

            .button-hower-selected{
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
                height: 100px;
                width: 100%;
                overflow: hidden;
            }
            .card-lesson {
                width: 100%;
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

                    <ul class="navbar-nav ml-auto mb-3 mb-lg-0" style="">
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
                                    <li><a class="dropdown-item"
                                           href="./Account">Login/Register</a></li>
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
        <br><br><br><br><br>
        <h2 class="mx-auto center-text">LET'S GO TO FIND YOUR POST</h2>
<div class="container text-center" style="position: sticky; top:0px; z-index: 9999;">
            <div class="row border course-list">

            </div>
        </div>
        <br><br><br>
        <div class="container text-center">
            <div class=" d-flex"  style="width: 100%; ">
                <form class="d-flex container" role="search" style="align-items: center;" action="PostList" method="get">
                    <div style="margin-right: 5%; width: 25%; ">
                        <label>Search</label>
                        <input class="form-control me-2" type="text" placeholder="Search by content or tag" aria-label="Search" name="content" value='${param.content}'>

                    </div>
                    <div style="margin-right: 5%; width: 25%;">
                        <label>From Date</label>
                        <input class="form-control me-2" type="date"  name="fromDate" value='${param.fromDate}'>
                    </div>
                    <div style="margin-right: 5%; width: 25%;">
                        <label>To Date</label>
                        <input class="form-control me-2" type="date"  name="toDate" value='${param.toDate}'>
                    </div>
                    <button class="btn btn-outline-success btn-sm" type="submit" style="margin-right: 20px; margin-top:24px; ">Search</button>

                </form>
            </div>
        </div>
        <br>
        <h3 class="container">
            List Post 
        </h3>
        <div class="container subject-list">
            <c:forEach items="${posts}" var="p">
                <div class="card card-lesson" style="display: flex; justify-content: space-between;flex-direction: row;">
                    <div style="width: 30%">
                        <img src="${p.postImage}" width="100%"  alt="...">
                    </div>
                    <div style="width: 70%">
                        <div class="card-body card-body-permanent">
                            <h5 class="card-title">${p.hashTag}</h5>
                            <div class="card-text" style="overflow: hidden; height: 50px;">${p.getSummary()}</div>
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Create date: ${p.createdDate} </li>
                            <div class="card-body">
                                <a href="./PostDetail?bid=${p.postId}" class="btn btn-outline-danger">Read more...</a>
                            </div>
                    </div>

                </div>
            </c:forEach>
        </div>

        <nav style="margin-left: 44%" aria-label="Page navigation example">
            <ul class="pagination">
                <li class="page-item"><a class="page-link" href="./PostList?index=1&content=${param.content}&fromDate=${param.fromDate}&toDate=${param.toDate}">First</a></li>
<c:forEach var="i" begin="1" end="${totalPages}" step="1">
                    <li class="page-item"><a class="page-link" href="./PostList?index=${i}&content=${param.content}&fromDate=${param.fromDate}&toDate=${param.toDate}">${i}</a></li>
                    </c:forEach>
                <li class="page-item"><a class="page-link" href="./PostList?index=${totalPages}&content=${param.content}&fromDate=${param.fromDate}&toDate=${param.toDate}">Last</a></li>
            </ul>
        </nav>


        <div class="position-fixed bottom-0 end-0 mb-3" style="z-index: 9999;">
            <jsp:include page="chatbox.jsp" /><br><br><br>
        </div>
        <br><br><br><br>
        <div>

            <!-- Footer -->
            <footer class="text-center text-lg-start text-white" style="background-color: #1c2331">
                <!-- Section: Social media -->
                <section
                    class="d-flex justify-content-between p-4" style="background-color: #6351ce">
                    <!-- Left -->
                    <div class="me-5">
                        <span>Get connected with us on social networks:</span>
                    </div>
                </section>
                <!-- Section: Social media -->

                <!-- Section: Links  -->
                <section class="">
                    <div class="container text-center text-md-start mt-5">
                        <!-- Grid row -->
                        <div class="row mt-3">
                            <!-- Grid column -->
                            <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
                                <!-- Content -->
                                <h6 class="text-uppercase fw-bold">Company name</h6>
                                <hr
                                    class="mb-4 mt-0 d-inline-block mx-auto"
                                    style="width: 60px; background-color: #7c4dff; height: 2px"
                                    />
                                <p>
                                    Here you can use rows and columns to organize your footer
                                    content. Lorem ipsum dolor sit amet, consectetur adipisicing
                                    elit.
                                </p>
                            </div>
                            <!-- Grid column -->

                            <!-- Grid column -->
                            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                                <!-- Links -->
                                <h6 class="text-uppercase fw-bold">Products</h6>
                                <hr
                                    class="mb-4 mt-0 d-inline-block mx-auto"
                                    style="width: 60px; background-color: #7c4dff; height: 2px"
                                    />
                                <p>
<a href="#!" class="text-white">MDBootstrap</a>
                                </p>
                                <p>
                                    <a href="#!" class="text-white">MDWordPress</a>
                                </p>
                                <p>
                                    <a href="#!" class="text-white">BrandFlow</a>
                                </p>
                                <p>
                                    <a href="#!" class="text-white">Bootstrap Angular</a>
                                </p>
                            </div>
                            <!-- Grid column -->

                            <!-- Grid column -->
                            <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
                                <!-- Links -->
                                <h6 class="text-uppercase fw-bold">Useful links</h6>
                                <hr
                                    class="mb-4 mt-0 d-inline-block mx-auto"
                                    style="width: 60px; background-color: #7c4dff; height: 2px"
                                    />
                                <p>
                                    <a href="#!" class="text-white">Your Account</a>
                                </p>
                                <p>
                                    <a href="#!" class="text-white">Become an Affiliate</a>
                                </p>
                                <p>
                                    <a href="#!" class="text-white">Shipping Rates</a>
                                </p>
                                <p>
                                    <a href="#!" class="text-white">Help</a>
                                </p>
                            </div>
                            <!-- Grid column -->

                            <!-- Grid column -->
                            <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
                                <!-- Links -->
                                <h6 class="text-uppercase fw-bold">Contact</h6>
                                <hr
                                    class="mb-4 mt-0 d-inline-block mx-auto"
                                    style="width: 60px; background-color: #7c4dff; height: 2px"
                                    />
                                <p><i class="fas fa-home mr-3"></i> New York, NY 10012, US</p>
                                <p><i class="fas fa-envelope mr-3"></i> info@example.com</p>
                                <p><i class="fas fa-phone mr-3"></i> + 01 234 567 88</p>
                                <p><i class="fas fa-print mr-3"></i> + 01 234 567 89</p>
                            </div>
                            <!-- Grid column -->
                        </div>
                        <!-- Grid row -->
                    </div>
                </section>
<!-- Section: Links  -->

                <!-- Copyright -->
                <div
                    class="text-center p-3"
                    style="background-color: rgba(0, 0, 0, 0.2)"
                    >
                    © 2020 Copyright:
                    <a class="text-white" href="https://mdbootstrap.com/"
                       >MDBootstrap.com</a
                    >
                </div>
                <!-- Copyright -->
            </footer>
            <!-- Footer -->
        </div>
        <!-- End of .container -->
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
                                   function switchTheme() {
                                       var checked = document.getElementById("flexSwitchCheckChecked").checked;
                                       console.log('Da xu ly qua day');
                                       if (checked) {
                                           document.documentElement.setAttribute("data-bs-theme", "light");
                                           changeColorInputBox()
                                           setCookie('currentTheme', 'light', 1);
                                       } else {
                                           document.documentElement.setAttribute("data-bs-theme", "dark");
                                           changeColorInputBox()
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
                                   changeColorInputBox()
                                   function setCookie(name, value, days) {
                                       const expires = new Date();
                                       expires.setTime(expires.getTime() + (days * 24 * 60 * 60 * 1000));
                                       document.cookie = name + "=" + value + ";expires=" + expires.toUTCString() + ";path=/";
                                   }

    </script>
</html>