package com.ds.controller;

import java.io.IOException;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


@Controller("LectureWebSocketController")
@ServerEndpoint(value="/echo/{lecture_no}")
public class LectureWebSocket {

    private static final java.util.Set<Session> sessions = java.util.Collections.synchronizedSet(new java.util.HashSet<Session>());
   

    @OnOpen
    public void onOpen(Session session, @PathParam("lecture_no") String lecture_no){
        System.out.println("Open session id : " + session.getId());
        System.out.println("Open session getRequestURI : " + session.getRequestURI());
        System.out.println("Open session getUserPrincipal : " + session.getUserPrincipal());
        System.out.println("Open session name : " + session.getUserPrincipal().getName());
        System.out.println("Open session getMaxBinaryMessageBufferSize : " + session.getMaxBinaryMessageBufferSize());
        System.out.println("Open session getMaxIdleTimeout : " + session.getMaxIdleTimeout());
        System.out.println("Open session getMaxTextMessageBufferSize : " + session.getMaxTextMessageBufferSize());
        int number=Integer.parseInt(lecture_no);
        session.setMaxBinaryMessageBufferSize(number);
        System.out.println("Open session getMaxBinaryMessageBufferSize : " + session.getMaxBinaryMessageBufferSize());
        
        
        try {
            final Basic basic = session.getBasicRemote();
            basic.sendText("Connection Established");
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
        
//        MessageHandler handler = null;
//        session.addMessageHandler(handler);
//        session.getMessageHandlers();
        
       
        sessions.add(session);
    }
    
    @OnMessage
    public void onMessage(String msg,  Session session){
    	
    	JsonObject jsonObjectAlt = JsonParser.parseString(msg).getAsJsonObject();
    	System.out.println("msg " + session.getId() + ": " + msg);
    	System.out.println("msg " + session.getId() + ": " + jsonObjectAlt.get("type"));
//    	System.out.println("Message from " + session.getId() + ": " + message);
    	try {
    		final Basic basic = session.getBasicRemote();
//    			basic.sendText("to : " + jsonObjectAlt);
    			basic.sendText(msg);
    	} catch (IOException ex) {
    		ex.printStackTrace();
    	}
    	
    	sendAllSessionToMessage( session, jsonObjectAlt );
    }
   

    private void sendAllSessionToMessage(Session self, JsonObject message){
    	String msg=message.toString();
        try {
            for( Session session : LectureWebSocket.sessions ){
                if( ! self.getId().equals(session.getId()) ) {
                	if(session.getMaxBinaryMessageBufferSize()==self.getMaxBinaryMessageBufferSize()) {
                		//session.getBasicRemote().sendText("All : " + message);
                		session.getBasicRemote().sendText(msg);
                		
                	}
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
   
    @OnError
    public void onError( Throwable e, Session session){
       
    }

    @OnClose
    public void onClose(Session session){
        System.out.println("Session " +session.getId()+" has ended");
        sessions.remove(session);
    }
}
 