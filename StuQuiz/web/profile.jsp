<%-- 
    Document   : profile
    Created on : May 22, 2024, 10:09:07 PM
    Author     : vtdle
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>StuQuiz - Profile</title>
        <style>
            /* My Profile */
            .profile-box {
                margin: 50px auto;
                padding: 20px;
                max-width: 1000px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border: 2px solid #ccc;
            }

            .my-profile {
                text-align: center;
                margin-bottom: 30px;
            }

            .profile-content {
                display: flex;
                align-items: flex-start;
                justify-content: space-around;
                gap: 20px;
            }

            .profile-images img {
                width: 200px;
                height: 250px;
                border-radius: 20%;
                border: 2px solid;
                object-fit: cover;
            }

            .information-profile {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .information-profile p {
                margin: 10px 0;
            }

            .profile-buttons {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }

            #edit-profile-btn,
            #change-password-btn {
                padding: 10px 20px;
                border-radius: 10px;
                background-color: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                margin-left: 3%;
            }

            /* Edit my profile and Change password modals */
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.4);
            }

            .modal-content {
                background-color: #fefefe;
                margin: 15% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 100%;
                max-width: 500px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .profile-close,
            .change-password-close {
                background-color: gray;
                padding: 10px;
                border-radius: 10px 10px 0 0;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .profile-close h6,
            .change-password-close h6 {
                margin: 0 auto;
                font-size: 20px;
            }

            .profile-close button,
            .change-password-close button {
                background: none;
                border: none;
                cursor: pointer;
            }

            #edit-profile,
            #change-password {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin: 20px 0;
            }

            #edit-profile div,
            #change-password div {
                width: 100%;
                margin-bottom: 20px;
            }

            .input-img,
            .input-name,
            .input-old-password,
            .input-new-password {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .save-change-profile-btn,
            .save-change-password-btn {
                width: fit-content;
                padding: 10px 20px;
                border-radius: 10px;
                background-color: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                margin-top: 20px;
            }

            .show {
                display: block;
            }

            /* Notice change password*/
            .notice {
                display: flex;
                justify-content: center;
                align-items: center;
                text-align: center;
                margin: 3% 30% 0 30%;
            }

            /* Enrolled Subjects */
            .enrolled-subjects {
                margin: 5%;
            }

            .enrolled-subjects h3 {
                font-size: 24px;
                margin-bottom: 20px;
            }

            .subject-card {
                margin-bottom: 20px;
            }

            .card-lesson {
                border: 1px solid #ddd;
                border-radius: 8px;
                transition: box-shadow 0.3s;
            }

            .card-lesson:hover {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .card-lesson .card-code {
                font-weight: bold;
                font-size: 16px;
                text-align: center;
            }

            .card-lesson .card-title {
                font-weight: bold;
                font-size: 16px;
                text-align: center;
            }

            .card-lesson img {
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
                height: 200px;
                object-fit: cover;
            }

            .card-lesson .completed {
                border: 2px solid red;
                background-color: #f9f9f9;
                display: flex;
            }

            @media (max-width: 768px) {
                .card-lesson img {
                    height: 150px;
                }
            }

            /* Search Subjects*/
            .search-subject {
                margin-left: 75%;
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
                                    <li><a class="dropdown-item" href="./ViewProfile">View Profile</a></li>
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
        <!-- Notice change password success or failed -->
        <c:if test="${not empty passwordSuccess}">
            <div class="alert alert-success notice">
                ${passwordSuccess}
            </div>
        </c:if>

        <c:if test="${not empty passwordError}">
            <div class="alert alert-danger notice">
                ${passwordError}
            </div>
        </c:if>

        <!-- My profile -->
        <div class="profile-box">
            <h2 class="my-profile"><strong>My Profile</strong></h2>

            <form action="ViewProfile" method="get">
                <div class="profile-content">
                    <div class="profile-images">
                        <img src="${user.userAvatar}" alt="Profile-Image"/>
                    </div>
                    <div class="information-profile">
                        <p><strong>My Name: </strong><span id="profile-name">${user.userName}</span></p>
                    </div>
                </div>              
            </form>

            <div class="profile-buttons">
                <button id="edit-profile-btn" type="button"><strong>Edit my profile</strong></button>
                <button id="change-password-btn" type="button"><strong>Change password</strong></button>
            </div>
        </div>

        <!-- Edit my profile -->
        <div id="edit-profile-modal" class="modal">
            <div class="modal-content">
                <div class="profile-close">
                    <h6><strong>Change your profile</strong></h6>
                    <button type="button" id="close-edit-profile-btn"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <div class="form-profile">
                    <form action="EditProfile" method="post" id="edit-profile">
                        <div>
                            <label for="profile-img" class="label-img"><strong>Image: </strong></label>
                            <input placeholder="Paste your image URL here" type="url" class="input-img" id="profile-img" name="edit-image">
                        </div>
                        <div>
                            <label for="profile-name" class="label-name"><strong>My Name: </strong></label>
                            <input placeholder="Enter your name" type="text" class="input-name" id="profile-name" name="edit-name"
                                   pattern="^[\p{L}0-9 ]{5,50}$" title="Name must be 5-50 characters long and cannot include special characters.">
                        </div>                     
                        <button class="save-change-profile-btn" type="submit"><strong>Save change</strong></button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Change password -->
        <div id="change-password-modal" class="modal">
            <div class="modal-content">
                <div class="change-password-close">
                    <h6><strong>Change your password</strong></h6>
                    <button type="button" id="close-change-password-btn"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <div class="form-change-password">
                    <form action="EditProfile" method="post" id="change-password">
                        <div>
                            <label for="old-password" class="label-old-password"><strong>Old Password: </strong></label>
                            <input placeholder="Enter your old password" type="password" class="input-old-password" id="old-password" name="old-password">
                        </div>
                        <div>
                            <label for="new-password" class="label-new-password"><strong>New Password: </strong></label>
                            <input placeholder="Enter your new password" type="password" class="input-new-password" id="new-password" name="new-password" pattern="^[A-Za-z\d]{8,16}$" title="Password must be at least 8-16 characters.">
                        </div>
                        <button class="save-change-password-btn" type="submit"><strong>Save change</strong></button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Search Subjects -->
        <div class="container mt-5">
            <form action="ViewProfile" method="get">
                <div class="row">
                    <div class="col-sm-8 d-flex search-subject">
                        <div class="form-group search-container mr-2">
                            <input id="search-subject" type="text" name="searchString" class="form-control" placeholder="Search for subjects..." value="${param.searchString}">
                        </div>
                        <button type="submit" class="btn btn-primary search-button"><i class="fas fa-search"></i></button>
                    </div>
                </div>
                <input type="hidden" name="isSearching" value="true">
            </form>
        </div>

        <!-- Enrolled Subjects -->
        <div class="enrolled-subjects">
            <h3><strong>Enrolled Subjects</strong></h3>
            <div class="d-flex flex-wrap justify-content-start mb-3">
                <button class="all btn btn-outline-danger me-2" onclick="viewList('all')"><strong>All</strong></button>
                <button class="ongoing btn btn-outline-primary me-2" onclick="viewList('ongoing')"><strong>Ongoing Subjects</strong></button>
                <button class="completed btn btn-outline-success" onclick="viewList('completed')"><strong>Completed Subjects</strong></button>
            </div>
            <div id="listSubjects" class="row">
                <c:forEach items="${listData}" var="o">
                    <div class="col-lg-4 col-md-6 mb-3">
                        <div class="card card-lesson ${o.learning ? 'ongoing' : 'completed'}">
                            <h5 class="card-code">${o.subject.subjectCode}</h5>
                            <img src="${o.subject.subjectImage}" class="card-img-top card-img" alt="Subject-Img">
                            <div class="card-body">
                                <h5 class="card-title">${o.subject.subjectName}</h5>
                                <p class="card-text">${o.subject.subjectDescription}</p>
                                <p class="card-text">Start date: ${o.startDate}</p>
                                <p class="card-text">End date: ${o.endDate}</p>
                                <c:if test="${not o.learning}">
                                    <p class="card-text"> Price: <span style="color: red;">${o.subject.subjectPrice} VND</span></p>
                                </c:if>
                            </div>
                            <div class="card-body d-flex justify-content-center">
                                <c:choose>
                                    <c:when test="${o.learning}">
                                        <a href="./Lessons?actionCheck=viewLessonList&subjectId=${o.subject.subjectId}" id="learn-enroll" class="btn btn-outline-danger">Learn</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="ViewEnrollSubject?subjectId=${o.subject.subjectId}" id="learn-enroll" class="btn btn-outline-danger">Enroll</a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
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
                    function setCookie(name, value, days) {
                        const expires = new Date();
                        expires.setTime(expires.getTime() + (days * 24 * 60 * 60 * 1000));
                        document.cookie = name + "=" + value + ";expires=" + expires.toUTCString() + ";path=/";
                    }
                    /* JS for pop-up */
                    const open_edit_profile_btn = document.getElementById('edit-profile-btn');
                    const open_change_password_btn = document.getElementById('change-password-btn');

                    const close_edit_profile_btn = document.getElementById('close-edit-profile-btn');
                    const close_change_password_btn = document.getElementById('close-change-password-btn');

                    const edit_profile_modal = document.getElementById('edit-profile-modal');
                    const change_password_modal = document.getElementById('change-password-modal');

                    open_edit_profile_btn.addEventListener('click', () => {
                        edit_profile_modal.classList.add('show');
                    });

                    open_change_password_btn.addEventListener('click', () => {
                        change_password_modal.classList.add('show');
                    });

                    close_edit_profile_btn.addEventListener('click', () => {
                        edit_profile_modal.classList.remove('show');
                    });

                    close_change_password_btn.addEventListener('click', () => {
                        change_password_modal.classList.remove('show');
                    });

                    /* JS for Enrolled Subjects button all, ongoing, completed*/
                    function viewList(typeOfList) {
                        const subjects = document.querySelectorAll('.card-lesson');

                        subjects.forEach(card => {
                            console.log('Card classes:', card.classList);
                            if (typeOfList === 'all') {
                                card.classList.remove('d-none');
                            } else if (typeOfList === 'ongoing') {
                                if (!card.classList.contains('ongoing')) {
                                    card.classList.add('d-none');
                                } else {
                                    card.classList.remove('d-none');
                                }
                            } else if (typeOfList === 'completed') {
                                if (!card.classList.contains('completed')) {
                                    card.classList.add('d-none');
                                } else {
                                    card.classList.remove('d-none');
                                }
                            }
                        });
                    }

        </script>
    </body>
</html>

