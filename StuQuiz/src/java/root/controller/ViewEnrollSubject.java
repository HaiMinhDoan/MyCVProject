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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import root.DAO.ItemDAO;
import root.DAO.SubjectDAO;
import root.DAO.UserDAO;
import root.entities.main.Item;
import root.entities.main.Subject;
import root.entities.main.User;
import root.entities.sub.SubjectEnrolledAndStatus;

/**
 *
 * @author vtdle
 */
@WebServlet(name = "ViewEnrollSubject", urlPatterns = {"/ViewEnrollSubject"})
public class ViewEnrollSubject extends HttpServlet {

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
            out.println("<title>Servlet ViewEnrollSubject</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewEnrollSubject at " + request.getContextPath() + "</h1>");
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
        String subjectId = request.getParameter("subjectId");
        SubjectDAO subjectDAO = new SubjectDAO();
        if (!isInLicense(user.getUserId() + "", subjectId) && !isOwner(user.getUserId() + "", subjectId)) {
            try {
                List<SubjectEnrolledAndStatus> subjects = subjectDAO.getEnrollSubjectAndStatusBySubjectId(subjectId);
                request.setAttribute("subjects", subjects);
                request.getRequestDispatcher("enrollSubject.jsp").forward(request, response);
            } catch (SQLException | ClassNotFoundException e) {
                response.getWriter().println("Error: " + e.getMessage());
            }
        } else {
            response.sendRedirect("Lessons?actionCheck=viewLessonList&subjectId="+subjectId);
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

    public boolean isInLicense(String userId, String subjectId) {
        List<Item> listItems = new ArrayList<>();
        ItemDAO itemdao = new ItemDAO();
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
        UserDAO userdao = new UserDAO();
        SubjectDAO subjectdao = new SubjectDAO();
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
