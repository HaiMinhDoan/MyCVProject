/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import root.DAO.UserDAO;
import root.entities.main.User;

/**
 *
 * @author vtdle
 */
@WebServlet(name = "EditProfile", urlPatterns = {"/EditProfile"})
public class EditProfile extends HttpServlet {

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
            out.println("<title>Servlet EditProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProfile at " + request.getContextPath() + "</h1>");
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
            String editImage = request.getParameter("edit-image");
            String editName = request.getParameter("edit-name");
            String oldPassword = request.getParameter("old-password");
            String newPassword = request.getParameter("new-password");

            String userId = userAuthorization.getUserId() + "";

            HttpSession session = request.getSession();

            try {
                UserDAO userDAO = new UserDAO();
                User user = userDAO.getById(userId);

                boolean changePasswordRequested = (oldPassword != null && newPassword != null);

                if (changePasswordRequested) {

                    if (!user.getUserPassword().equals(oldPassword)) {
                        session.setAttribute("passwordError", "Incorrect old password. Please try again!!!");
                        response.sendRedirect("ViewProfile");
                        return;
                    }

                    user.setUserPassword(newPassword);
                    userDAO.updateById(userId, user);
                    session.setAttribute("passwordSuccess", "Password changed successfully");
                }

                if (editName != null) {
                    user.setUserAvatar(editImage);
                    user.setUserName(editName);
                    userDAO.updateById(userId, user);
                    session.setAttribute("profileUpdateSuccess", "Profile updated successfully");
                }

                response.sendRedirect("ViewProfile");

            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
                session.setAttribute("error", "An error occurred while updating profile. Please try again.");
                response.sendRedirect("ViewProfile");
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
