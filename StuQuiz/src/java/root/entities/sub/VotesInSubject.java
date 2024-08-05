/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.entities.sub;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import root.entities.main.Comment;
import root.entities.main.Lesson;

/**
 *
 * @author admin
 */
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class VotesInSubject {

    private Long subjectId;
    private float totalVote;

    @Override
    public String toString() {
        return "CommentsInSubject{"
                + "subjectId=" + subjectId
                + ", totalVotes=" + totalVote
                + '}';
    }
}
