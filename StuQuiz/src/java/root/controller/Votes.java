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
import java.util.logging.Level;
import java.util.logging.Logger;
import root.DAO.VoteDAO;
import root.entities.main.User;
import root.entities.main.Vote;

/**
 *
 * @author admin
 */
public class Votes extends HttpServlet {

    VoteDAO votedao = new VoteDAO();

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
            out.println("<title>Servlet Vote</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Vote at " + request.getContextPath() + "</h1>");
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
        response.setContentType("application/json");
        String makerId = request.getParameter("makerId");
        String rating = request.getParameter("rating");
        String lessonId = request.getParameter("lessonId");
        boolean checkSuccess = false;
        if (makerId != null && rating != null && lessonId != null) {
            try {
                Vote tempVote = votedao.getVoteLessonByUserId(makerId, lessonId);
                if (tempVote == null) {
                    checkSuccess = votedao.addNew(Vote.builder()
                            .makerId(votedao.parseLong(makerId))
                            .lessonId(votedao.parseLong(lessonId))
                            .star(votedao.parseLong(rating))
                            .build());
                } else {
                    tempVote.setStar(votedao.parseLong(rating));
                    checkSuccess = votedao.updateById(tempVote.getVoteId() + "", tempVote);
                }

            } catch (Exception e) {
            }
        }
        String jsonObject = checkSuccess ? ("{isSuccess:'true',star:" + rating + "}") : "{'status':'fail'}";
        jsonObject.replace("'", """
                                " """);
        response.getWriter().write(jsonObject);
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
