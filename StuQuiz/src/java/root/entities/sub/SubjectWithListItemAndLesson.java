/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.entities.sub;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import root.entities.main.Item;
import root.entities.main.Lesson;
import root.entities.main.Subject;

/**
 *
 * @author admin
 */
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SubjectWithListItemAndLesson {
    private Subject subject;
    private List<Item> listItems;
    private List<Lesson> listLessons;
}
