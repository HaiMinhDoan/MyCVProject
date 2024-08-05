/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.constantservices;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import root.entities.main.Question;
import root.roleAndLevel.Level;

/**
 *
 * @author admin
 */
public class RandomService {

    public static String getRandomActiveCode(Long lenghtOfString) {
        String characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder randomString = new StringBuilder();

        Random random = new Random();
        for (int i = 0;
                i < lenghtOfString; i++) {
            int index = random.nextInt(characters.length());
            char randomChar = characters.charAt(index);
            randomString.append(randomChar);
        }

        return randomString.toString();
    }

    public static List<Question> getRandomExamByListQuestion(Long eQuestion, Long mQuestion, Long hQuestion, List<Question> listQuestions) {
        List<Question> list = new ArrayList<>();
        List<Question> listAllE = new ArrayList<>();
        List<Question> listAllM = new ArrayList<>();
        List<Question> listAllH = new ArrayList<>();
        
        for (Question question : listQuestions) {
            if(question.getQuestionLevel().equals(Level.EASY)){
                listAllE.add(question);
            }else if (question.getQuestionLevel().equals(Level.MEDIUM)){
                listAllM.add(question);
            } else {
                listAllH.add(question);
            }
        }
        List<Integer> randomIndex = getRandomDistinctNumbers(eQuestion.intValue(), 0, listAllE.size()-1);
        for (Integer integer : randomIndex) {
            list.add(listAllE.get(integer));
        }
        randomIndex = getRandomDistinctNumbers(mQuestion.intValue(), 0, listAllM.size()-1);
        for (Integer integer : randomIndex) {
            list.add(listAllM.get(integer));
        }
        randomIndex = getRandomDistinctNumbers(hQuestion.intValue(), 0, listAllH.size()-1);
        for (Integer integer : randomIndex) {
            list.add(listAllH.get(integer));
        }
        return list;
    }

    public static List<Integer> getRandomDistinctNumbers(int n, int a, int b) {
        List<Integer> allNumbers = new ArrayList<>();
        for (int i = a; i <= b; i++) {
            allNumbers.add(i);
        }
        if (n > b - a + 1) {
            return allNumbers;
        }
        List<Integer> result = new ArrayList<>();
        Random random = new Random();
        for (int i = 0; i < n; i++) {
            int index = random.nextInt(allNumbers.size());
            result.add(allNumbers.remove(index));
        }
        return result;
    }

}
