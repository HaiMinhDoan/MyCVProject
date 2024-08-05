/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package root.controller;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import root.DAO.CommentDAO;
import root.DAO.LessonDAO;
import root.DAO.UserDAO;
import root.entities.main.Comment;
import root.entities.main.Lesson;
import root.entities.main.User;
import root.entities.sub.CusComment;
import root.entities.sub.ResponseEntity;
import root.roleAndLevel.Kind;
import root.roleAndLevel.Status;

/**
 *
 * @author admin
 */
public class Comments extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Comments</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Comments at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        User userAuthorization = (User) request.getSession().getAttribute("userAuthorization");
        String lessonId = request.getParameter("lessonId");
        String actionCheck = request.getParameter("actionCheck");
        if (actionCheck == null) {
            actionCheck = "";
        }
        LessonDAO lessonDAO = new LessonDAO();
        if (lessonId == null) {
            lessonId = "0";
        }
        Lesson lesson = Lesson.builder().lessonId(0L).build();
        try {
            lesson = lessonDAO.getById(lessonId);
        } catch (Exception e) {
            lesson = Lesson.builder().lessonId(0L).build();
        }
        if (userAuthorization != null && lesson.getLessonId() != 0L) {
            CommentDAO commentDAO = new CommentDAO();
            Gson gson = new Gson();
            if (actionCheck.equals("postComment")) {
                String preCommentId = request.getParameter("preCommentId");
                if (preCommentId == null || preCommentId.trim().equals("")) {
                    preCommentId = "0";
                }
                String commentContent = request.getParameter("commentContent");

                Comment comment = Comment.builder()
                        .userId(userAuthorization.getUserId())
                        .lessonId(lesson.getLessonId())
                        .preComment(commentDAO.parseLong(preCommentId))
                        .commentContent(commentContent)
                        .commentTime(new Date())
                        .isActive(true)
                        .build();
                boolean checkAdd = false;
                Long checkId = 0L;
                Comment addedComment = Comment.builder().commentId(0L).build();
                try {
                    checkId = commentDAO.addNewCommentAndGetId(comment);
                    addedComment = commentDAO.getById(checkId + "");
                } catch (Exception e) {
                    checkAdd = false;
                    e.printStackTrace();
                }
                if (checkId > 0) {
                    ResponseEntity responseEntity = ResponseEntity.builder()
                            .kind(Kind.ADD_COMMENT)
                            .status(Status.SUCCESS)
                            .data(addedComment)
                            .build();
                    String jsonObject = gson.toJson(responseEntity);
                    response.getWriter().write(jsonObject);
                } else {
                    ResponseEntity responseEntity = ResponseEntity.builder()
                            .kind(Kind.ADD_COMMENT)
                            .status(Status.FAIL)
                            .data(comment)
                            .build();
                    String jsonObject = gson.toJson(responseEntity);
                    response.getWriter().write(jsonObject);
                }
            } else if (actionCheck.equals("seeResponse")) {
                String preCommentId = request.getParameter("preCommentId");
                if (preCommentId == null || preCommentId.trim().equals("")) {
                    preCommentId = "0";
                }
                List<CusComment> listCusComments = new ArrayList<>();
                List<Comment> listComments = new ArrayList<>();
                try {
                    listComments = commentDAO.getListCommentByPreComment(preCommentId);
                } catch (Exception e) {
                }
                UserDAO userDAO = new UserDAO();
                for (Comment c : listComments) {
                    User user = User.builder().userId(0L).build();
                    try {
                        user = userDAO.getById(c.getUserId() + "");
                    } catch (Exception e) {
                        user = User.builder().userId(0L).build();
                    }
                    if(user.getUserId()!=0L){
                        listCusComments.add(CusComment.builder()
                                .user(user)
                                .comment(c)
                                .build());
                    }
                }
                ResponseEntity responseEntity = ResponseEntity.builder()
                        .kind(Kind.SEE_LIST_COMMENT)
                        .status(listCusComments.size()>0?Status.SUCCESS:Status.FAIL)
                        .data(listCusComments)
                        .build();
                String jsonObject = gson.toJson(responseEntity);
                response.getWriter().write(jsonObject);
            }
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
