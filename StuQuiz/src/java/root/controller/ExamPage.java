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
import java.util.Date;
import java.util.List;
import root.DAO.AnswerDAO;
import root.DAO.ExamDAO;
import root.DAO.ExamQuestionDAO;
import root.DAO.ItemDAO;
import root.DAO.LessonDAO;
import root.DAO.QuestionDAO;
import root.DAO.QuizDAO;
import root.DAO.UserDAO;
import root.constantservices.RandomService;
import root.constantservices.StringService;
import root.entities.main.Answer;
import root.entities.main.Exam;
import root.entities.main.ExamQuestion;
import root.entities.main.Item;
import root.entities.main.Question;
import root.entities.main.Quiz;
import root.entities.main.User;
import root.entities.sub.CusQuestion;
import root.entities.sub.CustomizeExam;

/**
 *
 * @author admin
 */
public class ExamPage extends HttpServlet {

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
            out.println("<title>Servlet ExamPage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExamPage at " + request.getContextPath() + "</h1>");
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
        String quizId = request.getParameter("quizId");
        if (user == null || quizId == null) {
            response.sendRedirect("/StuQuiz/ErrorPage");
        } else {
            ExamDAO examDAO = new ExamDAO();
            QuizDAO quizDAO = new QuizDAO();
            QuestionDAO questionDAO = new QuestionDAO();
            AnswerDAO answerDAO = new AnswerDAO();
            Quiz quiz = new Quiz();
            List<Question> listQuestions = new ArrayList<>();
            List<CusQuestion> listCusQuestions = new ArrayList<>();
            try {
                quiz = quizDAO.getById(quizId);
                List<Exam> existedExam = examDAO.getListExamByQuizId(quizId);
                if (isAllowedToDoQuiz(quizId, user.getUserId()+"")) {
                    listQuestions = questionDAO.getListQuestionByQuizId(quizId);
                    List<Question> randomListQuesion
                            = RandomService.getRandomExamByListQuestion(quiz.getEQuestion(), quiz.getMQuestion(), quiz.getHQuestion(), listQuestions);
                    for (Question question : randomListQuesion) {
                        List<Answer> listAnswers = new ArrayList<>();
                        listAnswers = answerDAO.getListAnswerByQuestionId(question.getQuestionId() + "");
                        CusQuestion cusQuestion = CusQuestion.builder()
                                .question(question)
                                .listAnswers(listAnswers)
                                .build();
                        listCusQuestions.add(cusQuestion);
                    }
                    CustomizeExam customizeExam = CustomizeExam.builder()
                            .quiz(quiz)
                            .listCusQuestions(listCusQuestions)
                            .build();
                    request.setAttribute("customizeExam", customizeExam);
                    request.getRequestDispatcher("ExamPage.jsp").forward(request, response);
                } else {
                    response.sendRedirect("/StuQuiz/ErrorPage");
                }
            } catch (Exception e) {
            }

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
        User user = (User) request.getSession().getAttribute("userAuthorization");
        if (user != null) {
            String quizId = request.getParameter("quizId");
            String passRate = request.getParameter("passRate");
            String stringNumberOfQuestions = request.getParameter("numberOfQuestions");
            QuizDAO quizDAO = new QuizDAO();
            ExamDAO examDAO = new ExamDAO();
            QuestionDAO questionDAO = new QuestionDAO();
            AnswerDAO answerDAO = new AnswerDAO();
            ExamQuestionDAO examQuestionDAO = new ExamQuestionDAO();
            List<ExamQuestion> listExamQuestions = new ArrayList<>();
            Long numberOfQuestions = quizDAO.parseLong(stringNumberOfQuestions);
            int mark = 0;
            boolean isGoodRequest = true;
            String test = request.getParameter("question_" + 1);
            for (Long i = 1L; i <= numberOfQuestions; i++) {
                String questionMapAnswer = request.getParameter("question_" + i);
                String arr[] = StringService.convertStringToId(questionMapAnswer);
                Question question = new Question();
                Answer answer = new Answer();
                try {
                    question = questionDAO.getById(arr[0]);
                    answer = answerDAO.getById(arr[1]);
                    if (answer.isTrue()) {
                        mark++;
                    }
                    listExamQuestions.add(ExamQuestion.builder()
                            .questionId(question.getQuestionId())
                            .selectedAnswer(answer.getAnswerId() != 0 ? answer.getAnswerId() : null)
                            .build());
                } catch (Exception e) {
                    isGoodRequest = false;
                }
            }
            Double examRate = (double) mark / numberOfQuestions;
            Exam exam = Exam.builder()
                    .quizId(quizDAO.parseLong(quizId))
                    .studentId(user.getUserId())
                    .examRate(examRate)
                    .isPass(examRate >= quizDAO.parseDouble(passRate))
                    .build();
            Long examId = 0L;
            try {
                examId = examDAO.addNewAndGetId(exam);
            } catch (Exception e) {
                isGoodRequest = false;
            }
            for (ExamQuestion examQuestion : listExamQuestions) {
                examQuestion.setExamId(examId);
                try {
                    examQuestionDAO.addNew(examQuestion);
                } catch (Exception e) {
                }
            }
            if (isGoodRequest) {
                response.sendRedirect("/StuQuiz/ViewResultDetail?examId="+examId+"&userId="+user.getUserId()+"&quizId="+quizId);
            } else {
                response.sendRedirect("/StuQuiz/ErrorPage");
            }
        }

    }

    public boolean isAllowedToDoQuiz(String quizId, String userId) {
        QuizDAO quizDAO = new QuizDAO();
        ExamDAO examDAO = new ExamDAO();
        UserDAO userDAO = new UserDAO();
        ItemDAO itemDAO = new ItemDAO();
        LessonDAO lessonDAO = new LessonDAO();
        Quiz quiz = new Quiz();
        try {
            quiz = quizDAO.getById(quizId);
            if (quiz.getQuizId() == 0L) {
                return false;
            }
            List<Item> listItems = itemDAO.getListItemsBySubjectIdAndUserId(lessonDAO.getById(quiz.getLessonId() + "").getSubjectId() + "", userId);
            if (listItems.isEmpty()) {
                return false;
            } else {
                boolean check = false;
                Date currentDate = new Date();
                for (Item item : listItems) {
                    if (item.getStartDate().before(currentDate) && item.getEndDate().after(currentDate)) {
                        check = true;
                    }
                }
                if (check) {
                    List<Exam> listExams = examDAO.getListExamByQuizIdAndUserId(quizId, userId);
                    if (listExams.isEmpty()) {
                        return true;
                    } else {
                        if (quiz.getQuizType() == 1) {
                            return true;
                        } else if (quiz.getQuizType() == 2) {
                            if (listExams.size() >= 3) {
                                return false;
                            } else {
                                return true;
                            }
                        } else if (quiz.getQuizType() == 3) {
                            if (listExams.size() >= 1) {
                                return false;
                            } else {
                                return true;
                            }
                        } else {
                            return false;
                        }
                    }
                }
            }
        } catch (Exception e) {
        }
        return false;
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
