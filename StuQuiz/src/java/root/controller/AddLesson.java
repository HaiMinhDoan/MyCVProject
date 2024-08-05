/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package root.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import root.DAO.LessonDAO;
import root.entities.main.Lesson;
import root.entities.main.User;

/**
 *
 * @author admin
 */
@WebServlet(name = "AddLesson", urlPatterns = {"/AddLesson"})
public class AddLesson extends HttpServlet {

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
            out.println("<title>Servlet AddLesson</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddLesson at " + request.getContextPath() + "</h1>");
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
        User userAuthorization = (User) request.getSession().getAttribute("userAuthorization");
        if (userAuthorization != null && (userAuthorization.getRoleLevel() == 3 || userAuthorization.getRoleLevel() == 1)) {
            String subjectId = request.getParameter("subjectId");
            request.setAttribute("subjectId", subjectId);
            request.getRequestDispatcher("AddLessons.jsp").forward(request, response);
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
        User userAuthorization = (User) request.getSession().getAttribute("userAuthorization");
        if (userAuthorization != null && (userAuthorization.getRoleLevel() == 3 || userAuthorization.getRoleLevel() == 1)) {
            Lesson lesson = new Lesson();
            Long subjectId = 0L;
            int row = Integer.parseInt(request.getParameter("maxL"));

            for (int i = 1; i <= row; i++) {
                String lessonNames = request.getParameter("lessonName" + i);
                subjectId = Long.parseLong(request.getParameter("subjectId"));
                String videoLinks = request.getParameter("videoLink" + i);
                String lessonDescriptions = request.getParameter("lessonDescription" + i);

                Date createDates = new Date();
                boolean isActives = true;

                lesson = Lesson.builder()
                        .lessonName(lessonNames)
                        .subjectId(subjectId)
                        .videoLink(videoLinks)
                        .lessonDescription(lessonDescriptions)
                        .createdDate(createDates)
                        .isActive(isActives)
                        .build();

                LessonDAO lessondao = new LessonDAO();
                try {
                    lessondao.addNew(lesson);
                } catch (Exception e) {
                    response.sendRedirect("ErrorPage");
                    return;
                }
            }
            response.sendRedirect("Lessons?actionCheck=viewLessonList&subjectId=" + subjectId);
        } else {
            response.sendRedirect("ErrorPage");
        }
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
