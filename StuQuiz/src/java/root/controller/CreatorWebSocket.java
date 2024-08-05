/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.controller;

/**
 *
 * @author admin
 */
import com.google.gson.Gson;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import root.DAO.UserDAO;
import root.constantservices.WebSocketServices;
import root.entities.main.User;

@ServerEndpoint("/creator/{userId}")
public class CreatorWebSocket {

    @OnOpen
    public void onOpen(Session session, @PathParam("userId") String userId) {
        UserDAO userDAO = new UserDAO();
        try {
            User user = userDAO.getById(userId);
            if (user.getUserId() != 0L && (user.getRoleLevel() == 3L || user.getRoleLevel() == 1)) {
                session.getUserProperties().put("creator", user);
                WebSocketServices.creators.add(session);
            }
        } catch (Exception e) {
        }

    }

    @OnMessage
    public static void onMessage(Session session, String message) {
        User creator = (User) session.getUserProperties().get("creator");
        if (creator != null && creator.getRoleLevel() == 3L) {
            try {
                
            } catch (Exception e) {
            }
        }
    }

}
