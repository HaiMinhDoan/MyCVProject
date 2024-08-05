/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.controller;

import com.google.gson.Gson;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import root.DAO.BoxChatDAO;
import root.DAO.UserDAO;
import root.constantservices.WebSocketServices;
import root.entities.main.BoxChat;
import root.entities.main.User;
import root.entities.sub.ResponseEntity;
import root.roleAndLevel.Kind;

/**
 *
 * @author admin
 */
@ServerEndpoint("/chat-customer/{userId}/{activeCode}")
public class ChatBoxForCustomerWebSocket {

    @OnOpen
    public void onOpen(Session session, @PathParam("userId") String userId, @PathParam("activeCode") String activeCode) {
        if (userId != null) {
            UserDAO userDAO = new UserDAO();
            try {
                User user = userDAO.getById(userId);
                user.setCreatedTime(new Date());
                user.setActiveCode(activeCode);
                if (user.getUserId() != 0L) {
                    session.getUserProperties().put("userAuthorization", user);
                }
            } catch (Exception e) {
            }
        }
        WebSocketServices.users.add(session);
    }

    @OnMessage
    public void onMessage(Session session, String message, @PathParam("userId") String userId, @PathParam("activeCode") String activeCode) {
        Gson gson = new Gson();
        UserDAO userDAO = new UserDAO();
        BoxChatDAO boxChatDAO = new BoxChatDAO();
        User user = (User) session.getUserProperties().get("userAuthorization");
        BoxChat boxChat = new BoxChat();
        boxChat = gson.fromJson(message, BoxChat.class);
        List<BoxChat> listBoxChats = new ArrayList<>();
        if (user == null) {
        } else {
            if (!boxChat.getBoxChatId().equals(0L)) {
                boxChat.setSendTime(new Date());
                try {
                    boxChatDAO.addNew(boxChat);
                } catch (Exception e) {
                }
            }
            try {
                listBoxChats = boxChat.getBoxChatId().equals(0L)
                        ? boxChatDAO.getListAllBoxChatByMembers(user.getUserId() + "")
                        : boxChatDAO.getListAllBoxChatByMembers(user.getUserId() + "", boxChat.getReceiverId() + "");
                String json = gson.toJson(ResponseEntity.builder()
                        .kind(Kind.MESSAGE)
                        .data(listBoxChats)
                        .build());
                session.getBasicRemote().sendText(json);
                for (Session userSession : WebSocketServices.users) {
                    User temp = (User) userSession.getUserProperties().get("userAuthorization");
                    if (temp.getUserId().equals(user.getUserId()) || temp.getUserId().equals(boxChat.getReceiverId())) {
                        userSession.getBasicRemote().sendText(json);
                    }
                }
            } catch (Exception e) {
                String json = gson.toJson(ResponseEntity.builder()
                        .kind(Kind.ERROR)
                        .data("Session may be crash!")
                        .build());
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        WebSocketServices.users.remove(session);
    }

    @OnError
    public void handleError(Throwable t) {
        t.printStackTrace();
    }
}
