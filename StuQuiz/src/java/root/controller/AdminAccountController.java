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
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import root.DAO.UserDAO;
import root.entities.main.User;

/**
 *
 * @author
 */
public class AdminAccountController extends HttpServlet {

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
            out.println("<title>Servlet AdminAccountController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAccountController at " + request.getContextPath() + "</h1>");
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
        if (userAuthorization != null && userAuthorization.getRoleLevel() == 1) {
            String action = request.getParameter("action");
            action = action != null ? action : "";
            UserDAO userDAO = new UserDAO();
            switch (action) {
                case "view":
                try {
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    User user = userDAO.getById(userId + "");
                    if (user != null) {
                        request.setAttribute("user", user);
                        request.getRequestDispatcher("../detail-account.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("../admin/account?message=Can not found this user");
                    }
                } catch (Exception e) {
                    System.out.println("Error: " + e);
                    response.sendRedirect("../admin/account");
                }
                break;
                case "edit":
                try {
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    User user = userDAO.getById(userId + "");
                    if (user != null) {
                        request.setAttribute("user", user);
                        request.getRequestDispatcher("../editUser.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("admin/account?message=Can not found this user");
                    }
                } catch (Exception e) {
                    System.out.println("Error: " + e);
                    response.sendRedirect("../admin/account");
                }
                break;
                case "delete":
                try {
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    User user = userDAO.getById(userId + "");
                    if (user != null) {
                        int result = userDAO.deleteAccount(userId);
                        if (result > 0) {
                            response.sendRedirect("../admin/account?message=Delete successfully");
                        } else {
                            response.sendRedirect("../admin/account?error=Delete successfully");
                        }
                    } else {
                        response.sendRedirect("../admin/account?message=Can not found this user");
                    }
                } catch (Exception e) {
                    System.out.println("Error: " + e);
                    response.sendRedirect("../admin/account");
                }
                break;
                case "restore":
                try {
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    User user = userDAO.getById(userId + "");
                    if (user != null) {
                        int result = userDAO.restoreAccount(userId);
                        if (result > 0) {
                            response.sendRedirect("../admin/account?message=Delete successfully");
                        } else {
                            response.sendRedirect("../admin/account?error=Delete successfully");
                        }
                    } else {
                        response.sendRedirect("../admin/account?message=Can not found this user");
                    }
                } catch (Exception e) {
                    System.out.println("Error: " + e);
                    response.sendRedirect("../admin/account");
                }
                break;
                default:
                    List<User> users = new ArrayList<>();
                    try {
                        users = userDAO.getAll();
                    } catch (Exception e) {
                    }
                    request.setAttribute("userList", users);
                    request.getRequestDispatcher("../account.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("../Account");
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
        String action = request.getParameter("action");
        action = action != null ? action : "";
        switch (action) {
            case "filter":
                try {
                String filter = request.getParameter("filter");
                String sortTime = request.getParameter("sort-time");
                String sortName = request.getParameter("sort-name");
                String search = request.getParameter("search");

                if (filter == null) {
                    filter = "all";
                }
                if (sortTime == null) {
                    sortTime = "desc";
                }
                if (sortName == null) {
                    sortName = "desc";
                }
                if (search == null) {
                    search = "";
                }
                UserDAO userDAO = new UserDAO();
                List<User> users = userDAO.getAllByStatus(filter, sortTime, sortName, search);
                request.setAttribute("filter", filter);
                request.setAttribute("sortTime", sortTime);
                request.setAttribute("sortName", sortName);
                request.setAttribute("search", search);
                request.setAttribute("userList", users);
                request.getRequestDispatcher("../account.jsp").forward(request, response);
            } catch (Exception e) {
                System.out.println("e: " + e);
            }
            case "update":
                this.handleUpdate(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) {
        try {
            String userId = request.getParameter("userId").trim();
            String userName = request.getParameter("userName").trim();
            String userEmail = request.getParameter("userEmail").trim();
            String roleLevel = request.getParameter("roleLevel").trim();
            String userAvatar = request.getParameter("userAvatar").trim();
            String userBank = request.getParameter("userBank").trim();
            String userBankCode = request.getParameter("userBankCode").trim();
            String activeCode = request.getParameter("activeCode").trim();
            String isActive = request.getParameter("isActive").trim();
            StringBuilder errors = new StringBuilder();
            UserDAO userDao = new UserDAO();
            User user = userDao.getById(userId);

            if (user == null) {
                response.sendRedirect("../admin/account?message=Can not found this user");
                return;
            }
            User existEmail = userDao.getByEmail(userEmail);
            if (existEmail != null && !(existEmail.getUserId() + "").equals(userId + "")) {
                errors.append("Email is exist in system. </br>");
            }
            if (userId == null || userId.isEmpty() || !this.isNumeric(userId)) {
                errors.append("User id must be a integer number. </br>");
            }
            if (userName == null || userName.isEmpty()) {
                errors.append("Name can not empty. </br>");
            }
            if (userEmail == null || userEmail.isEmpty() || !this.isValidEmail(userEmail)) {
                errors.append("Email is not valid!. </br>");
            }
            if (roleLevel == null || roleLevel.isEmpty() || !this.isNumeric(roleLevel)) {
                errors.append("Role must be a integer number. </br>");
            }
            if (userAvatar == null || userAvatar.isEmpty()) {
                errors.append("Avatar can not empty. </br>");
            }
            if (userBank == null || userBank.isEmpty()) {
                errors.append("Bank can not empty. </br>");
            }
            if (userBankCode == null || userBankCode.isEmpty() || !this.isNumeric(userBankCode)) {
                errors.append("Bank code must be numberic. </br>");
            }
            if (activeCode == null || activeCode.isEmpty() || !this.isNumeric(activeCode)) {
                errors.append("Active code must be numberic. </br>");
            }
            if (isActive == null || isActive.isEmpty() || !this.isValidBoolean(isActive)) {
                errors.append("Active is not valid. </br>");
            }

            if (errors.length() > 0) {
                request.setAttribute("user", user);
                request.setAttribute("error", errors.toString());
                request.getRequestDispatcher("../editUser.jsp").forward(request, response);
                return;
            }

            User userNew = new User();
            try {
                userNew.setUserId(Long.parseLong(userId));
                userNew.setUserName(userName);
                userNew.setUserEmail(userEmail);
                userNew.setRoleLevel(Long.parseLong(roleLevel));
                userNew.setActiveCode(activeCode);
                userNew.setUserAvatar(userAvatar);
                userNew.setUserBank(userBank);
                userNew.setUserBankCode(userBankCode);
                userNew.setActive(Boolean.parseBoolean(isActive));
                int result = userDao.updateUserAccount(userId, userNew);
                if (result > 0) {
                    response.sendRedirect("../admin/account?message=Update account successfully");
                } else {
                    response.sendRedirect("../admin/account?message=Update account fail");
                }
            } catch (Exception e) {
                System.out.println("Update: " + e);
            }

        } catch (Exception e) {
            System.out.println("Update: " + e);
        }
    }

    public static boolean isValidEmail(String email) {
        String regex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return Pattern.compile(regex).matcher(email).matches();
    }

    public static boolean isNumeric(String str) {
        return str.matches("\\d+");
    }

    public static boolean isValidBoolean(String str) {
        return str.equalsIgnoreCase("true") || str.equalsIgnoreCase("false");
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
