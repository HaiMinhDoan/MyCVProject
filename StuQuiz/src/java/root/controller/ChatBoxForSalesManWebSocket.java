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
import root.entities.sub.BlockChatSalesman;
import root.entities.sub.ResponseEntity;
import root.roleAndLevel.Kind;
import root.roleAndLevel.Status;

/**
 *
 * @author admin
 */
@ServerEndpoint("/chat-sales-man/{salesManId}/{customerId}/{activeCode}")
public class ChatBoxForSalesManWebSocket {

    @OnOpen
    public void onOpen(Session session, @PathParam("salesManId") String salesManId, @PathParam("customerId") String customerId, @PathParam("activeCode") String activeCode) {
        String json = "";
        if (salesManId != null) {
            UserDAO userDAO = new UserDAO();
            try {
                User user = userDAO.getById(salesManId);
                if (user.getUserId() != 0) {
                    session.getUserProperties().put("userAuthorization", user);
                }
            } catch (Exception e) {
            }
        }
        WebSocketServices.users.add(session);
    }

    @OnMessage
    public void onMessage(Session session, String message, @PathParam("salesManId") String salesManId, @PathParam("customerId") String customerId, @PathParam("activeCode") String activeCode) {
        User salesMan = (User) session.getUserProperties().get("userAuthorization");
        UserDAO userDAO = new UserDAO();
        Gson gson = new Gson();
        User customer = new User();
        BoxChatDAO boxChatDAO = new BoxChatDAO();
        try {
            customer = userDAO.getById(customerId);
            BoxChat boxChat = gson.fromJson(message, BoxChat.class);
            if (boxChat.getSenderId() != salesMan.getUserId() && boxChat.getSenderId() != 0) {
                List<User> listUsers = userDAO.getListUserChatWith(salesManId);
                List<BlockChatSalesman> listBlocks = new ArrayList<>();
                for (User u : listUsers) {
                    List<BoxChat> listBoxChats = boxChatDAO.getListAllBoxChatByMembers(salesManId, u.getUserId() + "");
                    BlockChatSalesman block = BlockChatSalesman.builder()
                            .user(u)
                            .listBoxChats(listBoxChats)
                            .build();
                    block.setSeen();
                    listBlocks.add(block);
                }
                sortListBlockChat(listBlocks);
                ResponseEntity responseEntity = ResponseEntity.builder()
                        .status(Status.SUCCESS)
                        .kind(Kind.LIST_BLOCK_CHAT)
                        .data(listBlocks)
                        .build();
                String json = gson.toJson(responseEntity);
                for (Session s : WebSocketServices.users) {
                    User u = (User) s.getUserProperties().get("userAuthorization");
                    if (salesMan.getUserId() == u.getUserId()) {
                        try {
                            s.getBasicRemote().sendText(json);
                        } catch (Exception e) {
                        }
                    }
                }
            }
            if (boxChat.getSenderId() == salesMan.getUserId() && boxChat.getSenderId() != 0) {
                boxChat.setSendTime(new Date());
                boxChat.setSeen(false);
                boxChatDAO.addNew(boxChat);
                List<User> listUsers = userDAO.getListUserChatWith(salesManId);
                List<BlockChatSalesman> listBlocks = new ArrayList<>();
                for (User u : listUsers) {
                    List<BoxChat> listBoxChats = boxChatDAO.getListAllBoxChatByMembers(salesManId, u.getUserId() + "");
                    if (u.getUserId() == customer.getUserId()) {
                        BoxChat tempBoxChat = boxChatDAO.getLastestBoxChatBySenderAndReceiverId(customerId, salesManId);
                        if (tempBoxChat.getBoxChatId() != 0) {
                            tempBoxChat.setSeen(true);
                            boxChatDAO.updateById(tempBoxChat.getBoxChatId() + "", tempBoxChat);
                        }
                    }
                    BlockChatSalesman block = BlockChatSalesman.builder()
                            .user(u)
                            .listBoxChats(boxChatDAO.getListAllBoxChatByMembers(salesManId, u.getUserId() + ""))
                            .build();
                    block.setSeen();
                    listBlocks.add(block);
                }
                sortListBlockChat(listBlocks);
                ResponseEntity dataForSales = ResponseEntity.builder()
                        .status(Status.SUCCESS)
                        .kind(Kind.LIST_BLOCK_CHAT)
                        .data(listBlocks)
                        .build();
                String json1 = gson.toJson(dataForSales);
                for (Session s : WebSocketServices.users) {
                    User u = (User) s.getUserProperties().get("userAuthorization");
                    if (salesMan.getUserId() == u.getUserId()) {
                        try {
                            s.getBasicRemote().sendText(json1);
                        } catch (Exception e) {
                        }
                    }
                }
                List<BoxChat> listBoxes = boxChatDAO.getListAllBoxChatByMembers(salesManId, customerId);
                ResponseEntity dataForCustomer = ResponseEntity.builder()
                        .status(Status.SUCCESS)
                        .kind(Kind.MESSAGE)
                        .data(listBoxes)
                        .build();
                String json2 = gson.toJson(dataForCustomer);
                for (Session s : WebSocketServices.users) {
                    User u = (User) s.getUserProperties().get("userAuthorization");
                    if (customer.getUserId() == u.getUserId()) {
                        try {
                            s.getBasicRemote().sendText(json2);
                        } catch (Exception e) {
                        }
                    }
                }
            }
            if (boxChat.getSenderId() == 0 && boxChat.getReceiverId() == 0) {
                List<User> listUsers = userDAO.getListUserChatWith(salesManId);
                List<BlockChatSalesman> listBlocks = new ArrayList<>();
                for (User u : listUsers) {
                    BlockChatSalesman block = BlockChatSalesman.builder()
                            .user(u)
                            .listBoxChats(boxChatDAO.getListAllBoxChatByMembers(salesManId, u.getUserId() + ""))
                            .build();
                    block.setSeen();
                    listBlocks.add(block);
                }
                sortListBlockChat(listBlocks);
                ResponseEntity responseEntity = ResponseEntity.builder()
                        .status(Status.SUCCESS)
                        .kind(Kind.LIST_BLOCK_CHAT)
                        .data(listBlocks)
                        .build();
                String json = gson.toJson(responseEntity);
                 session.getBasicRemote().sendText(json);
            }
            if (boxChat.getSenderId() == -1) {
                List<User> listUsers = new ArrayList<>();
                if (boxChat.getChatContent().trim().equals("")||boxChat.getChatContent()==null) {
                    listUsers = userDAO.getListUserChatWith(salesManId);
                } else {
                    listUsers = userDAO.getAllContainWithEmailAndName(boxChat.getChatContent());
                    if(customer.getUserId()!=0&&!customer.getUserName().trim().toLowerCase().contains(boxChat.getChatContent().trim().toLowerCase())&&
                            !customer.getUserEmail().trim().toLowerCase().contains(boxChat.getChatContent().trim().toLowerCase())){
                        listUsers.add(customer);
                    }
                }
                List<BlockChatSalesman> listBlocks = new ArrayList<>();
                for (User u : listUsers) {
                    BlockChatSalesman block = BlockChatSalesman.builder()
                            .user(u)
                            .listBoxChats(boxChatDAO.getListAllBoxChatByMembers(salesManId, u.getUserId() + ""))
                            .build();
                    block.setSeen();
                    listBlocks.add(block);
                }
                sortListBlockChat(listBlocks);
                ResponseEntity responseEntity = ResponseEntity.builder()
                        .status(Status.SUCCESS)
                        .kind(Kind.LIST_BLOCK_CHAT)
                        .data(listBlocks)
                        .build();
                String json = gson.toJson(responseEntity);
                session.getBasicRemote().sendText(json);
            }
        } catch (Exception e) {
            e.printStackTrace();
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

    public void sortListBlockChat(List<BlockChatSalesman> list) {
        if (list.size() != 0) {
            for (int i = 0; i < list.size(); i++) {
                for (int j = i + 1; j < list.size(); j++) {
                    BlockChatSalesman block1 = list.get(i);
                    BlockChatSalesman block2 = list.get(j);
                    List<BoxChat> listBoxChats1 = block1.getListBoxChats();
                    List<BoxChat> listBoxChats2 = block2.getListBoxChats();
                    if (listBoxChats1.size() != 0 && listBoxChats2.size() != 0) {
                        if (listBoxChats1.get(listBoxChats1.size() - 1).getSendTime().before(listBoxChats2.get(listBoxChats2.size() - 1).getSendTime())) {
                            list.set(i, block2);
                            list.set(j, block1);
                        }
                    }
                }
            }
        }
    }
}
