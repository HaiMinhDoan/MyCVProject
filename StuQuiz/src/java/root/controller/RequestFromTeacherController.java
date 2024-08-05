package root.controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import root.DAO.RequestTeacherDAO;
import root.entities.main.RequestTeacher;
import root.entities.main.User;

/**
 *
 * @author HP
 */
public class RequestFromTeacherController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private RequestTeacherDAO requestTeacherDAO;

    public void init() {
        requestTeacherDAO = new RequestTeacherDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("userAuthorization");
        if(user!=null&&user.getRoleLevel()==1){
             request.getRequestDispatcher("request.jsp").forward(request, response);
        } else {
            response.sendRedirect("Account");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int makerId = 9;
        String userBank = request.getParameter("bankName");
        String userBankCode = request.getParameter("bankAccountNumber");
        String reqestContent = request.getParameter("requestContent");
        String createdTime = java.time.LocalDateTime.now().toString();
        int isAccept = 0;

        RequestTeacher newRequest = RequestTeacher.builder()
                .makerId(makerId)
                .userBank(userBank)
                .userBankCode(userBankCode)
                .reqestContent(reqestContent)
                .createdTime(createdTime)
                .isAccept(isAccept)
                .build();

        try {
            int result = requestTeacherDAO.insertRequestTeacher(newRequest);
            if (result > 0) {
                response.sendRedirect("success.jsp");
                return;
            }
        } catch (Exception e) {
            System.out.println("Error" + e);
        }
        response.sendRedirect("failure.jsp");
    }

}



