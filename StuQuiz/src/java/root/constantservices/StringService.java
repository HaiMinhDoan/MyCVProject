/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.constantservices;

import java.util.HashMap;
import java.util.HashSet;

/**
 *
 * @author admin
 */
public class StringService {
    public static String[] convertStringToId(String inputString){
        String arr[] = inputString.split("_");
        return arr;
    }
}
