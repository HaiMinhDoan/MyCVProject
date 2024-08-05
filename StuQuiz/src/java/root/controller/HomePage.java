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
import java.util.ArrayList;
import java.util.List;
import root.DAO.CourseDAO;
import root.DAO.SubjectDAO;
import root.entities.main.Course;
import root.entities.sub.SubjectWithListItemAndLesson;

/**
 *
 * @author admin
 */
public class HomePage extends HttpServlet {

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
            out.println("<title>Servlet HomePage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePage at " + request.getContextPath() + "</h1>");
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
        CourseDAO courseDAO = new CourseDAO();
        SubjectDAO subjectDAO = new SubjectDAO();
        List<Course> listCourses = new ArrayList<>();
        List<SubjectWithListItemAndLesson> listNewSubject = new ArrayList<>();
        List<SubjectWithListItemAndLesson> listFeatureSubject = new ArrayList<>();
        try {
            listCourses = courseDAO.getAll();
            listNewSubject = subjectDAO.getNewSubjectWithListItemAndLesson("4");
            listFeatureSubject = subjectDAO.getFeatureSubjectWithListItemAndLesson("10", "3");
        } catch (Exception e) {
        }
        request.setAttribute("listFeatureSubject", listFeatureSubject);
        request.setAttribute("listNewSubject", listNewSubject);
        request.setAttribute("listCourses", listCourses);

        String searching = request.getParameter("searching");
        String courseId = request.getParameter("courseId");
        request.setAttribute("searchingCourse", (courseId==null||courseId.trim().equals(""))?"0":courseId);
        String searchText = request.getParameter("searchText");
        request.setAttribute("searchText", searchText);
        String isOldest = request.getParameter("isOldest");
        request.setAttribute("isOldest", isOldest);
        List<SubjectWithListItemAndLesson> listSearchedSubject = new ArrayList<>();
        if (searching!=null&&searching.equals("true")) {
            request.setAttribute("searching", searching);
            listSearchedSubject = subjectDAO.getListSubjectWithListItemAndLessonByCourseId((courseId==null||courseId.trim().equals(""))?"0":courseId, 
                    searchText==null?"":searchText,
                    isOldest==null?false:(isOldest.equals("true")));
            request.setAttribute("listSearchedSubject", listSearchedSubject);
        }

        request.getRequestDispatcher("HomePage.jsp").forward(request, response);
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
