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
import root.entities.main.BoxChat;
import root.entities.main.User;

/**
 *
 * @author admin
 */
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BlockChatSalesman {

    private User user;
    private List<BoxChat> listBoxChats;
    private boolean seen;
    private Long unSeenMess;

    public void setSeen() {
        this.seen = true;
        this.unSeenMess = 0L;
        for (BoxChat boxChat : listBoxChats) {
            if (boxChat.getSenderId().equals(user.getUserId())) {
                if (!boxChat.isSeen()) {
                    this.unSeenMess++;
                    this.seen = false;
                } else {
                    this.unSeenMess =0L;
                    this.seen = true;
                }
            }
        }
    }
}
