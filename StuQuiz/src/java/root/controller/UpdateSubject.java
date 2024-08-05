/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package root.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import root.DAO.CourseDAO;
import root.DAO.SubjectDAO;
import root.constantservices.Constant;
import root.entities.main.Subject;
import root.entities.main.User;

/**
 *
 * @author user
 */
public class UpdateSubject extends HttpServlet {

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
            out.println("<title>Servlet UpdateSubject</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateSubject at " + request.getContextPath() + "</h1>");
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
        try {

            request.setAttribute("cl", new CourseDAO().getAll());
            request.setAttribute("s", new SubjectDAO().getById(request.getParameter("sid")));
            User user = (User) request.getSession().getAttribute("userAuthorization");
            if (user != null && (user.getRoleLevel() == 3L || user.getRoleLevel() == 1L)) {
                request.getRequestDispatcher("SubjectUpdate.jsp").forward(request, response);
            } else {
                response.sendRedirect("ErrorPage");
            }
        } catch (Exception ex) {
            Logger.getLogger(UpdateSubject.class.getName()).log(Level.SEVERE, null, ex);
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
        String subjectName = request.getParameter("subject-name");
        String subjectCode = request.getParameter("subject-code");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String sid = request.getParameter("sid").trim();
        Subject subject = Subject.builder()
                .subjectId(0L)
                .build();
        try {
            subject = new SubjectDAO().getById(sid);
        } catch (Exception e) {
            subject = Subject.builder()
                    .subjectId(0L)
                    .build();
        }
        if (subject.getSubjectId() != 0L) {
            if (u.getRoleLevel() == 1L || (u.getRoleLevel().equals(3L) && subject.getOwnerId().equals(u.getUserId()))) {
                Long courseId = Long.valueOf(request.getParameter("course").trim());
                Double price = Double.valueOf(request.getParameter("price").trim());
                Double salePrice = Double.valueOf(request.getParameter("salePrice").trim());
                String imgText = request.getParameter("imgText") != null ? request.getParameter("imgText") : "";
                String[] parts = imgText.split(",");
                String imgBy = request.getParameter("imgBy") != null ? request.getParameter("imgBy") : "";
                System.out.println(imgBy);
                String imgPath = null;
                if (imgBy != null && imgText != null && imgBy.equals("byBase64")) {
                    System.out.println("Di qua day");
                    try {
                        String fileName = "subject_" + sid + ".jpg";
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
                    } catch (Exception e) {
                    }
                } else if (imgBy != null && imgText != null && imgBy.equals("byLink")) {
                    imgPath = imgText;
                } else {
                    imgPath = request.getParameter("srcRoot");
                }
                try {
                    subject = new SubjectDAO().getById(sid);
                    subject.setCourseId(courseId);
                    subject.setSubjectCode(subjectCode);
                    subject.setSubjectName(subjectName);
                    subject.setSubjectDescription(description);
                    subject.setSubjectImage(imgPath);
                    subject.setSubjectPrice(price);
                    subject.setSalePrice(salePrice);
                    subject.setActive(status.equals("1"));
                    if (subject.getSubjectId() != 0L) {
                        if (u.getRoleLevel() == 1L || (u.getRoleLevel().equals(3L) && subject.getOwnerId().equals(u.getUserId()))) {
                            new SubjectDAO().updateById(sid, subject);
                        }
                    }
                } catch (Exception e) {
                }
            }
        }

        response.sendRedirect("SubjectList");
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
