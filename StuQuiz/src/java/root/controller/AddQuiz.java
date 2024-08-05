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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import root.DAO.LessonDAO;
import root.DAO.QuestionDAO;
import root.DAO.QuizBankDAO;
import root.DAO.QuizDAO;
import root.entities.main.Lesson;
import root.entities.main.Question;
import root.entities.main.Quiz;
import root.entities.main.QuizBank;

/**
 *
 * @author admin
 */
public class AddQuiz extends HttpServlet {

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
            out.println("<title>Servlet AddQuiz</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddQuiz at " + request.getContextPath() + "</h1>");
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
            QuestionDAO questiondao = new QuestionDAO();
            LessonDAO lessondao = new LessonDAO();

            String lessonId = request.getParameter("lessonId");
            Lesson lesson = lessondao.getById(lessonId);
            List<Question> questionList = new ArrayList<>();
            questionList = questiondao.getListQuestionBySubjectId(lesson.getSubjectId() + "");
            request.setAttribute("questionList", questionList);
            request.setAttribute("lessonId", lessonId);

            request.getRequestDispatcher("AddQuiz.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AddQuiz.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddQuiz.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            QuizDAO quizDAO = new QuizDAO();
            QuizBankDAO quizBankDAO = new QuizBankDAO();
            LessonDAO lessondao = new LessonDAO();

            String arrayBankString = request.getParameter("arrayBank");
            String arrayBank[] = arrayBankString.split(",");
            int arrLength = arrayBank.length;

            String lessonId = request.getParameter("lessonId");
            String quizName = request.getParameter("quizName");
            String quizLevel = request.getParameter("quizLevel");
            String quizDuration = request.getParameter("quizDuration");
            String passRate = request.getParameter("passRate");
            String quizType = request.getParameter("quizType");
            String quizDescription = request.getParameter("quizDescription");
            String eQuestion = request.getParameter("eQuestion");
            String mQuestion = request.getParameter("mQuestion");
            String hQuestion = request.getParameter("hQuestion");
            
            Quiz quiz = Quiz.builder()
                    .lessonId(Long.parseLong(lessonId))
                    .quizName(quizName)
                    .quizLevel(Long.parseLong(quizLevel))
                    .quizDuration(Long.parseLong(quizDuration))
                    .passRate(Double.parseDouble(passRate))
                    .quizType(Long.parseLong(quizType))
                    .quizDescription(quizDescription)
                    .eQuestion(Long.parseLong(eQuestion))
                    .mQuestion(Long.parseLong(mQuestion))
                    .hQuestion(Long.parseLong(hQuestion))
                    .isActive(true)
                    .build();

            Lesson lesson = lessondao.getById(lessonId);

            try {
                Long quizId = quizDAO.addNewQuizAndGetId(quiz);

                for (int i = 0; i < arrLength; i++) {
                    Long questionId = quizBankDAO.parseLong(arrayBank[i]);
                    QuizBank quizBank = QuizBank.builder()
                            .quizId(quizId)
                            .questionId(questionId)
                            .build();
                    quizBankDAO.addNew(quizBank);
                }

                response.sendRedirect("EditLesson?subjectId=" + lesson.getSubjectId());
            } catch (Exception e) {
                response.sendRedirect("ErrorPage");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddQuiz.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddQuiz.class.getName()).log(Level.SEVERE, null, ex);
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

}



