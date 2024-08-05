/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package root.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import root.DAO.AnswerDAO;
import root.DAO.ExamDAO;
import root.DAO.ExamQuestionDAO;
import root.DAO.QuestionDAO;
import root.DAO.QuizDAO;
import root.entities.main.Answer;
import root.entities.main.Exam;
import root.entities.main.ExamQuestion;
import root.entities.main.Question;
import root.entities.main.Quiz;
import root.entities.sub.CustomQuestion;
import root.entities.sub.ExamResult;
import root.entities.sub.ExamResultDetail;
import root.entities.sub.ResultObject;

/**
 *
 * @author vtdle
 */
@WebServlet(name = "ViewResultDetail", urlPatterns = {"/ViewResultDetail"})
public class ViewResultDetail extends HttpServlet {

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
            out.println("<title>Servlet ViewResultDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewResultDetail at " + request.getContextPath() + "</h1>");
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
        String examId = request.getParameter("examId");
        String userId = request.getParameter("userId");
        String quizId = request.getParameter("quizId");

        if (examId != null) {
            ExamDAO examDAO = new ExamDAO();
            QuizDAO quizDAO = new QuizDAO();
            ExamQuestionDAO examQuestionDAO = new ExamQuestionDAO();
            QuestionDAO questionDAO = new QuestionDAO();
            AnswerDAO answerDAO = new AnswerDAO();
            Exam exam = Exam.builder()
                    .examId(0L)
                    .build();

            try {
                exam = examDAO.getById(examId);
                Quiz quiz = Quiz.builder()
                        .quizId(0L)
                        .build();

                if (exam.getExamId() != 0L) {
                    quiz = quizDAO.getById(exam.getQuizId() + "");
                    List<ResultObject> listResultObjects = new ArrayList<>();
                    List<ExamQuestion> listExamQuestions = examQuestionDAO.getListExamQuestionByExamId(examId);
                    ExamResult examResult = examDAO.getExamResultByExamIdAndStudentIdAndQuizId(examId, userId, quizId);

                    for (ExamQuestion examQuestion : listExamQuestions) {
                        Question question = questionDAO.getById(examQuestion.getQuestionId() + "");
                        List<Answer> listAnswers = answerDAO.getListAnswerByQuestionId(question.getQuestionId() + "");
                        CustomQuestion customQuestion = CustomQuestion.builder()
                                .listAnswers(listAnswers)
                                .question(question)
                                .build();
                        ResultObject resultObject = ResultObject.builder()
                                .customQuestion(customQuestion)
                                .selectAnswer(examQuestion.getSelectedAnswer())
                                .build();
                        listResultObjects.add(resultObject);
                    }

                    ExamResultDetail examResultDetail = ExamResultDetail.builder()
                            .quiz(quiz)
                            .exam(exam)
                            .listResultObjects(listResultObjects)
                            .build();
                    request.setAttribute("examResult", examResult);
                    request.setAttribute("examResultDetail", examResultDetail);
                    request.getRequestDispatcher("resultDetail.jsp").forward(request, response);
                } else {

                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
            }
        } else {
            response.sendRedirect("/ViewExamResult");
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
        processRequest(request, response);
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


