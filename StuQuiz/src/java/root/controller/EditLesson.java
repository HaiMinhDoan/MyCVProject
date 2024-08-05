/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package root.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import root.DAO.LessonDAO;
import root.DAO.SubjectDAO;
import root.entities.main.Lesson;
import root.entities.main.Subject;
import root.entities.main.User;
import root.entities.sub.VotesInSubject;

/**
 *
 * @author admin
 */
public class EditLesson extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
            out.println("<title>Servlet EditLesson</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditLesson at " + request.getContextPath() + "</h1>");
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
        User user = (User) request.getSession().getAttribute("userAuthorization");
        if (user != null && user.getRoleLevel() == 3) {
            String actionCheck = request.getParameter("actionCheck");
            String lessonId = request.getParameter("lessonId");

            if (actionCheck != null && (actionCheck.equals("setInactive") || actionCheck.equals("setActive") || actionCheck.equals("updateLesson"))) {
                try {
                    LessonDAO lessondao = new LessonDAO();
                    Lesson lesson = lessondao.getById(lessonId);

                    if (actionCheck.equals("setInactive")) {
                        lessondao.setInactive(lessonId);
                    } else if (actionCheck.equals("setActive")) {
                        lessondao.setActive(lessonId);
                    } else if (actionCheck.equals("updateLesson")) {
                        String lessonName = request.getParameter("lessonName");
                        String videoLink = request.getParameter("videoLink");
                        String description = request.getParameter("description");
                        lessondao.lessonUpdateByTeacher(lessonId, lessonName, videoLink, description);
                    }

                    String subjectId = String.valueOf(lesson.getSubjectId());
                    response.sendRedirect("EditLesson?subjectId=" + subjectId);
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("ErrorPage");
                    return;
                }
            }

            try {
                LessonDAO lessondao = new LessonDAO();
                SubjectDAO subjectdao = new SubjectDAO();

                String subjectId = request.getParameter("subjectId");
                Subject subject = subjectdao.getById(subjectId);
                List<VotesInSubject> votes = subjectdao.getVotesInSubject(subjectId);
                List<Lesson> listLesson = lessondao.getListLessonBySubjectIdForTeacher(subjectId);
                List<Subject> relatedSubject = subjectdao.getRelatedSubject(subject.getCourseId());

                request.setAttribute("subject", subject);
                request.setAttribute("listLesson", listLesson);
                request.setAttribute("relatedSubject", relatedSubject);
                request.setAttribute("totalVotes", votes.stream()
                        .map(VotesInSubject::getTotalVote)
                        .collect(Collectors.toList()));
                request.getRequestDispatcher("EditLesson.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(EditLesson.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("ErrorPage");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(EditLesson.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("ErrorPage");
            }
        } else {
            response.sendRedirect("ErrorPage");
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
