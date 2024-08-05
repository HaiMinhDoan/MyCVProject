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
import root.DAO.UserDAO;
import root.constantservices.MailService;
import root.constantservices.RandomService;
import root.entities.main.User;

/**
 *
 * @author user
 */
@WebServlet(name = "ForgetPass", urlPatterns = {"/ForgetPass"})
public class ForgetPass extends HttpServlet {

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
            out.println("<title>Servlet ForgetPass</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgetPass at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("forgotpass.jsp").forward(request, response);

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
        request.setAttribute("isLogin", false);
        String email = request.getParameter("email");
        request.setAttribute("email", email);
        UserDAO userDAO = new UserDAO();

        if (userDAO.checkExistByEmail(email) == null) {
            String errorMess = "<span>This email do not exxist in databse</span><br>";
            request.setAttribute("errorMess", errorMess);
            request.getRequestDispatcher("forgotpass.jsp").forward(request, response);
        } else {
            String activeCode = RandomService.getRandomActiveCode(10L);
            String verifyLink = "http://localhost:9999/StuQuiz/ConfirmChangePass?email=" + email;
            String tagLink = "<a href='" + verifyLink + "'>Click here</a><br>" + "<h2>Verify Code: " + activeCode + "</h2>";
            boolean sendMailSuccess = MailService.sentEmail(email, "Click to below link to verify change your account password", tagLink);
            if (sendMailSuccess) {
                userDAO.setKeyByEmail(email, activeCode);
                request.setAttribute("errorMess", "Please check your email");
                request.getRequestDispatcher("forgotpass.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMess", "email is not valid");
                request.getRequestDispatcher("forgotpass.jsp").forward(request, response);
            }
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
