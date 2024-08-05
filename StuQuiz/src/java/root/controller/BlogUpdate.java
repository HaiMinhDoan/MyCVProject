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
import root.DAO.PostDAO;
import root.entities.main.Post;
import root.entities.main.User;

/**
 *
 * @author user
 */
@WebServlet(name = "BlogUpdate", urlPatterns = {"/BlogUpdate"})
public class BlogUpdate extends HttpServlet {

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
            out.println("<title>Servlet BlogUpdate</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogUpdate at " + request.getContextPath() + "</h1>");
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
        if (user != null && (user.getRoleLevel() == 1 || user.getRoleLevel() == 2)) {
            String postId = request.getParameter("bid");
            try {
                Post post = new PostDAO().getPostById(postId);
                request.setAttribute("post", post);
                request.getRequestDispatcher("/updateBlog.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
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
        User user = (User) request.getSession().getAttribute("userAuthorization");
        if (user != null && (user.getRoleLevel() == 1 || user.getRoleLevel() == 2)) {
            String postId = request.getParameter("id");
            long creator = Long.parseLong("123");
            String postContent = request.getParameter("postContent");
            String postImage = request.getParameter("postImage");
            String hashTag = request.getParameter("hashTag");
            Date createdDate = new Date();
            Post post = Post.builder()
                    .postId(Long.parseLong(postId))
                    .creator(creator)
                    .postContent(postContent)
                    .postImage(postImage)
                    .hashTag(hashTag)
                    .createdDate(createdDate)
                    .build();
            try {
                new PostDAO().updateById(postId, post);
                response.sendRedirect("BlogManage");
            } catch (Exception e) {
                throw new ServletException("Error updating post", e);
            }
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
