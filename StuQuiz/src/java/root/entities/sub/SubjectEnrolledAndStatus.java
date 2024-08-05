/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.entities.sub;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import root.entities.main.Subject;

/**
 *
 * @author vtdle
 */
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SubjectEnrolledAndStatus {

    private Subject subject;
    private boolean learning;
    private Date startDate;
    private Date endDate;
    private Double subjectPrice;
    private Double salePrice;
    private Double discountedPrice;
    private Long enrolledCount;
}


