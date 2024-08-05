/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package root.controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import root.DAO.CommentDAO;
import root.DAO.ItemDAO;
import root.DAO.LessonDAO;
import root.DAO.QuizDAO;
import root.DAO.SubjectDAO;
import root.DAO.SubjectStatisticDAO;
import root.DAO.UserDAO;
import root.DAO.VoteDAO;
import root.entities.main.Comment;
import root.entities.main.Item;
import root.entities.main.Lesson;
import root.entities.main.Quiz;
import root.entities.main.Subject;
import root.entities.main.SubjectStatistic;
import root.entities.main.User;
import root.entities.main.Vote;
import root.entities.sub.CusComment;
import root.entities.sub.VotesInSubject;

/**
 *
 * @author admin
 */
public class Lessons extends HttpServlet {

    LessonDAO lessondao = new LessonDAO();
    SubjectDAO subjectdao = new SubjectDAO();
    VoteDAO votedao = new VoteDAO();
    CommentDAO commentdao = new CommentDAO();
    UserDAO userdao = new UserDAO();
    ItemDAO itemdao = new ItemDAO();
    SubjectStatisticDAO statistic = new SubjectStatisticDAO();

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
        User user = (User) request.getSession().getAttribute("userAuthorization");
        String subjectId = request.getParameter("subjectId");
        if (user != null) {

            String actionCheck = request.getParameter("actionCheck");
            if (actionCheck == null) {
                actionCheck = "";
            }
            switch (actionCheck) {
                case "viewLessonList":
                    viewLessonList(request, response);
                    break;
                case "viewLesson":
                    viewLesson(request, response);
                    break;
            }
        } else {
            response.sendRedirect("Account");
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
        processRequest(request, response);

    }

    private void viewLessonList(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("userAuthorization");
        try {
            String subjectId = request.getParameter("subjectId");
            if (isInLicense(user.getUserId() + "", subjectId) || isOwner(user.getUserId() + "", subjectId)) {
                Subject subject = subjectdao.getById(subjectId);
                List<Lesson> listLesson = lessondao.getListLessonBySubjectId(subjectId);
                Long courseId = subject.getCourseId();
                List<Subject> relatedSubject = subjectdao.getRelatedSubject(courseId);
                List<VotesInSubject> votes = subjectdao.getVotesInSubject(subjectId);

                List<Float> totalVotes = votes.stream()
                        .map(VotesInSubject::getTotalVote)
                        .collect(Collectors.toList());

                if (user != null) {
                    Item item = itemdao.getBuyerId(user.getUserId() + "", subjectId + "");
                    if (item != null) {
                        request.setAttribute("item", item);
                    }
                }

                request.setAttribute("relatedSubject", relatedSubject);
                request.setAttribute("subject", subject);
                request.setAttribute("listLesson", listLesson);
                request.setAttribute("totalVotes", totalVotes);

                getRequestDispatch(request, response, "/LessonListForCus.jsp");
            } else {
                response.sendRedirect("ViewEnrollSubject?subjectId=" + subjectId);
            }

        } catch (Exception ex) {
            Logger.getLogger(Lessons.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void viewLesson(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("userAuthorization");
        String lessonId = request.getParameter("lessonId");
        if (user != null) {
            try {

                Lesson lesson = lessondao.getById(lessonId);
                if (isInLicense(user.getUserId() + "", lesson.getSubjectId() + "") || isOwner(user.getUserId() + "", lesson.getSubjectId() + "")) {
                    Subject subject = subjectdao.getById(lesson.getSubjectId() + "");
                    List<Lesson> listLesson = lessondao.getListLessonBySubjectId(lesson.getSubjectId() + "");
                    Vote votes = votedao.getVoteLessonByUserId(user.getUserId() + "", lessonId);
                    List<Comment> listComment = commentdao.getHeadCommentsByLessonId(lessonId);
                    List<CusComment> listCusComments = new ArrayList<>();
                    for (Comment comment : listComment) {
                        User userTemp = User.builder().userId(0L).build();
                        userTemp = userdao.getById(comment.getUserId() + "");

                        if (userTemp.getUserId() != 0L) {
                            CusComment cusComment = CusComment.builder()
                                    .user(userTemp)
                                    .comment(comment)
                                    .build();
                            listCusComments.add(cusComment);
                        }
                    }
                    QuizDAO quizDAO = new QuizDAO();
                    statistic.updateView(lesson.getSubjectId() + "");
                    List<Quiz> listQuizes = new ArrayList<>();
                    listQuizes = quizDAO.getListQuizByLessonId(lessonId);
                    request.setAttribute("listQuizes", listQuizes);
                    request.setAttribute("votes", votes);
                    request.setAttribute("lesson", lesson);
                    request.setAttribute("subject", subject);
                    request.setAttribute("listLesson", listLesson);
                    request.setAttribute("listCusComments", listCusComments);
                    request.setAttribute("user", user);

                    getRequestDispatch(request, response, "/ViewLesson.jsp");
                } else {
                    response.sendRedirect("ViewEnrollSubject?subjectId=" + lesson.getSubjectId());
                }
            } catch (Exception ex) {
                Logger.getLogger(Lessons.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                response.sendRedirect("./Account");
            } catch (Exception e) {
            }
        }
    }

    private void getRequestDispatch(HttpServletRequest request, HttpServletResponse response, String view) {
        RequestDispatcher rd = request.getRequestDispatcher(view);
        try {
            rd.forward(request, response);

        } catch (ServletException ex) {
            Logger.getLogger(Lessons.class
                    .getName()).log(Level.SEVERE, null, ex);

        } catch (IOException ex) {
            Logger.getLogger(Lessons.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean isInLicense(String userId, String subjectId) {
        List<Item> listItems = new ArrayList<>();
        Date currentDate = new Date();
        try {
            listItems = itemdao.getListItemsBySubjectIdAndUserId(subjectId, userId);
        } catch (Exception e) {
        }
        for (Item item : listItems) {
            boolean check = currentDate.after(item.getStartDate()) && currentDate.before(item.getEndDate());
            if (check) {
                return true;
            }
        }
        return false;
    }

    public boolean isOwner(String userId, String subjectId) {
        boolean check = false;

        try {
            Subject subject = subjectdao.getById(subjectId);
            User user = userdao.getById(userId);
            if (user.getRoleLevel() == 1) {
                return true;
            }
            Long userIdLong = subjectdao.parseLong(userId);
            if (subject.getOwnerId() == userIdLong) {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
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
