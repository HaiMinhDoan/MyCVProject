<%-- 
    Document   : registerAndLogin
    Created on : May 19, 2024, 4:56:30 PM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <style id="cm-font-family" class="cm-font-family" nonce="KPt0nZGV8w4="></style>
        <style type="text/css">@font-face {
                font-family:Lato;
                font-style:normal;
                font-weight:400;
                src:url(/cf-fonts/s/lato/5.0.18/latin/400/normal.woff2);
                unicode-range:U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+0304,U+0308,U+0329,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD;
                font-display:swap;
            }
            @font-face {
                font-family:Lato;
                font-style:normal;
                font-weight:400;
                src:url(/cf-fonts/s/lato/5.0.18/latin-ext/400/normal.woff2);
                unicode-range:U+0100-02AF,U+0304,U+0308,U+0329,U+1E00-1E9F,U+1EF2-1EFF,U+2020,U+20A0-20AB,U+20AD-20CF,U+2113,U+2C60-2C7F,U+A720-A7FF;
                font-display:swap;
            }
            @font-face {
                font-family:Lato;
                font-style:normal;
                font-weight:700;
                src:url(/cf-fonts/s/lato/5.0.18/latin-ext/700/normal.woff2);
                unicode-range:U+0100-02AF,U+0304,U+0308,U+0329,U+1E00-1E9F,U+1EF2-1EFF,U+2020,U+20A0-20AB,U+20AD-20CF,U+2113,U+2C60-2C7F,U+A720-A7FF;
                font-display:swap;
            }
            @font-face {
                font-family:Lato;
                font-style:normal;
                font-weight:700;
                src:url(/cf-fonts/s/lato/5.0.18/latin/700/normal.woff2);
                unicode-range:U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+0304,U+0308,U+0329,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD;
                font-display:swap;
            }
            @font-face {
                font-family:Lato;
                font-style:normal;
                font-weight:900;
                src:url(/cf-fonts/s/lato/5.0.18/latin-ext/900/normal.woff2);
                unicode-range:U+0100-02AF,U+0304,U+0308,U+0329,U+1E00-1E9F,U+1EF2-1EFF,U+2020,U+20A0-20AB,U+20AD-20CF,U+2113,U+2C60-2C7F,U+A720-A7FF;
                font-display:swap;
            }
            @font-face {
                font-family:Lato;
                font-style:normal;
                font-weight:900;
                src:url(/cf-fonts/s/lato/5.0.18/latin/900/normal.woff2);
unicode-range:U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+0304,U+0308,U+0329,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD;
                font-display:swap;
            }
            @font-face {
                font-family:Lato;
                font-style:italic;
                font-weight:400;
                src:url(/cf-fonts/s/lato/5.0.18/latin-ext/400/italic.woff2);
                unicode-range:U+0100-02AF,U+0304,U+0308,U+0329,U+1E00-1E9F,U+1EF2-1EFF,U+2020,U+20A0-20AB,U+20AD-20CF,U+2113,U+2C60-2C7F,U+A720-A7FF;
                font-display:swap;
            }
            @font-face {
                font-family:Lato;
                font-style:italic;
                font-weight:400;
                src:url(/cf-fonts/s/lato/5.0.18/latin/400/italic.woff2);
                unicode-range:U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+0304,U+0308,U+0329,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD;
                font-display:swap;
            }
            @font-face {
                font-family:Lato;
                font-style:italic;
                font-weight:700;
                src:url(/cf-fonts/s/lato/5.0.18/latin-ext/700/italic.woff2);
                unicode-range:U+0100-02AF,U+0304,U+0308,U+0329,U+1E00-1E9F,U+1EF2-1EFF,U+2020,U+20A0-20AB,U+20AD-20CF,U+2113,U+2C60-2C7F,U+A720-A7FF;
                font-display:swap;
            }
            @font-face {
                font-family:Lato;
                font-style:italic;
                font-weight:700;
                src:url(/cf-fonts/s/lato/5.0.18/latin/700/italic.woff2);
                unicode-range:U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+0304,U+0308,U+0329,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD;
                font-display:swap;
            }
            @font-face {
                font-family:Lato;
                font-style:italic;
                font-weight:900;
                src:url(/cf-fonts/s/lato/5.0.18/latin-ext/900/italic.woff2);
                unicode-range:U+0100-02AF,U+0304,U+0308,U+0329,U+1E00-1E9F,U+1EF2-1EFF,U+2020,U+20A0-20AB,U+20AD-20CF,U+2113,U+2C60-2C7F,U+A720-A7FF;
                font-display:swap;
            }
            @font-face {
                font-family:Lato;
                font-style:italic;
                font-weight:900;
                src:url(/cf-fonts/s/lato/5.0.18/latin/900/italic.woff2);
                unicode-range:U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+0304,U+0308,U+0329,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD;
                font-display:swap;
            }</style>
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <style>
            @import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700,800,900');

            body {
font-family: 'Poppins', sans-serif;
                font-weight: 300;
                font-size: 15px;
                line-height: 1.7;
            }

            a {
                cursor: pointer;
                transition: all 200ms linear;
            }

            a:hover {
                text-decoration: none;
            }

            .link {
                color: #c4c3ca;
            }

            .link:hover {
                color: #ffeba7;
            }

            p {
                font-weight: 500;
                font-size: 14px;
                line-height: 1.7;
            }

            h4 {
                font-weight: 600;
            }

            h6 span {
                padding: 0 20px;
                text-transform: uppercase;
                font-weight: 700;
            }

            .section {
                position: relative;
                width: 100%;
                display: block;
            }

            .full-height {
                min-height: 100vh;
            }

            [type="checkbox"]:checked,
            [type="checkbox"]:not(:checked) {
                position: absolute;
                left: -9999px;
            }

            .checkbox:checked+label,
            .checkbox:not(:checked)+label {
                position: relative;
                display: block;
                text-align: center;
                width: 60px;
                height: 16px;
                border-radius: 8px;
                padding: 0;
                margin: 10px auto;
                cursor: pointer;
                background-color: #ffeba7;
            }

            .checkbox:checked+label:before,
            .checkbox:not(:checked)+label:before {
                position: absolute;
                display: block;
                width: 36px;
                height: 36px;
                border-radius: 50%;
                color: #ffeba7;
                background-color: #102770;
                font-family: 'unicons';
                content: '⬉';
                z-index: 20;
                top: -10px;
                left: -10px;
                line-height: 36px;
                text-align: center;
                font-size: 24px;
                transition: all 0.5s ease;
            }

            .checkbox:checked+label:before {
                transform: translateX(44px) rotate(-270deg);
            }


            .card-3d-wrap {
                position: relative;
                width: 440px;
                max-width: 100%;
                height: 400px;
                -webkit-transform-style: preserve-3d;
                transform-style: preserve-3d;
                perspective: 800px;
                margin-top: 60px;
            }

            .card-3d-wrapper {
                width: 100%;
                height: 100%;
                position: absolute;
                top: 0;
                left: 0;
                -webkit-transform-style: preserve-3d;
transform-style: preserve-3d;
                transition: all 600ms ease-out;
            }

            .card-front,
            .card-back {
                width: 100%;
                height: 100%;
                background-color: #2a2b38;
                background-image: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/1462889/pat.svg');
                background-position: bottom center;
                background-repeat: no-repeat;
                background-size: 300%;
                position: absolute;
                border-radius: 6px;
                left: 0;
                top: 0;
                -webkit-transform-style: preserve-3d;
                transform-style: preserve-3d;
                -webkit-backface-visibility: hidden;
                -moz-backface-visibility: hidden;
                -o-backface-visibility: hidden;
                backface-visibility: hidden;
            }

            .card-back {
                transform: rotateY(180deg);
            }

            .checkbox:checked~.card-3d-wrap .card-3d-wrapper {
                transform: rotateY(180deg);
            }

            .center-wrap {
                position: absolute;
                width: 100%;
                padding: 0 35px;
                top: 50%;
                left: 0;
                transform: translate3d(0, -50%, 35px) perspective(100px);
                z-index: 20;
                display: block;
            }


            .form-group {
                position: relative;
                display: block;
                margin: 0;
                padding: 0;
            }

            .form-style {
                padding: 13px 20px;
                padding-left: 55px;
                height: 48px;
                width: 100%;
                font-weight: 500;
                border-radius: 4px;
                font-size: 14px;
                line-height: 22px;
                letter-spacing: 0.5px;
                outline: none;
                color: #c4c3ca;
                background-color: #1f2029;
                border: none;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
                box-shadow: 0 4px 8px 0 rgba(21, 21, 21, .2);
            }

            .form-style:focus,
            .form-style:active {
                border: none;
                outline: none;
                box-shadow: 0 4px 8px 0 rgba(21, 21, 21, .2);
            }

            .input-icon {
                position: absolute;
                top: 0;
                left: 18px;
                height: 48px;
                font-size: 24px;
                line-height: 48px;
                text-align: left;
                color: #ffeba7;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }

            .form-group input:-ms-input-placeholder {
                color: #c4c3ca;
                opacity: 0.7;
-webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }

            .form-group input::-moz-placeholder {
                color: #c4c3ca;
                opacity: 0.7;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }

            .form-group input:-moz-placeholder {
                color: #c4c3ca;
                opacity: 0.7;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }

            .form-group input::-webkit-input-placeholder {
                color: #c4c3ca;
                opacity: 0.7;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }

            .form-group input:focus:-ms-input-placeholder {
                opacity: 0;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }

            .form-group input:focus::-moz-placeholder {
                opacity: 0;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }

            .form-group input:focus:-moz-placeholder {
                opacity: 0;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }

            .form-group input:focus::-webkit-input-placeholder {
                opacity: 0;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }

            .btn {
                border-radius: 4px;
                height: 44px;
                font-size: 13px;
                font-weight: 600;
                text-transform: uppercase;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
                padding: 0 30px;
                letter-spacing: 1px;
                display: -webkit-inline-flex;
                display: -ms-inline-flexbox;
                display: inline-flex;
                -webkit-align-items: center;
                -moz-align-items: center;
                -ms-align-items: center;
                align-items: center;
                -webkit-justify-content: center;
                -moz-justify-content: center;
                -ms-justify-content: center;
                justify-content: center;
                -ms-flex-pack: center;
                text-align: center;
                border: none;
                background-color: #ffeba7;
                color: #102770;
                box-shadow: 0 8px 24px 0 rgba(255, 235, 167, .2);
            }

            .btn:active,
            .btn:focus {
                background-color: #102770;
                color: #ffeba7;
                box-shadow: 0 8px 24px 0 rgba(16, 39, 112, .2);
            }

            .btn:hover {
                background-color: #102770;
                color: #ffeba7;
box-shadow: 0 8px 24px 0 rgba(16, 39, 112, .2);
            }




            .logo {
                position: absolute;
                top: 30px;
                right: 30px;
                display: block;
                z-index: 100;
                transition: all 250ms linear;
            }

            .logo img {
                height: 26px;
                width: auto;
                display: block;
            }
        </style>
    </head>

    <body>
        <nav class="navbar navbar-expand-lg bg-body-tertiary container">
            <div class="container-fluid">
                <a class="navbar-brand" href="./HomePage">StuQuiz</a>
                <div class="search navbar-collapse" id="navbarSupportedContent" style="display: flex;">
                </div>
            </div>
        </nav>
        <div class="section">
            <div class="container">
                <div class="row full-height justify-content-center">
                    <div class="col-12 text-center align-self-center py-5">
                        <div class="section pb-5 pt-5 pt-sm-2 text-center">
                            <div class="card-3d-wrap mx-auto">
                                <div class="card-3d-wrapper">
                                    <div class="card-front">
                                        <div class="center-wrap">
                                            <div class="section text-center">
                                                <form action="ForgetPass" method="post">
                                                    <h4 class="mb-4 pb-3" style="color: #ffeba7">Forgot password</h4>
                                                    <div class="form-group">
                                                        <input type="email" name="email" class="form-style"
                                                               placeholder="Your Email" id="email" autocomplete="off" value="${email}">
                                                        <i class="input-icon uil uil-at"></i>
                                                    </div>
                                                    <button type="submit" name="actionCheck" class="btn mt-4" value="login">submit</button>
                                                
                                                            <div style="color: red" ${errorMess!=null?"hiden":""}>${errorMess}</div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                               
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</html>
