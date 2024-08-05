/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.entities.main;

import java.util.Date;
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
public class Post {
    private Long postId;
    private Long creator;
    private String postContent;
    private String postImage;
    private String hashTag;
    private Date createdDate;
    private User author;
     public String getSummary() {
        if (postContent.length() > 90) {
            return postContent.substring(0, 89);
        } else {
            return postContent;
        }
    }
    public String getSummary50() {
        if (postContent.length() > 40) {
            return postContent.substring(0, 39) + " ....";
        } else {
            return postContent + " ....";
        }
    }



}
