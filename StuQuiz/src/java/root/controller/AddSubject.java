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
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Base64;
import java.util.Date;
import root.DAO.CourseDAO;
import root.DAO.SubjectDAO;
import root.DAO.SubjectStatisticDAO;
import root.constantservices.Constant;
import root.entities.main.Subject;
import root.entities.main.SubjectStatistic;
import root.entities.main.User;

/**
 *
 * @author thiendb
 */
public class AddSubject extends HttpServlet {

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
            out.println("<title>Servlet AddSubject</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddSubject at " + request.getContextPath() + "</h1>");
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
            HttpSession session = request.getSession();
            if (session.getAttribute("userAuthorization") == null) {
                response.sendRedirect("login");
            } else {
                request.setAttribute("cl", new CourseDAO().getAll());
                request.getRequestDispatcher("AddSubject.jsp").forward(request, response);
            }
        } catch (Exception ex) {
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
        SubjectStatisticDAO subjectStatisticDAO = new SubjectStatisticDAO();
        User u = (User) session.getAttribute("userAuthorization");
        if (u!=null&&(u.getRoleLevel() == 1L || u.getRoleLevel() == 3L)) {
            String subjectName = request.getParameter("subject-name");
            String subjectCode = request.getParameter("subject-code");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            Long courseId = Long.valueOf(request.getParameter("course").trim());
            Double price = Double.valueOf(request.getParameter("price").trim());
            Double salePrice = Double.valueOf(request.getParameter("salePrice").trim());
            String imgText = request.getParameter("imgText");
            String imgBy = request.getParameter("imgBy");
            String imgPath = null;
            Long id = 0L;
            String[] parts = imgText.split(",");
            Subject subject = Subject.builder()
                    .courseId(courseId)
                    .createdDate(new Date())
                    .isActive(true)
                    .subjectName(subjectName)
                    .subjectPrice(price)
                    .subjectDescription(description)
                    .subjectCode(subjectCode)
                    .salePrice(salePrice)
                    .ownerId(u.getUserId())
                    .subjectImage(null)
                    .build();
            try {
                if (u.getRoleLevel() == 1L || u.getRoleLevel() == 3L) {
                    id = new SubjectDAO().addNewSubjectAndGetId(subject);
                    SubjectStatistic subjectStatistic = SubjectStatistic.builder()
                            .purchases(0L)
                            .subjectId(id)
                            .revenue(0)
                            .views(0L)
                            .build();
                    subjectStatisticDAO.addNew(subjectStatistic);
                }

            } catch (Exception e) {
            }
            if (imgBy != null && imgText != null && imgBy.equals("byBase64")) {
                String fileName = "subject_" + id + ".jpg";
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
            subject.setSubjectImage(imgPath);
            try {
                if (id != 0L) {
                    boolean checkUpDate = new SubjectDAO().updateById(id + "", subject);
                    if(checkUpDate){
                        
                    }
                }
            } catch (Exception e) {
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
