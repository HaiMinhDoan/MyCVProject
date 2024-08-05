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
public class User {
    private Long userId;
    private String userName;
    private String userEmail;
    private String userPassword;
    private Long roleLevel;
    private String userAvatar;
    private String userBank;
    private String userBankCode;
    private Date createdTime;
    private String activeCode;
    private boolean isActive;
    
}
