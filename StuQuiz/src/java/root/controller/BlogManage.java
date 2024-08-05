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
import java.util.List;
import root.DAO.PostDAO;
import root.entities.main.Post;
import root.entities.main.User;

/**
 *
 * @author user
 */
@WebServlet(name = "BlogManage", urlPatterns = {"/BlogManage"})
public class BlogManage extends HttpServlet {

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
        try {
            String content = request.getParameter("content") == null ? "" : request.getParameter("content");
            String hashTag = request.getParameter("content") == null ? "" : request.getParameter("content");
            String fromDate = request.getParameter("fromDate") == null ? "1990-05-16" : request.getParameter("fromDate");
            String toDate = request.getParameter("toDate") == null ? "2099-05-16" : request.getParameter("toDate");
            String pageStr = request.getParameter("index");

            int page = Integer.valueOf(pageStr == null ? "1" : pageStr);
            int pageSize = 6;

            List<Post> posts = new PostDAO().getPostList(content, hashTag, fromDate, toDate, page, pageSize);
            int totalRows = new PostDAO().countPosts(content, hashTag, fromDate, toDate);
            int totalPages = (int) Math.ceil((double) totalRows / pageSize);

            request.setAttribute("posts", posts);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("index", page);
            RequestDispatcher dispatcher = request.getRequestDispatcher("postListManage.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            response.getWriter().print(e.getMessage());

            e.printStackTrace();
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
        if (user != null && (user.getRoleLevel() == 1 || user.getRoleLevel() == 2)) {
            processRequest(request, response);
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
        User user = (User) request.getSession().getAttribute("userAuthorization");
        if (user != null && (user.getRoleLevel() == 1 || user.getRoleLevel() == 2)) {
            processRequest(request, response);
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
