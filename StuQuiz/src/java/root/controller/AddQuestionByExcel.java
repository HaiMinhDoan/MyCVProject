/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package root.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Date;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import root.DAO.AnswerDAO;
import root.DAO.QuestionDAO;
import root.constantservices.Constant;
import root.entities.main.Answer;
import root.entities.main.Question;
import root.entities.main.User;

/**
 *
 * @author admin
 */
@MultipartConfig
public class AddQuestionByExcel extends HttpServlet {

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
            out.println("<title>Servlet AddQuestionByExcel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddQuestionByExcel at " + request.getContextPath() + "</h1>");
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
        User userAuthorization = (User) request.getSession().getAttribute("userAuthorization");
        if (userAuthorization != null && userAuthorization.getRoleLevel() == 3) {
            QuestionDAO questionDAO = new QuestionDAO();
            AnswerDAO answerDAO = new AnswerDAO();
            String subjectIdString = request.getParameter("subjectId");
            Long subjectId = questionDAO.parseLong(subjectIdString);
            if (subjectId != 0L) {
                Long userId = 8L;
                Part filePart = request.getPart("file");
                String fileName = "excel_by_user_" + userId + "_time" + new Date().getTime() + ".xlsx";
                File uploadDir = new File(Constant.EXCEL_SOURCE);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                String filePath = Constant.EXCEL_SOURCE + fileName;

                try (FileOutputStream fos = new FileOutputStream(filePath); InputStream is = filePart.getInputStream()) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = is.read(buffer)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }

                } catch (Exception e) {
                }
                int startRow = 0;
                int endRow = 8;
                int startCol = 0;
                int endCol = 4;
                String[][] data = new String[endRow - startRow + 1][endCol - startCol + 1];
                try (FileInputStream fis = new FileInputStream(filePath); Workbook workbook = new XSSFWorkbook(fis)) {
                    Sheet sheet = workbook.getSheetAt(0);

                    for (int rowIndex = startRow; rowIndex <= endRow; rowIndex++) {
                        Row row = sheet.getRow(rowIndex);
                        if (row != null) {
                            for (int colIndex = startCol; colIndex <= endCol; colIndex++) {
                                Cell cell = row.getCell(colIndex);
                                if (cell != null) {
                                    data[rowIndex - startRow][colIndex - startCol] = getCellValueAsString(cell);
                                } else {
                                    data[rowIndex - startRow][colIndex - startCol] = "";
                                }
                            }
                        } else {
                            for (int colIndex = startCol; colIndex <= endCol; colIndex++) {
                                data[rowIndex - startRow][colIndex - startCol] = "";
                            }
                        }
                    }
                } catch (Exception e) {
                }

                for (int rowIndex = startRow + 1; rowIndex <= endRow; rowIndex++) {
                    if ((rowIndex - 1) % 4 == 0) {
                        Long questionId = 0L;
                        Question question = Question.builder()
                                .subjectId(subjectId)
                                .questionContent(data[rowIndex][0])
                                .questionImage(data[rowIndex][1])
                                .questionLevel((long)questionDAO.parseDouble(data[rowIndex][2]).longValue())
                                .isActive(true)
                                .build();
                        try {
                            questionId = questionDAO.addNewQuestionAndGetId(question);
                        } catch (Exception e) {
                            questionId = 0L;
                        }
                        if (questionId != 0) {
                            for (int rowTempIndex = rowIndex; rowTempIndex <= rowIndex + 3; rowTempIndex++) {
                                Answer answer = Answer.builder()
                                        .questionId(questionId)
                                        .answerContent(data[rowTempIndex][3])
                                        .isTrue(data[rowTempIndex][4].toLowerCase().trim().equals("true"))
                                        .build();
                                try {
                                    answerDAO.addNew(answer);
                                } catch (Exception e) {
                                }
                            }
                        }
                    }

                }
                response.sendRedirect("question?action=show-question&subjectId="+subjectId);
            }
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

    private static String getCellValueAsString(Cell cell) {
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return cell.getDateCellValue().toString();
                } else {
                    return String.valueOf(cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            case BLANK:
                return "";
            default:
                return "";
        }
    }

}
