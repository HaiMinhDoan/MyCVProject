/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.entities.main;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 *
 * @author admin
 */
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Quiz {
    private Long quizId;
    private Long lessonId;
    private String quizName;
    private Long quizLevel;
    private Long quizDuration;
    private Double passRate;
    private Long quizType;
    private String quizDescription;
    private Long eQuestion;
    private Long mQuestion;
    private Long hQuestion;
    private boolean isActive;
}
