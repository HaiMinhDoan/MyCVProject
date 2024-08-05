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
import java.util.List;
import root.DAO.UserDAO;
import root.entities.main.User;

/**
 *
 * @author HP
 */
public class SaleAccountController extends HttpServlet {

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
            out.println("<title>Servlet SaleAccountController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaleAccountController at " + request.getContextPath() + "</h1>");
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
        if (userAuthorization != null && userAuthorization.getRoleLevel() == 2){
            String action = request.getParameter("action");
        action = action != null ? action : "";
        UserDAO userDAO = new UserDAO();
        switch (action) {
            case "view":
                try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                User user = userDAO.getByIdStaff(userId + "");
                if (user != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("../detail-account_sale.jsp").forward(request, response);
                } else {
                    response.sendRedirect("../sale/account?message=Can not found this user");
                }
            } catch (Exception e) {
                System.out.println("Error: " + e);
                response.sendRedirect("../sale/account");
            }
            break;
            default:
                List<User> users = userDAO.getAllByStaff();
                request.setAttribute("userList", users);
                request.getRequestDispatcher("../account_sale.jsp").forward(request, response);
        }
        } else {
             response.sendRedirect("../Account");
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
        String action = request.getParameter("action");
        action = action != null ? action : "";
        switch (action) {
            case "filter":
                try {
                String filter = request.getParameter("filter");
                String sortTime = request.getParameter("sort-time");
                String sortName = request.getParameter("sort-name");
                String search = request.getParameter("search");

                if (filter == null) {
                    filter = "all";
                }
                if (sortTime == null) {
                    sortTime = "desc";
                }
                if (sortName == null) {
                    sortName = "desc";
                }
                if (search == null) {
                    search = "";
                }
                UserDAO userDAO = new UserDAO();
                List<User> users = userDAO.getAllByStatusStaff(filter, sortTime, sortName, search);
                request.setAttribute("filter", filter);
                request.setAttribute("sortTime", sortTime);
                request.setAttribute("sortName", sortName);
                request.setAttribute("search", search);
                request.setAttribute("userList", users);
                request.getRequestDispatcher("../account_sale.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
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



