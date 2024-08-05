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
import java.sql.SQLException;
import root.DAO.CourseDAO;
import root.entities.main.Course;
import root.entities.main.User;

/**
 *
 * @author vtdle
 */
@WebServlet(name = "EditCourseForAdmin", urlPatterns = {"/EditCourseForAdmin"})
public class EditCourseForAdmin extends HttpServlet {

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
            out.println("<title>Servlet EditCourseForAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCourseForAdmin at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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

        if (userAuthorization != null) {
            if (userAuthorization.getRoleLevel() == 1) {
                CourseDAO courseDAO = new CourseDAO();
                String action = request.getParameter("action");

                try {

                    String id = request.getParameter("id");
                    String name = request.getParameter("name");
                    String code = request.getParameter("code");
                    boolean isActive = request.getParameter("active") != null;

                    Course course = Course.builder()
                            .courseName(name)
                            .courseCode(code)
                            .isActive(isActive)
                            .build();

                    if ("add".equals(action)) {
                        if (id == null || id.isEmpty()) {
                            courseDAO.addNew(course);
                        }
                    } else if ("update".equals(action)) {
                        courseDAO.updateById(id, course);
                    } else if ("delete".equals(action)) {
                        courseDAO.deleteCourseAndReferencesByCourseId(id);
                    }
                    response.sendRedirect("ViewCourseForSaleAndAdmin");
                } catch (SQLException | ClassNotFoundException ex) {
                    response.getWriter().println("Error: " + ex.getMessage());
                }
            } else {
                response.sendRedirect("ErrorPage");
            }
        } else {
            response.sendRedirect("Account");
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
