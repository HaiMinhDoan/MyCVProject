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
import root.DAO.RequestTeacherDAO;
import root.DAO.UserDAO;
import root.constantservices.MailService;
import root.entities.main.RequestTeacher;
import root.entities.main.User;

/**
 *
 * @author HP
 */
public class RequestTeacherController extends HttpServlet {

    private RequestTeacherDAO requestTeacherDAO;

    public void init() {
        requestTeacherDAO = new RequestTeacherDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User userAuthorization = (User) request.getSession().getAttribute("userAuthorization");
        if (userAuthorization != null && userAuthorization.getRoleLevel() == 1) {
            try {
                List<RequestTeacher> listRequestTeacher = requestTeacherDAO.getAll();
                System.out.println(listRequestTeacher.size());
                request.setAttribute("listRequestTeacher", listRequestTeacher);
                request.getRequestDispatcher("requestTeacher.jsp").forward(request, response);
            } catch (Exception e) {
                System.out.println("Error: " + e);
            }
        } else {
            response.sendRedirect("ErrorPage");
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User userAuthorization = (User) request.getSession().getAttribute("userAuthorization");
        if (userAuthorization != null && userAuthorization.getRoleLevel() == 1) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                RequestTeacher requestTeacher = requestTeacherDAO.getById(id + "");
                if (requestTeacher != null) {
                    String action = request.getParameter("action");
                    int isAccept = "accept".equals(action) ? 1 : 2;
                    if (isAccept == 1) {
                        UserDAO userDao = new UserDAO();
                        User user = userDao.getById(requestTeacher.getMakerId() + "");
                        String emailSend = user != null && user.getUserEmail() != null ? user.getUserEmail() : "";
                        if (emailSend != null) {
                            int result = requestTeacherDAO.updateRequestStatus(id, isAccept);
                            if (result > 0) {
                                userDao.updateEoleUserAccount(user.getUserId() + "", 3);
                                MailService mail = new MailService();
                                String message = "Your request become a teacher is accept";
                                boolean isSend = mail.sentEmailNoStatic(emailSend, "Response for request teacher", message);
                                response.sendRedirect("request-teacher?success=Accept successfully");
                            }
                        } else {
                            response.sendRedirect("request-teacher?error=Can not found email of this user");
                        }
                    } else {
                        int result = requestTeacherDAO.deleteRequest(id);
                        response.sendRedirect("request-teacher?success=Reject successfully");
                    }
                } else {
                    response.sendRedirect("request-teacher?error=Can not found this request");
                }

            } catch (Exception e) {
                System.out.println("Request teacher: " + e);
            }
        } else {
            response.sendRedirect("ErrorPage");
        }

    }
}
