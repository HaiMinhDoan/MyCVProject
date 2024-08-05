/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.constantservices;

import jakarta.websocket.Session;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author admin
 */
public class WebSocketServices {
    public static Set<Session> users = Collections.synchronizedSet(new HashSet<>());
    public static Set<Session> creators = Collections.synchronizedSet(new HashSet<>());
}
