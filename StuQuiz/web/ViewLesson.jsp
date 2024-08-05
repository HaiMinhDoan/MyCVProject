<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Lesson</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                display: flex;
                height: 100vh;
                background-color: gray;
            }

            .return-arrow {
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: darkgray;
                color: white;
                cursor: pointer;
                height: 100%;
                width: 50px;
                position: absolute;
                left: 0;
                top: 0;
            }

            .return-arrow:hover {
                background-color: #555;
            }

            .content {
                flex: 1;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 20px;
                box-sizing: border-box;
                overflow-y: auto; /* Add vertical scrolling */
            }

            .video-wrapper {
                width: 100%;
                max-width: 80%;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            iframe {
                width: 1080px;
                height: 607px;
                border: 2px solid #ccc;
                border-radius: 5px;
                display: block;
            }

            .interaction-container {
                margin-top: 10px;
                display: flex;
                justify-content: space-between;
                width: 100%;
                max-width: 80%;
            }

            .video-title {
                font-size: 20px;
                font-weight: bold;
            }

            .star-rating {
                display: flex;
                align-items: center;
            }

            .star-rating i {
                font-size: 30px;
                cursor: pointer;
                transition: color 0.2s;
            }
            .voted {
                color: #ff0;
            }
            .unvoted{
                color: #ccc;
            }
            .exam-link {
                margin-top: 10px;
                display: flex;
                align-items: center;
                width: 100%;
                max-width: 80%;
                background-color: white;
                padding: 10px;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .exam-link a {
                color: #007bff;
                text-decoration: none;
                font-weight: bold;
            }
            .exam-link a:hover {
                text-decoration: underline;
            }

            .sidebar {
                width: 250px;
                background-color: #555;
                padding: 15px;
                box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1);
                height: 100vh;
                box-sizing: border-box;
                overflow-y: auto; /* Add vertical scrolling */
            }

            .lesson-list ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .lesson-list li {
                background-color: white;
                margin: 5px 0;
                padding: 10px;
                border-radius: 5px;
                box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1);
            }

            .lesson-list a {
                color: black;
                text-decoration: none;
            }

            .lesson-list a:hover {
                text-decoration: underline;
            }

            .comments-section {
                width: 100%;
                margin-top: 20px;
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                list-style-type: none;
                overflow-y: auto; /* Add vertical scrolling */
                max-height: 400px; /* Set a maximum height for the comments section */
            }

            .comments-section h3 {
                margin-top: 0;
                font-size: 18px;
            }

            .comments-section input {
                padding: 10px;
                border-radius: 20px;
                box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1);
                width: 92%;
            }

            .comments-section button {
                padding: 10px;
            }

            .comments-section ul {
                list-style: none;
            }

            .user-comments h4,
            .user-comments p {
                display: inline;
                margin: 0;
            }

            .comments-option p,
            .comments-option a {
                display: inline;
                font-size: 15px;
            }

            .comments-option p {
                margin-left: 15px;
                color: grey;
            }

            .comments-option a {
                margin-left: 20px;
                font-weight: bold;
                text-decoration: none;
                color: grey;
            }

            .comments-option a:hover {
                text-decoration: underline;
                color: grey;
            }

            .rep-comments ul{
                margin-left: 20px;
            }

        </style>
    </head>
    <body>

        <div class="return-arrow" onclick="history.back()">←</div>

        <div class="content">
            <div class="video-wrapper">
                <div class="ratio ratio-16x9">
                    <iframe src="${lesson.videoLink}" title="YouTube video" allowfullscreen></iframe>
                </div>
                <div class="interaction-container">
                    <div class="video-title">
                        ${lesson.lessonName}
                    </div>
                    <div id="ratingForm">
                        <div class="star-rating">
                            <c:forEach var="star" begin="1" end="5">
                                <i id="star_${star}" class="${star <= (votes != null ? votes.star : 0) ? 'voted' : 'unvoted'}" onclick="changeStar(${star})">★</i>
                            </c:forEach>
                        </div>
                        <c:if test="${votes != null}">
                            <input type="hidden" name="voteId" value="${votes.voteId}">
                        </c:if>
                        <input type="hidden" name="rating" id="ratingInput">
                        <input type="hidden" name="lessonId" value="${lesson.lessonId}">
                    </div>
                </div>
                <%int count=1;%>
                <div class="exam-link">
                    <c:forEach items="${listQuizes}" var="quiz">
                        <a href="ViewExamResult?quizId=${quiz.quizId}" target="_blank">Go to Quiz <%=count%></a>
                        <%count++;%>
                    </c:forEach>
                </div>
                <div class="comments-section">
                    <h2>Comments</h2>
                    <div id="comment-area">
                        <c:forEach var="cusComment" items="${listCusComments}">
                            <ul id="cusComment_${cusComment.comment.commentId}">
                                <li id="headContent_${cusComment.comment.commentId}">
                                    <div class="user-comments">
                                        <h4>${cusComment.user.userId != sessionScope.userAuthorization.userId?cusComment.user.userName:"You"}:</h4>
                                        <p>${cusComment.comment.commentContent}</p>
                                    </div>
                                    <div class="comments-option">
                                        <a href="#" onclick="seeResponse(${cusComment.comment.commentId})">See responses</a>
                                        <a href="#" onclick="focusReplyComment(${cusComment.comment.commentId}, '${cusComment.user.userId != sessionScope.userAuthorization.userId?cusComment.user.userName:"You"}')">Reply</a>
                                    </div>
                                </li>
                            </ul>
                        </c:forEach>
                    </div>



                    <form id="commentForm">
                        <input type="text" hidden name="tagName" id="tagName">
                        <input id="commentText" name="commentContent" rows="4" cols="50" placeholder="Write your comment here...">
                        <input id="preCommentId" type="text" name="preCommentId" value="" hidden>
                        <input type="text" hidden name="lessonId" id="lessonId" value="${lesson.getLessonId()}">
                        <button type="button" onclick="sendComment()">Comment</button>
                    </form>
                    <div id="commentsContainer">
                        <!-- Comments will be dynamically added here -->
                    </div>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <h2>${subject.subjectName}</h2>
            <div class="lesson-list">
                <ul>
                    <c:forEach items="${listLesson}" var="listlesson">
                        <li>
                            <a href="Lessons?actionCheck=viewLesson&lessonId=${listlesson.lessonId}">${listlesson.lessonName}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <script>
            function focusReplyComment(commentId, userName) {
                document.getElementById("preCommentId").value = commentId;
                let tempContent = document.getElementById("commentText").value;
                let newTagName = "@" + userName;
                let oldTagName = document.getElementById("tagName").value;
                let checkHad = oldTagName === newTagName;
                if (!checkHad) {
                    let newContent = tempContent.replace(oldTagName, newTagName);
                    document.getElementById("commentText").value = newContent;
                    document.getElementById("tagName").value = newTagName;
                }
            }
            function changeStar(star) {
                document.getElementById("ratingInput").value = star + "";
                for (let i = 1; i <= 5; i++) {
                    if (i <= star) {
                        document.getElementById("star_" + i).classList.add("voted");
                        document.getElementById("star_" + i).classList.remove("unvoted");
                    } else {
                        document.getElementById("star_" + i).classList.add("unvoted");
                        document.getElementById("star_" + i).classList.remove("voted");
                    }
                }
                submitVoteApi();
            }


            function sendComment() {
                let lessonId = document.getElementById("lessonId").value;
                let preCommentId = document.getElementById("preCommentId").value;
                console.log(preCommentId);
                let commentText = document.getElementById("commentText").value;
                let tagName = document.getElementById("tagName").value;
                if (!commentText.startsWith(tagName)) {
                    preCommentId = "0";
                }
                if (commentText != null && commentText.trim() != '') {
                    let fetchLink = "/StuQuiz/Comments?actionCheck=postComment" + '&lessonId=' + lessonId + '&preCommentId=' + preCommentId + '&commentContent=' + commentText;
                    fetch(fetchLink, {
                        method: 'GET'
                    }).then(function (response) {
                        if (response.status != 200) {
                            alert("Bình luận thất bại");
                        }
                        response.text().then(data => {
                            let objectData = JSON.parse(data.toString());
                            console.log(data.toString());
                            if (objectData.status == 'success') {
                                makeComment('You', objectData.data);
                            } else {
                                alert("Bình luận thất bại");
                            }
                        });
                    }).catch(err => {
                        console.log('Error :-S', err)
                    })
                } else {
                    alert("Please dont let it null!")
                }
                document.getElementById("commentText").value = '';
            }
            function seeResponse(preCommentId) {
                let fetchLink = "/StuQuiz/Comments?actionCheck=seeResponse" + '&preCommentId=' + preCommentId + '&lessonId=' + '${lesson.lessonId}';
                let headContentText = document.getElementById("headContent_" + preCommentId).innerHTML;
                let reContent = "<li id='" + preCommentId + "'>" + headContentText + "</li>";
                fetch(fetchLink, {
                    method: 'GET'
                }).then(function (response) {
                    console.log(response);
                    if (response.status != 200) {
                        alert("Out of session!");
                    }
                    response.text().then(data => {
                        let objectData = JSON.parse(data.toString());
                        if (objectData.status == 'success') {
                            let lisCusComment = objectData.data;
                            document.getElementById("cusComment_" + preCommentId).innerHTML = "";
                            document.getElementById("cusComment_" + preCommentId).innerHTML = reContent;
                            lisCusComment.forEach((cusComment) => {
                                makeComment(${sessionScope.userAuthorization.userId} != cusComment.user.userId ? cusComment.user.userName : "You", cusComment.comment);
                            });
                        } else {
                        }
                    });
                }).catch(err => {
                    console.log('Error :-S', err)
                })
            }

            function makeComment(makerName, comment) {
                var commentContent = comment.commentContent;
                var preComment = comment.preComment;
                var commentId = comment.commentId;

                var stringHTML = `<ul id='cusComment_` + comment.commentId + `'>
    <li id='headContent_` + comment.commentId + `'>
        <div class='user-comments'>
            <h4>` + makerName + `:</h4>
            <p>` + comment.commentContent + `</p>
        </div>
        <div class='comments-option'>
            <a href='#' onclick='seeResponse(` + comment.commentId +
                        `)'>See responses</a>
            <a href='#' onclick='focusReplyComment(` + comment.commentId + ',' + `"` + makerName + `"`
                        + `)'>Reply</a>
        </div>
    </li>
</ul>
`;
                if (preComment !== 0) {
                    var oldBox = document.getElementById("cusComment_" + comment.preComment).innerHTML;
                    document.getElementById("cusComment_" + comment.preComment).innerHTML = oldBox + stringHTML;
                } else {
                    console.log("di qua 2");
                    var oldBox = document.getElementById("comment-area").innerHTML;
                    document.getElementById("comment-area").innerHTML = oldBox + stringHTML;
                }



            }

            function submitVoteApi() {
                let makerId = ${sessionScope.userAuthorization.userId};
                let lessonId = ${lesson.lessonId};
                let rating = parseInt(document.getElementById('ratingInput').value);
                let fetchLink = "/StuQuiz/Votes?makerId=" + makerId + '&lessonId=' + lessonId + '&rating=' + rating;
                fetch(fetchLink, {
                    method: 'GET'
                }).then(function (response) {
                    if (response.status != 200) {
                        console.log('Lỗi, mã lỗi ' + response.status);
                        return;
                    }
                    response.text().then(data => {
                        console.log(data);
                        resObject = JSON.parse(data);
                        if (resObject.isSuccess == 'true') {
                            document.getElementById("ratingInput").value = resObject.star;
                        }
                    });
                }).catch(err => {
                    console.log('Error :-S', err)
                })
            }

        </script>
    </body>
</html>
