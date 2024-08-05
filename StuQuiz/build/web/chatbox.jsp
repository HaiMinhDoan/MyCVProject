<%-- 
    Document   : chatbox
    Created on : May 25, 2024, 11:11:21 PM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .hover-messBtn {
        border-radius: 50%;
        height: 30px;
        width: 30px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
    .mess-inbox-receiver{
        margin-left: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color:#3A3B3C;
        color: #dee2e6;
        max-width: 210px;
        width: fit-content;
        min-width: 30px;
        word-wrap: break-word;
        margin-top: 5px;
        margin-bottom: 5px;
        margin-left: 10px;
        min-height: 35px;
        border-radius:18px 18px 18px 0px;
    }
    .mess-inbox-sender {
        margin-right: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color:#0084ff ;
        color: #dee2e6;
        max-width: 210px;
        width: fit-content;
        min-width: 30px;
        word-wrap: break-word;
        margin-top: 5px;
        margin-bottom: 10px;
        margin-left: 10px;
        min-height: 35px;
        border-radius:18px 18px 0px 18px;
    }
    #textMessage {
        height: 38px;
        width: 300px;
        position: relative;
        padding-right: 50px; /* Khoảng cách ở bên phải input để button có thể nằm trong */
        /* Viền cho input */
        outline: none;
        border: none;
    }

    .button-inside-input {
        position: absolute;
        top: 50%; /* Giữa theo chiều cao */
        right: 20px; /* Khoảng cách từ bên phải của input */
        transform: translateY(-50%); /* Dịch lên 50% chiều cao để căn giữa theo chiều dọc */
    }
    .cover-box-sender {
        display: flex;
        justify-content: end;
    }
    .cover-box-receiver {
        display: flex;
        justify-content: start;
    }
    .combo-input {
        height: 40px;
        width: 335px;
        border-radius: 0px 0px 10px 10px;
        border: 1px solid #999;
        background-color: #121212;
    }
</style>
<div id="boxChatBody" hidden>

    <div id="textAreaMessage" style="overflow: scroll; overflow-x: hidden;argin-right: 20px;height: 450px; width: 350px; border: solid 0px; background-image: url('https://png.pngtree.com/background/20230528/original/pngtree-animation-backgrounds-wallpapers-wallpapers-2k-picture-image_2778513.jpg')"></div>
    <div id="combo-input" class="position-fixed mb-2 combo-input" style="margin-right: 20px; display: flex; flex-direction: row; justify-content: center;align-items: center">
        <input id="textMessage" type="text" placeholder="Chat with us to get help!"/> &nbsp&nbsp
        <button class="btn btn-sm btn-outline-info hover-messBtn button-inside-input" onclick="sendMessage('5')" type="button"><svg xmlns="http://www.w3.org/2000/svg" height="30px" viewBox="0 -960 960 960" width="30px" fill="#999999"><path d="M100-139v-683l807 342-807 341Zm81-125 515-216-515-218v146l252 72-252 71v145Zm0 0v-434 434Z"/></svg></button>
    </div>
    <br>

</div>
<div onclick="closeBoxChat()" class="position-fixed bottom-0 end-0 mb-2" style="margin-right: 10px; margin-bottom: 10px;height: 50px; width: 50px; border: solid 3px; border-radius:50%; display: flex; justify-content: center; align-items: center;">
    <svg xmlns="http://www.w3.org/2000/svg" height="30px" viewBox="0 -960 960 960" width="30px" fill="#999999"><path d="M242-399h309v-60H242v60Zm0-129h476v-60H242v60Zm0-128h476v-60H242v60ZM59-60v-749q0-37.59 26.91-64.79Q112.82-901 150-901h660q37.59 0 64.79 27.21Q902-846.59 902-809v501q0 37.17-27.21 64.09Q847.59-217 810-217H216L59-60Zm132-248h619v-501H150v548l41-47Zm-41 0v-501 501Z"/></svg>
</div>

<script type="text/javascript">
    var websocket = new WebSocket("ws://" + document.location.host + "/StuQuiz" + "/chat-customer/" + "${(sessionScope.userAuthorization.userId!=null)?sessionScope.userAuthorization.userId:0}" + "/" + '${(sessionScope.userAuthorization.userId!=null)?sessionScope.userAuthorization.activeCode:"0"}');
    websocket.onopen = function (message) {
        processOpen(message);
        sendStartSignal("5");
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
    var scollToVar = 0;
    function processMessage(message) {
        let objectMess = JSON.parse(message.data);
        if (objectMess.kind == 'message') {
            document.getElementById("textAreaMessage").innerHTML = "";
            objectMess.data.forEach((item) => {
                document.getElementById("textAreaMessage").innerHTML += inboxCreate(item.boxChatId, item.chatContent.toString(), item.senderId == ${sessionScope.userAuthorization!=null?sessionScope.userAuthorization.userId:0});
                document.getElementById("textAreaMessage").scrollTop = document.getElementById(item.boxChatId + "").offsetTop;
                scollToVar = item.boxChatId;
            });
        } else if (objectMess.kind == 'error') {
            alert(objectMess.data);
        }
    }
    function processClose(message) {
        document.getElementById("textAreaMessage").innerHTML += inboxCreate("Server Disconnect...");
    }
    function processError(message) {
        document.getElementById("textAreaMessage").innerHTML += inboxCreate("Error... " + message);
    }

    <c:if test="${sessionScope.userAuthorization!=null}">
    const inputEml = document.getElementById("textMessage").addEventListener('keydown', function (event) {
        if (event.key == 'Enter') {
            sendMessage('5');
        }
    });
    function sendMessage(reseiver) {
        if (typeof websocket !== 'undefined' && websocket.readyState === WebSocket.OPEN) {
            let mess = {
                boxChatId: 1,
                senderId: parseInt('${sessionScope.userAuthorization!=null?sessionScope.userAuthorization.userId:0}'),
                receiverId: parseInt(reseiver),
                chatContent: document.getElementById('textMessage').value,
                sendTime: null
            };
            let jsonObject = JSON.stringify(mess);
            let temp = document.getElementById('textMessage').value;
            if (temp === null || temp.replace(/\s+/g, '') === "") {
                textMessage.placeholder = "Please dont let it null!";
                textMessage.value = "";
            } else {
                websocket.send(jsonObject);
                textMessage.value = "";
            }
        }
    }
    </c:if>

    <c:if test="${sessionScope.userAuthorization==null}">
    textMessage.placeholder = "Please login to get help!";
    function sendMessage(salesManId) {
        alert("Please login to get help!");
        textMessage.value = "";
    }
    </c:if>
    function sendStartSignal() {
        if (typeof websocket !== 'undefined' && websocket.readyState === WebSocket.OPEN) {
            let mess = {
                boxChatId: 0,
                senderId: parseInt('${sessionScope.userAuthorization!=null?sessionScope.userAuthorization.userId:0}'),
                receiverId: 0,
                chatContent: null,
                sendTime: null
            };
            let jsonObject = JSON.stringify(mess);
            websocket.send(jsonObject);
            textMessage.value = "";
        }
    }
    function closeBoxChat() {
        document.getElementById("boxChatBody").hidden = !document.getElementById("boxChatBody").hidden;
        if (!document.getElementById("boxChatBody").hidden) {
            document.getElementById("textAreaMessage").scrollTop = document.getElementById(scollToVar + "").offsetTop;
        }
    }
    function inboxCreate(boxChatId, chatContent, isUserSend) {
        if (isUserSend == true) {
            return "<div class='cover-box-sender' id='" + boxChatId + "'><div class='mess-inbox-sender'><span style='display:flex;align-items: center; justify-content: center; margin-right:10px; margin-left:10px; word-break: break-word;'>" + chatContent + "</span></div></div>"
        }
        return "<div class='cover-box-receiver' id='" + boxChatId + "'><div class= 'mess-inbox-receiver'><span style='display:flex;align-items: center; justify-content: center; margin-right:10px; margin-left:10px; word-break: break-word;'>" + chatContent + "</span></div></div>"
    }

    function changeColorInputBox() {
        var color = document.documentElement.getAttribute("data-bs-theme").toString();
        if (color === "light") {
            document.getElementById("combo-input").style.backgroundColor = '#FFFFFF';
        } else {
            document.getElementById("combo-input").style.backgroundColor = '#121212';
        }
    }
</script>

