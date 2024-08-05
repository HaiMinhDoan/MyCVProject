/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package root.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import root.DAO.AnswerDAO;
import root.DAO.QuestionDAO;
import root.DAO.SubjectDAO;
import root.entities.main.Answer;
import root.entities.main.Question;
import root.entities.main.Subject;
import root.entities.main.User;

/**
 *
 * @author Datnt
 */
public class QuestionManage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User userAuthorization = (User) request.getSession().getAttribute("userAuthorization");
        if (userAuthorization != null && userAuthorization.getRoleLevel() == 3) {
            try {
                String action = request.getParameter("action") == null ? "" : request.getParameter("action");
                String url = "listQuestion.jsp";
                SubjectDAO subjectDao = new SubjectDAO();
                switch (action) {
                    case "add":
                        SubjectDAO subjectDAO = new SubjectDAO();
                        List<Subject> listSubject = subjectDAO.getAll();
                        request.setAttribute("SUBJECT", listSubject);
                        url = "addquestion.jsp";
                        break;
                    case "delete":
                        QuestionDAO questionDaoDelete = new QuestionDAO();
                        Long questionId = this.getLong(request.getParameter("questionId"));
                        Long subjectIdBack = this.getLong(request.getParameter("subjectId"));
                        boolean success = questionDaoDelete.deleteQuestion(questionId);
                        questionId++;
                        if (success) {
                            response.sendRedirect("question?action=show-question&subjectId=" + subjectIdBack + "&questionId=" + questionId + "&message=Delete successfully");
                        } else {
                            response.sendRedirect("question?action=show-question&subjectId=" + subjectIdBack + "&questionId=" + questionId + "&message=Delete fail");
                        }
                        break;
                    case "show-question":
                        int subjectId = 0;
                        try {
                            subjectId = Integer.parseInt(request.getParameter("subjectId"));
                        } catch (Exception e) {
                            System.out.println("Parse int: " + e);
                        }
                        subjectDAO = new SubjectDAO();
                        Subject currentSubject = subjectDAO.getById(subjectId + "");
                        request.setAttribute("typeSubject", subjectId);
                        request.setAttribute("currentSubject", currentSubject);
                        QuestionDAO questionDao = new QuestionDAO();
                        List<Subject> subjects = subjectDao.getAll();
                        List<Question> questions = questionDao.getAllBySubject(subjectId);
                        request.setAttribute("questions", questions);
                        request.setAttribute("subjects", subjects);
                        url = "listQuestion.jsp";
                        break;
                    default:
                        List<Subject> subjectsShow = subjectDao.getAll();
                        request.setAttribute("subjects", subjectsShow);
                        url = "listQuestion.jsp";
                        break;
                }

                request.getRequestDispatcher(url).forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            response.sendRedirect("Account");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action") == null ? "" : request.getParameter("action");
            switch (action) {
                case "add":
                    addQuestion(request, response);
                    break;
                case "edit":
                    editQuestion(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void editQuestion(HttpServletRequest request, HttpServletResponse response) {
        try {
            AnswerDAO answerDao = new AnswerDAO();
            QuestionDAO questionDao = new QuestionDAO();
            long questionId = this.getLong(request.getParameter("questionId"));
            long levelId = this.getLong(request.getParameter("levelId"));
            long subjectIdS = this.getLong(request.getParameter("subjectId"));
            String subjectIdBack = request.getParameter("subjectIdBack");
            String content = request.getParameter("questionContent");
            String imageUrl = request.getParameter("questionImage");
            long idCorrect = this.getLong(request.getParameter("correct"));
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
            List<Answer> answers = new ArrayList<>();
            Enumeration<String> parameterNames = request.getParameterNames();
            while (parameterNames.hasMoreElements()) {
                String paramName = parameterNames.nextElement();
                if (paramName.startsWith("answer-text-")) {
                    int answerId = Integer.parseInt(paramName.substring(12));
                    String answerContent = request.getParameter(paramName);
                    boolean isTrue = (idCorrect + "").equals(String.valueOf(answerId));
                    Answer answer = new Answer((long) answerId, (long) questionId, answerContent, isTrue);
                    answers.add(answer);
                }
            }
            Question q = new Question();
            q.setQuestionId(questionId);
            q.setSubjectId(subjectIdS);
            q.setQuestionLevel(levelId);
            q.setQuestionContent(content);
            q.setQuestionImage(imageUrl);
            q.setActive(isActive);
            QuestionDAO questionDAO = new QuestionDAO();
            boolean success = questionDAO.edit(q, answers);
            if (success) {
                response.sendRedirect("question?action=show-question&subjectId=" + subjectIdBack + "&questionId=" + questionId + "&message=Edit successfully");
            } else {
                response.sendRedirect("question?action=show-question&subjectId=" + subjectIdBack + "&questionId=" + questionId + "&message=Edit fail. Try again");
            }
        } catch (Exception e) {
            System.out.println("Edit fail: " + e);
        }
    }

    private long getLong(String input) {
        try {
            long output = Long.parseLong(input);
            return output;
        } catch (Exception e) {
            System.out.println("Int error: " + e);
        }
        return -1;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void addQuestion(HttpServletRequest request, HttpServletResponse response) {
        try {
            SubjectDAO subjectDAO = new SubjectDAO();
            QuestionDAO questionDAO = new QuestionDAO();
            String url = "addquestion.jsp";
            // Question
            String levelIdS = request.getParameter("levelId");
            String subjectIdS = request.getParameter("subjectId");
            String content = request.getParameter("content");
            String imageUrl = request.getParameter("imageURL");
            Question q = new Question();
            Long levelId = Long.parseLong(levelIdS);
            Long subjectId = Long.parseLong(subjectIdS);
            q.setSubjectId(subjectId);
            q.setQuestionLevel(levelId);
            q.setQuestionContent(content);
            q.setQuestionImage(imageUrl);
            boolean result = questionDAO.addNew(q);
            List<Subject> listSubject = subjectDAO.getAll();
            request.setAttribute("SUBJECT", listSubject);
            if (result) {
                long questionId = questionDAO.getIdQuestionWasAdded();
                // Answer
                List<Answer> listAnswer = new ArrayList();
                AnswerDAO answerDAO = new AnswerDAO();
                for (int i = 1; i <= 4; i++) {
                    String answerParamater = "answer-" + i;
                    String answerInput = request.getParameter(answerParamater);
                    String correct = request.getParameter("correct");
                    int correctIndex = 0;
                    if (correct != null) {
                        correctIndex = Integer.parseInt(correct);
                    }
                    Answer answer = new Answer();
                    answer.setAnswerContent(answerInput);
                    answer.setQuestionId(questionId);
                    answer.setTrue(false);
                    if (correctIndex == i) {
                        answer.setTrue(true);
                        System.out.println("Co 1 cau dung roi ne");
                    }
                    answerDAO.addNew(answer);
                }
                request.setAttribute("MESSAGE", "Add new question sucessfully");
            } else {
                request.setAttribute("ERROR", "Add new question failed");
            }
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
