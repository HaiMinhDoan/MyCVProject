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
import root.DAO.UserDAO;
import root.entities.main.User;

/**
 *
 * @author admin
 */
public class Verify extends HttpServlet {

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
            out.println("<title>Servlet Verify</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Verify at " + request.getContextPath() + "</h1>");
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
        String email = request.getParameter("email");
        String subemail = (String)request.getAttribute("subemail");
        if(subemail!=null){
            email = subemail;
            request.setAttribute("errorMess", "wrong pin code");
        }
        if (email != null) {
            UserDAO userDAO = new UserDAO();
            User user = new User();
            try {
                user = userDAO.getByEmail(email);
                if (user.isActive()) {
                    request.getRequestDispatcher("ErrorPage").forward(request, response);
                } else {
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("verify.jsp").forward(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("errorMess", "Create account not successfully!");
                request.setAttribute("isLogin", false);
                request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
            }
        } else {
            
            request.getRequestDispatcher("ErrorPage").forward(request, response);
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
        String email = request.getParameter("logemail");
        String logcode = request.getParameter("logcode");

        if (email != null && logcode != null) {
            UserDAO userDAO = new UserDAO();
            User user = new User();
            user.setUserId(0L);
            try {
                user = userDAO.getByEmail(email);

            } catch (Exception e) {
            }
            if (user.getUserId() == 0) {
                request.setAttribute("errorMess", "Activation failed because email was not loaded!");
                request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
            } else {
                if (logcode.equals(user.getActiveCode())) {
                    try {
                        user.setActive(true);
                        userDAO.updateById(user.getUserId() + "", user);
                        request.setAttribute("isLogin", true);
                        request.setAttribute("errorMess", "Activation successful, please log in!");
                        request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
                    } catch (Exception e) {
                        request.setAttribute("errorMess", "Activation failed because of server error!");
                        request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("subemail", email);
                    doGet(request, response);
                }
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
