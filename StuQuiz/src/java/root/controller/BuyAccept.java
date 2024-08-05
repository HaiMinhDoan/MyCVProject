/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package root.controller;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import root.DAO.ItemDAO;
import root.DAO.SubjectStatisticDAO;
import root.entities.main.Item;
import root.entities.main.SubjectStatistic;
import root.entities.sub.ResponseEntity;
import root.roleAndLevel.Kind;
import root.roleAndLevel.Status;

/**
 *
 * @author admin
 */
public class BuyAccept extends HttpServlet {

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
        response.setContentType("application/json");
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
        String transactionCode = request.getParameter("transactionCode");
        String amountString = request.getParameter("amount");
        String json = "";
        if (transactionCode != null) {
            ItemDAO itemDAO = new ItemDAO();
            try {
                Item item = itemDAO.getItemByTransactionCode(transactionCode);
                if (!item.getItemId().equals(0L)) {
                    Long amount = itemDAO.parseLong(amountString);
                    if (amount > 0) {
                        Date startDate = new Date();
                        item.setStartDate(startDate);
                        Date endDate = new Date(startDate.getTime() + 90 * amount * 24 * 60 * 60 * 1000);
                        item.setEndDate(endDate);
                        boolean checkBuySuccess = itemDAO.updateById(item.getItemId() + "", item);
                        ResponseEntity responseEntity = new ResponseEntity();
                        Gson gson = new Gson();
                        if (checkBuySuccess) {
                            responseEntity = ResponseEntity.builder()
                                    .kind(Kind.TRANSACTION)
                                    .status(Status.SUCCESS)
                                    .data("OK")
                                    .build();
                            SubjectStatisticDAO subjectStatisticDAO = new SubjectStatisticDAO();
                            SubjectStatistic subjectStatistic = subjectStatisticDAO.getStatisticBySubjectId(item.getSubjectId() + "");
                            Long purchase = subjectStatistic.getPurchases()+1;
                            Double revenue = subjectStatistic.getRevenue()+item.getItemPrice();
                            subjectStatistic.setPurchases(purchase);
                            subjectStatistic.setRevenue(revenue);
                            subjectStatisticDAO.updateById(subjectStatistic.getSubjectStatisticId() + "", subjectStatistic);
                            json = gson.toJson(responseEntity);
                        } else {
                            responseEntity = ResponseEntity.builder()
                                    .kind(Kind.TRANSACTION)
                                    .status(Status.FAIL)
                                    .data("NOT_OK")
                                    .build();
                            json = gson.toJson(responseEntity);
                        }
                    }
                }
            } catch (Exception e) {
            }
            response.getWriter().write(json);
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
        response.setContentType("application/json");
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
