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
import root.DAO.UserDAO;
import root.constantservices.MailService;
import root.constantservices.RandomService;
import root.entities.main.User;

/**
 *
 * @author admin
 */
public class Account extends HttpServlet {

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
            out.println("<title>Servlet Account</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Account at " + request.getContextPath() + "</h1>");
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
        if (user != null) {
            response.sendRedirect("HomePage");
        } else if (user != null && user.getRoleLevel()
                == 1) {
            response.sendRedirect("DashBoard");
        } else if (user != null && user.getRoleLevel() == 3) {
            response.sendRedirect("TeacherDashBoard");
        } else {
            request.setAttribute("isLogin", true);
            request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
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
        String actionCheck = request.getParameter("actionCheck");
        if (actionCheck != null) {
            if (actionCheck.equals("login")) {
                request.setAttribute("isLogin", true);
                String logemail = request.getParameter("logemail");
                String logpass = request.getParameter("logpass");
                request.setAttribute("logemail", logemail);
                request.setAttribute("logpass", logpass);
                User user = new User();
                UserDAO userDAO = new UserDAO();
                try {
                    user = userDAO.getByEmail(logemail);
                    if (!user.isActive()) {
                        user.setUserId(0L);
                    }
                } catch (Exception e) {
                    user.setUserId(0L);
                }
                if (user.getUserId() != 0L) {
                    if (user.getUserPassword().equals(logpass)) {
                        user.setActiveCode(RandomService.getRandomActiveCode(10L));
                        request.getSession().setAttribute("userAuthorization", user);
                        if (user.getRoleLevel() == 4) {
                            response.sendRedirect("HomePage");
                        } else if (user.getRoleLevel() == 1) {
                            response.sendRedirect("DashBoard");
                        } else if(user.getRoleLevel() == 2){
                            response.sendRedirect("HomePage");
                        } else if(user.getRoleLevel() == 3){
                            response.sendRedirect("TeacherDashBoard");
                        }
                        
                    } else {
                        request.setAttribute("errorMess", "Wrong password!");
                        request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("errorMess", "Email is not registered!");
                    request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
                }
            } else if (actionCheck.equals("register")) {
                request.setAttribute("isLogin", false);
                String logname = request.getParameter("logname");
                String logemail = request.getParameter("logemail");
                String logpass = request.getParameter("logpass");
                request.setAttribute("logname", logname);
                request.setAttribute("logemail", logemail);
                request.setAttribute("logpass", logpass);
                boolean isValidUserName = isValidFullName(logname);
                boolean isValidPassword = isValidPassword(logpass);
                User user = new User();
                UserDAO userDAO = new UserDAO();
                try {
                    user = userDAO.getByEmail(logemail);
                } catch (Exception e) {
                    user.setUserId(0L);
                }
                if (user.getUserId() == 0L) {
                    if (isValidUserName && isValidPassword) {
                        String activeCode = RandomService.getRandomActiveCode(10L);
                        String verifyLink = "http://localhost:9999/StuQuiz/Verify?email=" + logemail;
                        String tagLink = "<a href='" + verifyLink + "'>Click here</a><br>" + "<h2>Verify Code: " + activeCode + "</h2>";
                        boolean sendMailSuccess = MailService.sentEmail(logemail, "Click to below link to verify your account", tagLink);
                        if (sendMailSuccess) {
                            user = User.builder()
                                    .userName(logname)
                                    .userEmail(logemail)
                                    .userPassword(logpass)
                                    .roleLevel(4L)
                                    .createdTime(new Date())
                                    .activeCode(activeCode)
                                    .isActive(false)
                                    .build();
                            try {
                                userDAO.addNew(user);
                                request.setAttribute("errorMess", "Please check your email to get verifying");
                                request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
                            } catch (Exception e) {
                                response.sendRedirect("ErrorPage");
                            }
                        } else {
                            request.setAttribute("errorMess", "email is not valid");
                            request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
                        }
                    } else {
                        String errorMess = (isValidUserName ? "" : "<span>Account name must be no less than 5 characters and no more than 50 characters</span><br>")
                                + (isValidPassword ? "" : "<span>Password must not be less than 8 characters or more than 16 characters</span>");
                        request.setAttribute("errorMess", errorMess);
                        request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
                    }
                } else {
                    if (user.isActive()) {
                        request.setAttribute("errorMess", "email is used");
                        request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
                    } else {
                        if (isValidUserName && isValidPassword) {
                            String activeCode = RandomService.getRandomActiveCode(10L);
                            String verifyLink = "http://localhost:9999/StuQuiz/Verify?email=" + logemail;
                            String tagLink = "<a href='" + verifyLink + "'>Click here</a><br>" + "<h2>Verify Code: " + activeCode + "</h2>";
                            boolean sendMailSuccess = MailService.sentEmail(logemail, "Click to below link to verify again your account", tagLink);
                            Long currentId = user.getUserId();
                            if (sendMailSuccess) {
                                user = User.builder()
                                        .userName(logname)
                                        .userEmail(logemail)
                                        .userPassword(logpass)
                                        .roleLevel(4L)
                                        .createdTime(new Date())
                                        .activeCode(activeCode)
                                        .isActive(false)
                                        .build();
                                try {
                                    userDAO.updateById(currentId + "", user);
                                    request.setAttribute("errorMess", "Please check your email to get verifying");
                                    request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
                                } catch (Exception e) {
                                    response.sendRedirect("ErrorPage");
                                }
                            }
                        } else {
                            String errorMess = (isValidUserName ? "" : "<span>Account name must be no less than 5 characters and no more than 50 characters</span><br>")
                                    + (isValidPassword ? "" : "<span>Password must not be less than 8 characters or more than 16 characters</span>");
                            request.setAttribute("errorMess", errorMess);
                            request.getRequestDispatcher("registerAndLogin.jsp").forward(request, response);
                        }
                    }
                }
            } else {
                doGet(request, response);
            }
        } else {
            doGet(request, response);
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

    public boolean isValidFullName(String username) {
        return !(username.length() > 50 || username.length() < 5);
    }
    
    public boolean isValidPassword(String password) {
        if (password.length() > 16 || password.length() < 8) {
            return false;
        }
        
        if (password.contains(" ")) {
            return false;
        }
        
        for (char c : password.toCharArray()) {
            if (c > 127) {
                return false;
            }
        }
        
        return true;
    }
}
