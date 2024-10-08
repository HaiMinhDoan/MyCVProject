<%-- 
    Document   : chatblock
    Created on : Jun 11, 2024, 12:14:31 AM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Messenger</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" />
        <link rel="stylesheet" href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" />
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/line-awesome/1.3.0/line-awesome/css/line-awesome.min.css" />
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300&;display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400&;display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@50&;display=swap');

            body {
                font-size: 14px;
                font-weight: 300;
                color: rgb(58, 65, 111);
                background-image: linear-gradient(to right, rgba(238, 240, 248, 0.5), rgb(238, 240, 248), rgba(238, 240, 248, 0.5));
                font-family: Poppins !important;
                margin: 0px;
            }

            html body a {
                color: rgb(0, 115, 152);
                cursor: pointer;
                transition: all 0.2s linear 0s;
            }

            .container {
                padding-right: 0;
                padding-left: 0;
            }

            @media (min-width: 1400px) {
                .container {
                    max-width: 1320px !important;
                }
            }

            .card-stacked {
                display: flex;
                flex-flow: row wrap;
            }

            .chat {
                position: relative;
            }

            .chat .chat-user-detail {
                position: absolute;
                left: 0px;
                width: 0px;
                opacity: 0;
                z-index: -4;
            }

            .chat .chat-header {
                border-bottom: 1px solid rgb(225, 225, 227);
                background: rgb(255, 255, 255);
            }

            .margin-auto {
                margin-top: auto !important;
                margin-bottom: auto !important;
            }

            .btn.btn-light-light:not(:disabled):not(.disabled).active,
            .btn.btn-light-light:not(:disabled):not(.disabled):active,
            .btn.btn-light:not(:disabled):not(.disabled).active,
            .btn.btn-light:not(:disabled):not(.disabled):active,
            .show>.btn.btn-light-light.dropdown-toggle,
            .show>.btn.btn-light.dropdown-toggle {
                color: rgb(126, 130, 153);
                background-color: rgb(238, 240, 249);
                border-color: rgb(238, 240, 249);
            }

            .feather {
                color: rgb(61, 81, 167);
                fill: rgba(108, 124, 195, 0.15);
            }

            .avatar-xxl {
                width: 110px;
                height: 110px;
            }

            .animate4 {
                animation: 3s cubic-bezier(0.1, 0.82, 0.25, 1) 0s 1 normal none running animate4;
            }

            .fw-300 {
                font-weight: 300 !important;
            }

            .h6,
            h6 {
                font-size: 1.175rem;
            }

            .btn.btn-icon.btn-sm {
                height: 30px;
                width: 30px;
            }

            .btn.btn-icon.btn-sm i {
                font-size: 1.2rem;
            }

            .btn.btn-icon i {
                font-size: 1.35rem;
            }

            a.btn i,
            button.btn i {
                font-size: 1rem;
                vertical-align: middle;
            }

            .btn.btn-light-skype {
                background-color: rgba(0, 175, 240, 0.125);
                color: rgb(0, 175, 240) !important;
            }

            .btn.btn-light-facebook {
                background-color: rgba(59, 89, 152, 0.125);
                color: rgb(59, 89, 152) !important;
            }

            .btn.btn-light-twitter {
                background-color: rgba(29, 161, 242, 0.125);
                color: rgb(29, 161, 242) !important;
            }

            .btn.btn-light-instagram {
                background-color: rgba(225, 48, 108, 0.125);
                color: rgb(225, 48, 108) !important;
            }

            .btn.btn-icon {
                height: calc(1.5em + 1.2rem);
                width: calc(1.5em + 1.2rem);
                color: rgb(255, 255, 255);
                display: inline-flex;
                -webkit-box-align: center;
                align-items: center;
                -webkit-box-pack: center;
                justify-content: center;
                cursor: pointer;
                padding: 0px;
            }

            .btn-circle,
            .flag-circle {
                border-radius: 50% !important;
            }

            .btn-shadow {
                box-shadow: rgba(50, 50, 93, 0.11) 0px 4px 6px, rgba(0, 0, 0, 0.08) 0px 1px 3px;
            }

            .btn-group-sm>.btn,
            .btn-sm {
                font-size: 0.725rem;
                line-height: 1.35;
                padding: 0.45rem 0.75rem;
                border-radius: 0.4rem;
            }

            .btn {
                font-size: 0.875rem;
                font-weight: 400 !important;
                border-radius: 0.4rem;
                border-width: 1px;
                border-style: solid;
                border-color: transparent;
                border-image: initial;
                padding: 0.5rem 1rem;
            }

            .chat .chat-profile-picture {
                cursor: pointer;
            }

            .chat-search {
                padding-top: 9px;
                padding-bottom: 9px;
                background: rgb(241, 242, 250);
                border-bottom: 1px solid rgb(225, 225, 227);
            }

            .chat-search .input-group {
                position: relative;
                box-shadow: rgb(242, 242, 246) 0px 0px 0px 2px !important;
                border-radius: 8px;
                background: rgb(238, 240, 249);
            }

            .form-control input,
            .form-group input,
            input {
                box-shadow: none;
                font-size: 0.9rem;
                font-weight: 300 !important;
                border-radius: 5px;
                border-width: 1px;
                border-style: solid;
                border-color: rgb(222, 226, 230);
                border-image: initial;
            }

            .avatar-sm {
                height: calc(1.5em + 1.2rem) !important;
                width: calc(1.5em + 1.2rem) !important;
            }

            .btn.btn-light:hover {
                color: rgb(63, 66, 84);
                background-color: rgb(228, 230, 239);
            }

            .btn.focus,
            .btn:focus,
            .form-control:focus,
            .form-group input:focus,
            .form-group:focus,
            input:focus {
                box-shadow: rgba(101, 118, 255, 0.1) 0px 0px 0px 3px;
                border-color: rgba(101, 118, 255, 0);
                outline: 0px;
            }

            .card {
                position: relative;
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                -webkit-box-orient: vertical;
                -webkit-box-direction: normal;
                -ms-flex-direction: column;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 1px solid rgba(0, 0, 0, .125);
                border-radius: 0.25rem;
            }

            .chat-search .input-group-text i {
                -webkit-transition: all .25s ease 0s;
                transition: all .25s ease 0s;
                cursor: pointer;
            }

            .drop-shadow {
                filter: drop-shadow(0 0 1px #504c4c54);
            }

            .fs-17 {
                font-size: 17px !important;
            }

            .chat-search .input-group-text {
                border-top-left-radius: 0 !important;
                border-bottom-left-radius: 0 !important;
                position: relative;
                padding-top: 0;
                padding-bottom: 0;
            }

            .input-group>.input-group-append>.btn,
            .input-group>.input-group-append>.input-group-text,
            .input-group>.input-group-prepend:first-child>.btn:not(:first-child),
            .input-group>.input-group-prepend:first-child>.input-group-text:not(:first-child),
            .input-group>.input-group-prepend:not(:first-child)>.btn,
            .input-group>.input-group-prepend:not(:first-child)>.input-group-text {
                border-top-left-radius: 0;
                border-bottom-left-radius: 0;
            }

            .chat-search .input-group-text,
            .chat-search input {
                font-size: 14px;
                box-shadow: unset !important;
                border-width: initial;
                border-style: initial;
                border-color: transparent;
                border-image: initial;
                background: rgb(255, 255, 255);
                border-radius: 8px;
            }

            .chat-search input {
                border-top-right-radius: 0px !important;
                border-bottom-right-radius: 0px !important;
            }

            .prepend-white .input-group-text {
                background-color: #fff;
            }

            .input-group-text {
                font-size: unset;
                font-weight: unset;
                background-color: #eef0fc;
            }

            .pr-2,
            .px-2 {
                padding-right: 0.5rem !important;
            }

            .input-group-text {
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                -webkit-box-align: center;
                -ms-flex-align: center;
                align-items: center;
                padding: 0.375rem 0.75rem;
                margin-bottom: 0;
                font-size: 1rem;
                font-weight: 400;
                line-height: 1.5;
                color: #495057;
                text-align: center;
                white-space: nowrap;
                background-color: #e9ecef;
                border: 1px solid #ced4da;
                border-radius: 0.25rem;
            }

            .archived-messages {
                cursor: pointer;
            }

            .archived {
                background-image: url(https://user-images.githubusercontent.com/35243461/168796895-2fc5e22b-06db-46b5-9854-d517778cfe57.svg);
            }

            .svg15 {
                height: 15px;
                width: 15px;
            }

            .fw-400 {
                font-weight: 400 !important;
            }

            .text-dark-75 {
                color: #3f4254 !important;
            }

            .chat-user-panel {
                border-top: 1px solid #eef0f9;
                cursor: pointer;
            }

            .chat-user-scroll {
                max-height: 620px;
                position: relative;
            }

            .chat .chat-item {
                border-bottom-width: 1px;
                border-bottom-style: dashed;
                border-bottom-color: #e4e6ef;
            }

            img.shadow {
                box-shadow: 0 15px 35px rgba(50, 50, 93, .15), 0 5px 15px rgba(0, 0, 0, .15) !important;
            }

            .double-check {
                background-image: url(https://user-images.githubusercontent.com/35243461/168796897-1db3c9e8-c8e4-47b5-8399-9ee230bcd35f.svg);
            }

            .chat .chat-item .message-shortcut {
                overflow: hidden;
                display: -webkit-box;
                -webkit-line-clamp: 1;
                -webkit-box-orient: vertical;
            }

            .fs-13 {
                font-size: 13px !important;
            }

            .fs-15 {
                font-size: 15px !important;
            }

            .pinned {
                background-image: url(https://user-images.githubusercontent.com/35243461/168796901-94490a54-e25d-4094-a91d-38f357898ad6.svg);
            }

            .svg18 {
                height: 18px;
                width: 18px;
            }

            .chat .chat-item.active,
            .chat .chat-item:hover {
                background-color: #f5f8fa;
            }

            .badge.round {
                border-radius: 1.5rem;
            }

            .badge-light-success {
                background-color: rgba(10, 187, 135, .1);
                color: #0abb87;
            }

            .badge {
                font-weight: 500;
                display: inline-block;
                padding: 0.4em 1.2em;
                font-size: 80% !important;
                text-align: center;
                vertical-align: baseline;
                border-radius: 0.25rem;
                transition: color .15s ease-in-out, background-color .15s ease-in-out, border-color .15s ease-in-out, box-shadow .15s ease-in-out;
            }

            .single-check {
                background-image: url(https://user-images.githubusercontent.com/35243461/168796902-03e56437-61b1-48a5-a55e-3dcc41a09deb.svg);
            }

            .double-check-blue {
                background-image: url(https://user-images.githubusercontent.com/35243461/168796899-499f66ce-ed05-404d-8f37-063165788b31.svg);
            }

            ::-webkit-input-placeholder {
                font-size: .8rem
            }

            ::-moz-placeholder {
                font-size: .8rem
            }

            :-ms-input-placeholder {
                font-size: .8rem
            }

            .shadow-line {
                box-shadow: rgba(62, 57, 107, 0.07) 0px 1px 15px 1px;
                border-width: 1px;
                border-style: solid;
                border-color: rgba(211, 218, 230, 0.43);
                border-image: initial;
            }

            .text-small {
                font-size: 12px !important;
            }

            .chat-panel-scroll {
                max-height: 680px;
                position: relative;
            }

            .horizontal-margin-auto {
                margin-right: auto !important;
                margin-left: auto !important;
            }

            .loader-animate3 {
                background-image: url(https://user-images.githubusercontent.com/35243461/168796900-207c2e2a-4a21-4ef0-9dc7-fd82e3e20073.svg);
            }

            .svg36 {
                height: 36px;
                width: 36px;
            }

            .letter-space {
                letter-spacing: 1.5px;
            }

            .fs-12 {
                font-size: 12px !important;
            }

            .chat.chat-panel .left-chat-message,
            .chat.chat-panel .right-chat-message {
                padding: 0.5rem 1rem;
                max-width: 47%;
            }

            .left-chat-message {
                position: relative;
                margin: 0 0 0 10px;
                background: #fff;
                width: fit-content;
                max-width: 60%;
                padding: 0.7rem 1rem;
                border-radius: 0.357rem;
                -webkit-box-shadow: 0 4px 8px 0 rgb(34 41 47 / 3%);
                box-shadow: 0 4px 8px 0 rgb(34 41 47 / 3%);
            }

            .chat.chat-panel .message-arrow,
            .chat.chat-panel .message-time {
                position: absolute;
                right: 5px;
                bottom: 5px;
                padding: 2px 6px;
                font-size: 11px;
                color: #6c757d;
                cursor: pointer;
            }

            .chat.chat-panel .message-arrow,
            .chat.chat-panel .message-time {
                position: absolute;
                right: 5px;
                bottom: 5px;
                padding: 2px 6px;
                font-size: 11px;
                color: #6c757d;
                cursor: pointer;
            }

            .chat.chat-panel .message-arrow {
                transform: scale(0);
            }

            .chat.chat-panel {
                background: linear-gradient(to bottom, #e9e4f07d, #d3cce34f);
            }

            .chat {
                position: relative;
            }

            .chat.chat-panel .left-chat-message,
            .chat.chat-panel .right-chat-message {
                padding: 0.5rem 1rem;
                max-width: 47%;
            }

            .chat.chat-panel .left-chat-message,
            .chat.chat-panel .right-chat-message {
                padding: 0.5rem 1rem;
                max-width: 47%;
            }

            .right-chat-message {
                position: relative;
                margin: 0 10px 0 0;
                background: linear-gradient(to right, #348ac7, #7474bf);
                color: #fff;
                width: fit-content;
                max-width: 60%;
                padding: 0.7rem 1rem;
                border-radius: 0.357rem;
                -webkit-box-shadow: 0 4px 8px 0 rgb(34 41 47 / 12%);
                box-shadow: 0 4px 8px 0 rgb(34 41 47 / 12%);
            }

            .chat.chat-panel .message-options.dark .message-arrow i,
            .chat.chat-panel .message-options.dark .message-time {
                color: #fff !important;
            }

            .chat.chat-panel .chat-upload-trigger {
                position: relative;
            }

            .chat.chat-panel .chat-upload.active {
                -webkit-transition: all .25s ease 0s;
                transition: all .25s ease 0s;
                transform: scale(1);
                bottom: 50px;
            }

            .chat.chat-panel .chat-upload {
                -webkit-transition: all .25s ease 0s;
                transition: all .25s ease 0s;
                transform: scale(0);
                position: absolute;
                left: -5px;
                bottom: -50px;
            }

            .btn.btn-light-secondary.btn-blushing,
            .btn.btn-secondary.btn-blushing {
                box-shadow: 1px 1px 1px 1px rgb(117 106 208 / 40%);
            }

            .btn.btn-secondary {
                color: #fff;
                background-color: #8950fc;
                border: 0;
            }

            .btn.btn-danger.btn-blushing,
            .btn.btn-light-danger.btn-blushing {
                box-shadow: 1px 1px 1px 1px #fd397a5c;
            }

            .btn.btn-light-warning.btn-blushing,
            .btn.btn-warning.btn-blushing {
                box-shadow: 1px 1px 1px 1px rgb(255 184 34 / 40%);
            }

            .btn.btn-light-success.btn-blushing,
            .btn.btn-success.btn-blushing {
                box-shadow: 1px 1px 1px 1px rgb(10 187 135 / 40%);
            }

            .btn.btn-light-secondary.btn-blushing,
            .btn.btn-secondary.btn-blushing {
                box-shadow: 1px 1px 1px 1px rgb(117 106 208 / 40%);
            }

            .chat-search .input-group-text i {
                -webkit-transition: all .25s ease 0s;
                transition: all .25s ease 0s;
                cursor: pointer;
            }

            .chat-search .input-group-text i:hover {
                -webkit-transition: all .25s ease 0s;
                transition: all .25s ease 0s;
                -webkit-transform: translateY(-2px) scale(1);
                transform: translateY(-2px) scale(1);
            }

            .fs-19 {
                font-size: 19px !important;
            }

            .chat.chat-panel .left-chat-message,
            .chat.chat-panel .right-chat-message {
                padding: .5rem 1rem;
                max-width: 47%
            }

            .chat.chat-panel .message-arrow {
                transform: scale(0);
            }

            .chat.chat-panel .left-chat-message:hover .message-time,
            .chat.chat-panel .right-chat-message:hover .message-time {
                -webkit-transition: all .25s ease 0s;
                transition: all .25s ease 0s;
                transform: scale(0);
            }

            .chat.chat-panel .left-chat-message:hover .message-arrow,
            .chat.chat-panel .right-chat-message:hover .message-arrow {
                -webkit-transition: all .25s ease 0s;
                transition: all .25s ease 0s;
                transform: scale(1);
            }

            .chat .chat-user-detail {
                position: absolute;
                left: 0;
                width: 0;
                opacity: 0;
                z-index: -4;
            }

            .chat .chat-user-detail.active {
                -webkit-transition: all .25s ease 0s;
                transition: all .4s cubic-bezier(1, .04, 0, .93) 0s;
                height: 100%;
                width: 100%;
                background: #f1f2fa;
                z-index: 1;
                opacity: 1;
            }

            .card {
                margin-bottom: 1.875rem;
                border: none;
                box-shadow: 0 1px 2px #00000030;
                border-radius: 0.45rem;
                width: 100%;
            }

            .btn.btn-light-skype.focus,
            .btn.btn-light-skype:focus,
            .btn.btn-light-skype:hover:not(:disabled):not(.disabled) {
                color: #fff !important;
                background-color: #00aff0;
                border-color: #00aff0;
            }

            .btn.btn-light-facebook.focus,
            .btn.btn-light-facebook:focus,
            .btn.btn-light-facebook:hover:not(:disabled):not(.disabled) {
                color: #fff !important;
                background-color: #3b5998;
                border-color: #3b5998;
            }

            .btn.btn-light-twitter.focus,
            .btn.btn-light-twitter:focus,
            .btn.btn-light-twitter:hover:not(:disabled):not(.disabled) {
                color: #fff !important;
                background-color: #1da1f2;
                border-color: #1da1f2;
            }

            .btn.btn-light-instagram.focus,
            .btn.btn-light-instagram:focus,
            .btn.btn-light-instagram:hover:not(:disabled):not(.disabled) {
                color: #fff !important;
                background-color: #e1306c;
                border-color: #e1306c;
            }

            /*perfect scrollbar*/
            .ps-container {
                -ms-touch-action: none;
                touch-action: none;
                overflow: hidden !important;
                -ms-overflow-style: none
            }

            @supports (-ms-overflow-style:none) {
                .ps-container {
                    overflow: auto !important
                }
            }

            @media screen and (-ms-high-contrast:active),
            (-ms-high-contrast:none) {
                .ps-container {
                    overflow: auto !important
                }
            }

            .ps-container.ps-active-x>.ps-scrollbar-x-rail,
            .ps-container.ps-active-y>.ps-scrollbar-y-rail {
                display: block;
                background-color: transparent
            }

            .ps-container.ps-in-scrolling {
                pointer-events: none
            }

            .ps-container.ps-in-scrolling.ps-x>.ps-scrollbar-x-rail {
                background-color: #eee;
                opacity: .9
            }

            .ps-container.ps-in-scrolling.ps-x>.ps-scrollbar-x-rail>.ps-scrollbar-x {
                background-color: #999
            }

            .ps-container.ps-in-scrolling.ps-y>.ps-scrollbar-y-rail {
                background-color: #eee;
                opacity: .9
            }

            .ps-container.ps-in-scrolling.ps-y>.ps-scrollbar-y-rail>.ps-scrollbar-y {
                background-color: #999
            }

            .ps-container>.ps-scrollbar-x-rail {
                display: none;
                position: absolute;
                -webkit-border-radius: 4px;
                -moz-border-radius: 4px;
                border-radius: 4px;
                opacity: 0;
                bottom: 3px;
                height: 8px
            }

            .ps-container>.ps-scrollbar-x-rail>.ps-scrollbar-x {
                position: absolute;
                background-color: #aaa;
                -webkit-border-radius: 4px;
                -moz-border-radius: 4px;
                border-radius: 4px;
                bottom: 0;
                height: 4px
            }

            .ps-container>.ps-scrollbar-y-rail {
                display: none;
                position: absolute;
                -webkit-border-radius: 4px;
                -moz-border-radius: 4px;
                border-radius: 4px;
                opacity: 0;
                right: 3px;
                width: 4px
            }

            .ps-container>.ps-scrollbar-y-rail>.ps-scrollbar-y {
                position: absolute;
                background-color: #a2adb7;
                -webkit-border-radius: 4px;
                -moz-border-radius: 4px;
                border-radius: 4px;
                right: 0;
                width: 4px
            }

            .ps-container:hover.ps-in-scrolling {
                pointer-events: none
            }

            .ps-container:hover.ps-in-scrolling.ps-x>.ps-scrollbar-x-rail {
                background-color: #eee;
                opacity: .9
            }

            .ps-container:hover.ps-in-scrolling.ps-x>.ps-scrollbar-x-rail>.ps-scrollbar-x {
                background-color: #a2adb7
            }

            .ps-container:hover.ps-in-scrolling.ps-y>.ps-scrollbar-y-rail {
                background-color: #eee;
                opacity: .9
            }

            .ps-container:hover.ps-in-scrolling.ps-y>.ps-scrollbar-y-rail>.ps-scrollbar-y {
                background-color: #a2adb7
            }

            .ps-container:hover>.ps-scrollbar-x-rail,
            .ps-container:hover>.ps-scrollbar-y-rail {
                opacity: .6
            }

            .ps-container:hover>.ps-scrollbar-x-rail:hover {
                background-color: #eee;
                opacity: .9
            }

            .ps-container:hover>.ps-scrollbar-x-rail:hover>.ps-scrollbar-x {
                background-color: #a2adb7
            }

            .ps-container:hover>.ps-scrollbar-y-rail:hover {
                background-color: #eee;
                opacity: .9
            }

            .ps-container:hover>.ps-scrollbar-y-rail:hover>.ps-scrollbar-y {
                background-color: #a2adb7
            }
            .chat-content{
                word-break: break-word;
            }
        </style>
    </head>

    <body>
        <a href="HomePage" class="btn-info btn" style="margin-top: 30px;margin-left: 30px">Back to home</a>
        <div class="main-wrapper">
            <div class="container">
                <div class="page-content">
                    <div class="container mt-5">
                        <div class="row">
                            <div class="col-md-4 col-12 card-stacked">
                                <div class="card shadow-line mb-3 chat">
                                    <div class="chat-user-detail">
                                        <div class="p-3 chat-header">
                                            <div class="w-100">
                                                <div class="d-flex pl-0">
                                                    <div class="d-flex flex-row mt-1 mb-1">
                                                        <span class="margin-auto mr-2">
                                                            <a href="#"
                                                               class="user-undetail-trigger btn btn-sm btn-icon btn-light active text-dark ml-2">
                                                                <svg viewBox="0 0 24 24" width="18" height="18"
                                                                     stroke="currentColor" stroke-width="2" fill="none"
                                                                     stroke-linecap="round" stroke-linejoin="round"
                                                                     class="feather">
                                                                <polyline points="15 18 9 12 15 6"></polyline>
                                                                </svg>
                                                            </a>
                                                        </span>
                                                        <p class="margin-auto fw-400 text-dark-75">Profile</p>
                                                    </div>
                                                    <div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="p-3 chat-user-info">
                                            <div class="card-body text-center">
                                                <a href="#!">
                                                    <img src='${sessionScope.userAuthorization!=null?(sessionScope.userAuthorization.userAvatar!=null?sessionScope.userAuthorization.userAvatar:
                                                                "https://user-images.githubusercontent.com/35243461/168796906-ab4fc0f3-551c-4036-b455-be2dfedb9680.svg"):
                                                                "https://user-images.githubusercontent.com/35243461/168796906-ab4fc0f3-551c-4036-b455-be2dfedb9680.svg"}'
                                                         class="rounded-circle img-fluid shadow avatar-xxl">
                                                </a>
                                                <div class="pt-4 text-center animate4">
                                                    <h6 class="fw-300 mb-1">${sessionScope.userAuthorization.userName}</h6>
                                                    <p class="text-muted">Web Developer</p>
                                                    <div class="mt-4">
                                                        <a href="#"
                                                           class="btn btn-light-skype btn-icon btn-circle btn-sm btn-shadow mr-2"><i
                                                                class="bx bxl-skype"></i></a>
                                                        <a href="#"
                                                           class="btn btn-light-facebook btn-icon btn-circle btn-sm btn-shadow mr-2"><i
                                                                class="bx bxl-facebook"></i></a>
                                                        <a href="#"
                                                           class="btn btn-light-twitter btn-icon btn-circle btn-sm btn-shadow mr-2"><i
                                                                class="bx bxl-twitter"></i></a>
                                                        <a href="#"
                                                           class="btn btn-light-instagram btn-icon btn-circle btn-sm btn-shadow mr-2"><i
                                                                class="bx bxl-instagram"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="p-3 chat-header">
                                        <div class="d-flex">
                                            <div class="w-100 d-flex pl-0">
                                                <img class="user-detail-trigger rounded-circle shadow avatar-sm mr-3 chat-profile-picture"
                                                     src='${sessionScope.userAuthorization!=null?(sessionScope.userAuthorization.userAvatar!=null?sessionScope.userAuthorization.userAvatar:
                                                            "https://user-images.githubusercontent.com/35243461/168796906-ab4fc0f3-551c-4036-b455-be2dfedb9680.svg"):
                                                            "https://user-images.githubusercontent.com/35243461/168796906-ab4fc0f3-551c-4036-b455-be2dfedb9680.svg"}' />
                                            </div>
                                            <div class="flex-shrink-0 margin-auto">
                                                <a href="#" class="btn btn-sm btn-icon btn-light active text-dark ml-2">
                                                    <svg viewBox="0 0 24 24" width="15" height="15" stroke="currentColor"
                                                         stroke-width="2" fill="none" stroke-linecap="round"
                                                         stroke-linejoin="round" class="feather">
                                                    <rect x="2" y="7" width="20" height="15" rx="2" ry="2"></rect>
                                                    <polyline points="17 2 12 7 7 2"></polyline>
                                                    </svg>
                                                </a>
                                                <a href="#" class="btn btn-sm btn-icon btn-light active text-dark ml-2">
                                                    <svg viewBox="0 0 24 24" width="15" height="15" stroke="currentColor"
                                                         stroke-width="2" fill="none" stroke-linecap="round"
                                                         stroke-linejoin="round" class="feather">
                                                    <path d="M12 20h9"></path>
                                                    <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z">
                                                    </path>
                                                    </svg>
                                                </a>
                                                <a href="#" class="btn btn-sm btn-icon btn-light active text-dark ml-2">
                                                    <svg viewBox="0 0 24 24" width="15" height="15" stroke="currentColor"
                                                         stroke-width="2" fill="none" stroke-linecap="round"
                                                         stroke-linejoin="round" class="feather">
                                                    <circle cx="12" cy="12" r="1"></circle>
                                                    <circle cx="12" cy="5" r="1"></circle>
                                                    <circle cx="12" cy="19" r="1"></circle>
                                                    </svg>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="chat-search pl-3 pr-3">
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="Search a conversation" id="searchArea" onkeyup="searchMessage()">
                                            <div class="input-group-append prepend-white">
                                                <span class="input-group-text pl-2 pr-2">
                                                    <i class="fs-17 las la-search drop-shadow"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="archived-messages d-flex p-3">
                                        <div class="w-100">
                                            <div class="d-flex pl-0">
                                                <div class="d-flex flex-row mt-1">
                                                    <span class="margin-auto mr-2">
                                                        <div class="svg15 archived"></div>
                                                    </span>
                                                    <p class="margin-auto fw-400 text-dark-75">Archived</p>
                                                </div>
                                                <div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="chat-user-panel">
                                        <div
                                            class="pb-3 d-flex flex-column navigation-mobile pagination-scrool chat-user-scroll" id="chat-list-user-panel">

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8 col-12 card-stacked">
                                <div class="card shadow-line mb-3 chat chat-panel">
                                    <div class="p-3 chat-header">
                                        <div class="d-flex">
                                            <div class="w-100 d-flex pl-0">
                                                <img class="rounded-circle shadow avatar-sm mr-3 chat-profile-picture"
                                                     src='${currentUserInChat.userId==0?
                                                            "https://user-images.githubusercontent.com/35243461/168796906-ab4fc0f3-551c-4036-b455-be2dfedb9680.svg":
                                                            (currentUserInChat.userAvatar!=null?currentUserInChat.userAvatar:
                                                            "https://user-images.githubusercontent.com/35243461/168796906-ab4fc0f3-551c-4036-b455-be2dfedb9680.svg")}'>
                                                <div class="mr-3">
                                                    <a href="#">
                                                        <p class="fw-400 mb-0 text-dark-75">${currentUserInChat.userId!=0?currentUserInChat.userName:"No user was slected"}</p>
                                                    </a>
                                                    <p class="sub-caption text-muted text-small mb-0"><i
                                                            class="la la-clock mr-1"></i>last seen today at 09:15 PM</p>
                                                </div>
                                            </div>
                                            <div class="flex-shrink-0 margin-auto">
                                                <a href="#" class="btn btn-sm btn-icon btn-light active text-dark ml-2">
                                                    <svg viewBox="0 0 24 24" width="15" height="15" stroke="currentColor"
                                                         stroke-width="2" fill="none" stroke-linecap="round"
                                                         stroke-linejoin="round" class="feather">
                                                    <circle cx="12" cy="12" r="10"></circle>
                                                    <line x1="12" y1="16" x2="12" y2="12"></line>
                                                    <line x1="12" y1="8" x2="12.01" y2="8"></line>
                                                    </svg>
                                                </a>
                                                <a href="#" class="btn btn-sm btn-icon btn-light active text-dark ml-2">
                                                    <svg viewBox="0 0 24 24" width="15" height="15" stroke="currentColor"
                                                         stroke-width="2" fill="none" stroke-linecap="round"
                                                         stroke-linejoin="round" class="feather">
                                                    <polygon points="23 7 16 12 23 17 23 7"></polygon>
                                                    <rect x="1" y="5" width="15" height="14" rx="2" ry="2"></rect>
                                                    </svg>
                                                </a>
                                                <a href="#" class="btn btn-sm btn-icon btn-light active text-dark ml-2">
                                                    <svg viewBox="0 0 24 24" width="15" height="15" stroke="currentColor"
                                                         stroke-width="2" fill="none" stroke-linecap="round"
                                                         stroke-linejoin="round" class="feather">
                                                    <circle cx="11" cy="11" r="8"></circle>
                                                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                                    </svg>
                                                </a>
                                                <a href="#" class="btn btn-sm btn-icon btn-light active text-dark ml-2">
                                                    <svg viewBox="0 0 24 24" width="15" height="15" stroke="currentColor"
                                                         stroke-width="2" fill="none" stroke-linecap="round"
                                                         stroke-linejoin="round" class="feather">
                                                    <circle cx="12" cy="12" r="1"></circle>
                                                    <circle cx="12" cy="5" r="1"></circle>
                                                    <circle cx="12" cy="19" r="1"></circle>
                                                    </svg>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="d-flex flex-row mb-3 navigation-mobile scrollable-chat-panel chat-panel-scroll" id="chatting-cover-box">
                                        <div class="w-100 p-3" id="chatting-area" style="min-height: 700px; max-height: 700px">

                                        </div>
                                    </div>
                                    <div class="chat-search pl-3 pr-3">
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="Write a message" id="textMessage" ${currentUserInChat.userId==0?"disabled":""}>
                                            <div class="input-group-append prepend-white">
                                                <span class="input-group-text pl-2 pr-2">
                                                    <i
                                                        class="chat-upload-trigger fs-19 bi bi-file-earmark-plus ml-2 mr-2"></i>
                                                    <i class="fs-19 bi bi-emoji-smile ml-2 mr-2"></i>
                                                    <i class="fs-19 bi bi-camera ml-2 mr-2"></i>
                                                    <i class="fs-19 bi bi-cursor ml-2 mr-2" onclick='sendMessageInput("${sessionScope.userAuthorization.userId}", "${currentUserInChat.userId}")'></i>
                                                    <div class="chat-upload">
                                                        <div class="d-flex flex-column">
                                                            <div class="p-2">
                                                                <button type="button"
                                                                        class="btn btn-secondary btn-md btn-icon btn-circle btn-blushing">
                                                                    <i class="fs-15 bi bi-camera"></i>
                                                                </button>
                                                            </div>
                                                            <div class="p-2">
                                                                <button type="button"
                                                                        class="btn btn-success btn-md btn-icon btn-circle btn-blushing">
                                                                    <i class="fs-15 bi bi-file-earmark-plus"></i>
                                                                </button>
                                                            </div>
                                                            <div class="p-2">
                                                                <button type="button"
                                                                        class="btn btn-warning btn-md btn-icon btn-circle btn-blushing">
                                                                    <i class="fs-15 bi bi-person"></i>
                                                                </button>
                                                            </div>
                                                            <div class="p-2">
                                                                <button type="button"
                                                                        class="btn btn-danger btn-md btn-icon btn-circle btn-blushing">
                                                                    <i class="fs-15 bi bi-card-image"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </span>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.6.7/js/min/perfect-scrollbar.jquery.min.js"></script>

        <script>

                                                        const websocket = new WebSocket("ws://" + document.location.host + "/StuQuiz/chat-sales-man/" +
                                                                "${(sessionScope.userAuthorization!=null)?sessionScope.userAuthorization.userId:0}/" +
                                                                "${currentUserInChat!=null?currentUserInChat.userId:0}/" + "${sessionScope.userAuthorization!=null?sessionScope.userAuthorization.activeCode:0}");
                                                        websocket.onopen = function (message) {
                                                            processOpen(message);
                                                            sendMessage("0", "0");
                                                        };
                                                        websocket.onmessage = function (message) {
                                                            processMessage(message);
                                                        };
                                                        websocket.onclose = function (message) {
                                                            processClose(message);
                                                        };
                                                        websocket.onerror = function (message) {
                                                            processError(message);
                                                        };
                                                        function processOpen(message) {
                                                            console.log("Connected!");
                                                        }
                                                        function processMessage(message) {
                                                            var objectMess = JSON.parse(message.data);
                                                            console.log(objectMess);
                                                            var scollPointEml;
                                                            if (objectMess.kind == 'message') {
                                                                var lastChatData = objectMess.data[objectMess.data.length - 1];
                                                                sendMessage(lastChatData.senderId + "", lastChatData.receiverId + "");
                                                            } else if (objectMess.kind == 'listblockchat') {
                                                                console.log(objectMess.data);
                                                                var snippetChatContentHeader = "<div class='svg36 loader-animate3 horizontal-margin-auto mb-2'></div>\n" +
                                                                        "    <div class='text-center letter-space drop-shadow text-uppercase fs-12 w-100 mb-3'>Today</div>";
                                                                document.getElementById("chat-list-user-panel").innerHTML = "";
                                                                document.getElementById("chatting-area").innerHTML = snippetChatContentHeader;
                                                                objectMess.data.forEach((item) => {
                                                                    document.getElementById("chat-list-user-panel").innerHTML += blockChatPanelCreate(item);
                                                                    if (item.user.userId ==${currentUserInChat.userId}) {
                                                                        item.listBoxChats.forEach((boxchat) => {
                                                                            document.getElementById("chatting-area").innerHTML += createBoxChatContent(boxchat);
                                                                            scollPointEml = "mess_" + boxchat.boxChatId;
                                                                        })
                                                                    }
                                                                })
                                                            }
                                                            document.getElementById("chatting-cover-box").scrollTop = document.getElementById(scollPointEml).offsetTop;
                                                        }
                                                        function processClose(message) {

                                                        }
                                                        function processError(message) {
                                                        }
                                                        const inputEml = document.getElementById("textMessage").addEventListener('keydown', function (event) {
                                                            if (event.key == 'Enter') {
                                                                sendMessageInput("${sessionScope.userAuthorization.userId}", "${currentUserInChat.userId}");
                                                            }
                                                        });
                                                        function  sendMessageInput(sender, reseiver) {
                                                            let temp = document.getElementById('textMessage').value;
                                                            if ((temp === null || temp.replace(/\s+/g, '') === "") && (parseInt(sender) != 0 || parseInt(reseiver) != 0)) {
                                                                document.getElementById('textMessage').placeholder = "Please dont let it null!";
                                                                document.getElementById('textMessage').value = "";
                                                            } else {
                                                                sendMessage(sender, reseiver);
                                                                document.getElementById('textMessage').placeholder = "Write a message";
                                                                document.getElementById('textMessage').value = "";
                                                            }
                                                        }
            <c:if test="${sessionScope.userAuthorization!=null}">
                                                        function searchMessage() {
                                                            if (typeof websocket !== 'undefined' && websocket.readyState === WebSocket.OPEN) {
                                                                console.log(document.getElementById('searchArea').value != null);
                                                                let mess = {
                                                                    boxChatId: 1,
                                                                    senderId: -1,
                                                                    receiverId: ${currentUserInChat.userId},
                                                                    chatContent: document.getElementById('searchArea').value != null ? (document.getElementById('searchArea').value) : ' ',
                                                                    sendTime: null
                                                                };
                                                                let jsonObject = JSON.stringify(mess);
                                                                websocket.send(jsonObject);
                                                            }
                                                        }
                                                        function sendMessage(sender, reseiver) {
                                                            if (typeof websocket !== 'undefined' && websocket.readyState === WebSocket.OPEN) {
                                                                let mess = {
                                                                    boxChatId: 1,
                                                                    senderId: parseInt(sender),
                                                                    receiverId: parseInt(reseiver),
                                                                    chatContent: document.getElementById('textMessage').value,
                                                                    sendTime: null
                                                                };
                                                                let jsonObject = JSON.stringify(mess);
                                                                websocket.send(jsonObject);
                                                            }
                                                        }
            </c:if>
                                                        function blockChatPanelCreate(blockChat) {
                                                            var userAvatar = (blockChat.user.userAvatar != null ? blockChat.user.userAvatar : 'https://user-images.githubusercontent.com/35243461/168796906-ab4fc0f3-551c-4036-b455-be2dfedb9680.svg')
                                                            var userName = blockChat.user.userName;
                                                            var userId = blockChat.user.userId;
                                                            var lastChatBox = blockChat.listBoxChats.length != 0 ? blockChat.listBoxChats[blockChat.listBoxChats.length - 1] : '';
                                                            var message = lastChatBox != '' ? lastChatBox.chatContent : '';
                                                            var sendTime = lastChatBox.sendTime;
                                                            var date = new Date(lastChatBox != '' ? sendTime : '');
                                                            var unSeenMess = blockChat.unSeenMess;
                                                            var chatBlockPanelSeen = "<a href='/StuQuiz/SaleChatDashBoard?customerId=" + userId + "'>\n" +
                                                                    "    <div class='chat-item d-flex pl-3 pr-0 pt-3 pb-3'>\n" +
                                                                    "        <div class='w-100'>\n" +
                                                                    "            <div class='d-flex pl-0'>\n" +
                                                                    "                <img class='rounded-circle shadow avatar-sm mr-3'\n" +
                                                                    "                    src='" + userAvatar + "'>\n" +
                                                                    "                <div>\n" +
                                                                    "                    <p class='margin-auto fw-400 text-dark-75'>" + userName + "</p>\n" +
                                                                    "                    <div class='d-flex flex-row mt-1'>\n" +
                                                                    "                        <span>\n" +
                                                                    "                            <div class='svg15 double-check'></div>\n" +
                                                                    "                        </span>\n" +
                                                                    "                        <span class='message-shortcut margin-auto text-muted fs-13 ml-1 mr-4'>" + message + "</span>\n" +
                                                                    "                    </div>\n" +
                                                                    "                </div>\n" +
                                                                    "            </div>\n" +
                                                                    "        </div>\n" +
                                                                    "        <div class='flex-shrink-0 margin-auto pl-2 pr-3'>\n" +
                                                                    "            <div class='d-flex flex-column'>\n" +
                                                                    "                <p class='text-muted text-right fs-13 mb-2'>" + (date.getDate() + "-") + ((date.getMonth() + 1) + "-") + (date.getFullYear() + "/") + (date.getHours() >= 10 ? ("" + date.getHours()) : ("0" + date.getHours())) + ":" + (date.getMinutes() >= 10 ? ("" + date.getMinutes()) : ("0" + date.getMinutes())) + "</p>\n" +
                                                                    "                <div class='text-right d-flex flex-row'>\n" +
                                                                    "                    <span>\n" +
                                                                    "                        <div class='svg18 pinned'></div>\n" +
                                                                    "                    </span>\n" +
                                                                    "                    <i class='text-muted la la-angle-down ml-1 fs-15'></i>\n" +
                                                                    "                </div>\n" +
                                                                    "            </div>\n" +
                                                                    "        </div>\n" +
                                                                    "    </div>\n" +
                                                                    "</a>";
                                                            var chatBlockPanelUnSeen = "<a href='/StuQuiz/SaleChatDashBoard?customerId=" + userId + "'>\n" +
                                                                    "    <div class='chat-item active d-flex pl-3 pr-0 pt-3 pb-3'>\n" +
                                                                    "        <div class='w-100'>\n" +
                                                                    "            <div class='d-flex pl-0'>\n" +
                                                                    "                <img class='rounded-circle shadow avatar-sm mr-3'\n" +
                                                                    "                    src='" + userAvatar + "'>\n" +
                                                                    "                <div>\n" +
                                                                    "                    <p class='margin-auto fw-400 text-dark-75'>" + userName + "</p>\n" +
                                                                    "                    <div class='d-flex flex-row mt-1'>\n" +
                                                                    "                        <span>\n" +
                                                                    "                            <div class='svg15 double-check'></div>\n" +
                                                                    "                        </span>\n" +
                                                                    "                        <span class='message-shortcut margin-auto fw-400 fs-13 ml-1 mr-4'>" + message + "</span>\n" +
                                                                    "                    </div>\n" +
                                                                    "                </div>\n" +
                                                                    "            </div>\n" +
                                                                    "        </div>\n" +
                                                                    "        <div class='flex-shrink-0 margin-auto pl-2 pr-3'>\n" +
                                                                    "            <div class='d-flex flex-column'>\n" +
                                                                    "                <p class='text-muted text-right fs-13 mb-2'>" + (date.getDate() + "-") + ((date.getMonth() + 1) + "-") + (date.getFullYear() + "/") + (date.getHours() >= 10 ? ("" + date.getHours()) : ("0" + date.getHours())) + ":" + (date.getMinutes() >= 10 ? ("" + date.getMinutes()) : ("0" + date.getMinutes())) + "</p>\n" +
                                                                    "                <span class='round badge badge-light-success margin-auto'>" + unSeenMess + "</span>\n" +
                                                                    "            </div>\n" +
                                                                    "        </div>\n" +
                                                                    "    </div>\n" +
                                                                    "</a>";
                                                            return blockChat.seen ? chatBlockPanelSeen : chatBlockPanelUnSeen;
                                                        }
                                                        function createBoxChatContent(boxChat) {
                                                            var chatContent = boxChat.chatContent;
                                                            var date = new Date(boxChat.sendTime);
                                                            var currentdate = new Date();
                                                            var sendTime = "";
                                                            if (isEqualsComparedByDate(date, currentdate) != 1) {
                                                                sendTime = (date.getDate() + "/") +
                                                                        ((date.getMonth() + 1) + "/") +
                                                                        (date.getFullYear());
                                                            } else {
                                                                sendTime = (date.getHours() >= 10 ? ("" + date.getHours()) : ("0" + date.getHours())) + ":" + (date.getMinutes() >= 10 ? ("" + date.getMinutes()) : ("0" + date.getMinutes()));
                                                            }

                                                            var leftChatContent = "<div class='left-chat-message fs-13 mb-2' id='mess_" + boxChat.boxChatId + "'>\n" +
                                                                    "    <p class='mb-0 mr-3 pr-4 chat-content'>" + chatContent + "</p>" + (isEqualsComparedByDate(date, currentdate) != 1 ? "<br><br>" : "") + "\n" +
                                                                    "    <div class='message-options'>\n" +
                                                                    "        <div class='message-time'>" + sendTime + "</div>\n" +
                                                                    "        <div class='message-arrow'><i class='text-muted la la-angle-down fs-17'></i></div>\n" +
                                                                    "    </div>\n" +
                                                                    "</div>";

                                                            var rightChatContent = "<div class='d-flex flex-row-reverse mb-2' id='mess_" + boxChat.boxChatId + "'>\n" +
                                                                    "    <div class='right-chat-message fs-13 mb-2'>\n" +
                                                                    "        <div class='mb-0 mr-3 pr-4'>\n" +
                                                                    "            <div class='d-flex flex-row'>\n" +
                                                                    "                <div class='pr-2 chat-content'>" + chatContent + "</div>" + (isEqualsComparedByDate(date, currentdate) != 1 ? "<br><br>" : "") + "\n" +
                                                                    "                <div class='pr-4'></div>\n" +
                                                                    "            </div>\n" +
                                                                    "        </div>\n" +
                                                                    "        <div class='message-options dark'>\n" +
                                                                    "            <div class='message-time'>\n" +
                                                                    "                <div class='d-flex flex-row'>\n" +
                                                                    "                    <div class='mr-2'>" + sendTime + "</div>\n" +
                                                                    "                    <div class='svg15 double-check'></div>\n" +
                                                                    "                </div>\n" +
                                                                    "            </div>\n" +
                                                                    "            <div class='message-arrow'><i class='text-muted la la-angle-down fs-17'></i></div>\n" +
                                                                    "        </div>\n" +
                                                                    "    </div>\n" +
                                                                    "</div>";
                                                            if (boxChat.senderId ==${currentUserInChat.userId}) {
                                                                return leftChatContent;
                                                            } else
                                                                return rightChatContent;
                                                        }

                                                        function isEqualsComparedByDate(time1, time2) {
                                                            var year1 = time1.getFullYear();
                                                            var year2 = time2.getFullYear();
                                                            var month1 = time1.getMonth()
                                                            var month2 = time2.getMonth()
                                                            var date1 = time1.getDate();
                                                            var date2 = time2.getDate();
                                                            if (year1 < year2)
                                                                return 0;
                                                            else if (year1 == year2) {
                                                                if (month1 < month2)
                                                                    return 0;
                                                                else if (month1 == month2) {
                                                                    if (date1 < date2)
                                                                        return 0;
                                                                    else if (date1 == date2)
                                                                        return 1;
                                                                    else
                                                                        return 2;
                                                                } else
                                                                    return 2;
                                                            } else
                                                                return 2;
                                                        }
                                                        (function () {
                                                            const scrollableChatPanel = document.querySelector('.scrollable-chat-panel');
                                                            scrollableChatPanel.style.overflow = 'auto'; // Assuming you want to use the default browser scrollbar behavior

                                                            const chatSearchElements = document.querySelectorAll('.chat-search');
                                                            const lastChatSearchElement = chatSearchElements[chatSearchElements.length - 1];
                                                            const position = lastChatSearchElement.getBoundingClientRect().top;
                                                            scrollableChatPanel.scrollTop = position;

                                                            const paginationScroll = document.querySelector('.pagination-scrool');
                                                            paginationScroll.style.overflow = 'auto'; // Assuming you want to use the default browser scrollbar behavior

                                                            const chatUploadTrigger = document.querySelector('.chat-upload-trigger');
                                                            chatUploadTrigger.addEventListener('click', function (e) {
                                                                const chatUpload = this.parentElement.querySelector('.chat-upload');
                                                                chatUpload.classList.toggle("active");
                                                            });

                                                            const userDetailTrigger = document.querySelector('.user-detail-trigger');
                                                            userDetailTrigger.addEventListener('click', function (e) {
                                                                const chatUserDetail = this.closest('.chat').querySelector('.chat-user-detail');
                                                                chatUserDetail.classList.toggle("active");
                                                            });

                                                            const userUndetailTrigger = document.querySelector('.user-undetail-trigger');
                                                            userUndetailTrigger.addEventListener('click', function (e) {
                                                                const chatUserDetail = this.closest('.chat').querySelector('.chat-user-detail');
                                                                chatUserDetail.classList.toggle("active");
                                                            });
                                                        })();
        </script>
    </body>

</html>