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
import java.util.Date;
import java.util.List;
import root.DAO.ItemDAO;
import root.DAO.SubjectDAO;
import root.entities.main.Item;
import root.entities.main.Subject;
import root.entities.main.User;

/**
 *
 * @author admin
 */
public class BuySubjectPage extends HttpServlet {

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
            out.println("<title>Servlet BuySubjectPage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuySubjectPage at " + request.getContextPath() + "</h1>");
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
        String subjectId = request.getParameter("subjectId");
        String amountString = request.getParameter("amount");
        User user = (User) request.getSession().getAttribute("userAuthorization");
        SubjectDAO subjectDAO = new SubjectDAO();
        ItemDAO itemDAO = new ItemDAO();
        if (amountString == null) {
            amountString = "1";
        }
        Long amount = itemDAO.parseLong(amountString);
        if (user != null && user.getUserId() != 0) {
            if (subjectId == null) {
                subjectId = "0";
            }
            try {
                Subject subject = subjectDAO.getById(subjectId);
                Date curentDate = new Date();
                if (subject.getSubjectId() != 0L) {
                    List<Item> listiItems = itemDAO.getListItemsBySubjectIdAndUserId(subjectId, user.getUserId() + "");
                    if (!listiItems.isEmpty()) {
                        Item item = listiItems.get(0);
                        if ((!item.getStartDate().after(curentDate)) && (!item.getEndDate().before(curentDate))) {
                            System.out.println("di qua day");
                            response.sendRedirect("Lessons?actionCheck=viewLessonList&subjectId="+subjectId);
                        } else {
                            if (amount != 0L) {
                                item.setItemPrice(amount * subject.getSubjectPrice() * (100 - subject.getSalePrice()) / 100);
                                item.setTransactionCode("TranM" + item.getItemId() + "M" + curentDate.getTime());
                                itemDAO.updateById(item.getItemId() + "", item);
                                request.setAttribute("subject", subject);
                                request.setAttribute("item", item);
                                request.setAttribute("amount", amount);
                                request.getRequestDispatcher("BuySubjectPage.jsp").forward(request, response);
                            } else {
                                response.sendRedirect("ErrorPage");
                            }
                        }
                    } else {
                        Date startDate = new Date();
                        Date endDate = new Date();
                        startDate.setYear(curentDate.getYear() + 90);
                        endDate.setYear(curentDate.getYear() - 1);
                        Item newItem = Item.builder()
                                .buyerId(user.getUserId())
                                .subjectId(subject.getSubjectId())
                                .itemPrice(amount * subject.getSubjectPrice() * subject.getSalePrice() / 100)
                                .startDate(startDate)
                                .endDate(endDate)
                                .build();
                        Long id = itemDAO.addNewItemAndGetId(newItem);
                        newItem.setTransactionCode("TranM" + id + "M" + curentDate.getTime());
                        itemDAO.updateById(id + "", newItem);
                        request.setAttribute("item", newItem);
                        request.setAttribute("subject", subject);
                        request.setAttribute("amount", amount);
                        request.getRequestDispatcher("BuySubjectPage.jsp").forward(request, response);
                    }
                } else {
                    response.sendRedirect("ErrorPage");
                }
            } catch (Exception e) {
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
