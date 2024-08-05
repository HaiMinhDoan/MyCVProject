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
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Base64;
import java.util.Date;
import root.DAO.PostDAO;
import root.constantservices.Constant;
import root.entities.main.Post;
import root.entities.main.User;

/**
 *
 * @author user
 */
@WebServlet(name = "BlogAdd", urlPatterns = {"/BlogAdd"})
public class BlogAdd extends HttpServlet {

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
            out.println("<title>Servlet BlogAdd</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogAdd at " + request.getContextPath() + "</h1>");
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
        if (userAuthorization != null) {
            if (userAuthorization.getRoleLevel() == 1 || userAuthorization.getRoleLevel() == 2) {
                request.getRequestDispatcher("addBlog.jsp").forward(request, response);
            } else {
                response.sendRedirect("ErrorPage");
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
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("userAuthorization");
        if (u!=null&&(u.getRoleLevel() == 1L || u.getRoleLevel() == 2L)) {
            long creator = u.getUserId();
            String postContent = request.getParameter("postContent");
            String postImage = request.getParameter("postImage");
            String hashTag = request.getParameter("hashTag");
            String imgText = request.getParameter("imgText");
            String imgPath = null;
            Date createdDate = new Date();
            Long id = 0L;
            String[] parts = imgText.split(",");

            Post post = Post.builder()
                    .creator(creator)
                    .postContent(postContent)
                    .postImage(postImage)
                    .hashTag(hashTag)
                    .createdDate(createdDate)
                    .build();

            try {
                if (u.getRoleLevel() == 1L || u.getRoleLevel() == 2L) {
                    id = new PostDAO().addNewPostAndGetId(post);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (postImage != null && imgText != null && postImage.equals("byBase64")) {
                String fileName = "post_" + id + ".jpg";
                File folder = new File(Constant.IMGS_FOLDER);
                File file = new File(folder, fileName);
                boolean checkCreated = file.exists();
                if (!checkCreated) {
                    checkCreated = file.createNewFile();
                }
                if (checkCreated) {
                    byte[] decodedBytes = Base64.getDecoder().decode(parts[1]);
                    Path destinationFile = file.toPath();
                    Files.write(destinationFile, decodedBytes);
                    imgPath = "anh/" + fileName;
                }
            }
            try {
                if (!id.equals(0L)) {
                    post = new PostDAO().getPostById(id + "");
                    post.setPostImage(imgPath);
                    boolean checkUp = new PostDAO().updateById(id + "", post);
                    System.out.println(checkUp);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("BlogManage");
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
