package com.ds.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ds.domain.AttendanceVO;
import com.ds.mapper.LectureMapper;
import com.ds.service.LectureService;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RequestMapping("/test/*")
@PreAuthorize("isAuthenticated()")
@Log4j
@Controller("LectureWebSocketController")
@ServerEndpoint(value="/echo/{lecture_no}/{user_name}/{user_no}")
public class LectureWebSocket {
	
	@Setter(onMethod_ = { @Autowired })
	private LectureService lectureService;
	@Setter(onMethod_ = { @Autowired })
	private LectureMapper lectureapper;

    private static final java.util.Set<Session> sessions = java.util.Collections.synchronizedSet(new java.util.HashSet<Session>());
    private static final HashMap<String, Integer> lectureNoMap = new HashMap<>();
    private static final HashMap<String, String> userNameMap = new HashMap<>();
    private static final HashMap<String, Long> userNoMap = new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("lecture_no") int lecture_no, @PathParam("user_name") String user_name,  @PathParam("user_no") Long user_no){
    	
    	//UserVO userVo=lecureService.userInfo(user_no); // onOpen이나 onClose에서는 JsonParser도 그렇고 쓰레드 사용할만한 것들은 죄다 안되는듯
    	
    	Iterator<String> keys = userNoMap.keySet().iterator();
    	while( keys.hasNext() ){
    		String key = keys.next();
    		if(userNoMap.get(key)==user_no) {
    			try {
    	            final Basic basic = session.getBasicRemote();
    	            String overlap="{\"type\":\"overlap\"}";
    	            basic.sendText(overlap);
    	        } catch (IOException e) {
    	            System.out.println(e.getMessage());
    	        }
    			return;
    		}
    	}
    	
        System.out.println("Open session id : " + session.getId());
        System.out.println("Open session getRequestURI : " + session.getRequestURI());
        System.out.println("Open session getUserPrincipal : " + session.getUserPrincipal());
        System.out.println("Open session name : " + session.getUserPrincipal().getName());
        lectureNoMap.put(session.getId(),lecture_no);
        System.out.println(session.getId()+"의 접속시 강의실번호 : "+lectureNoMap.get(session.getId()));
        System.out.println(lectureNoMap);
        userNameMap.put(session.getId(),user_name);
        System.out.println(session.getId()+"의 이름 : "+userNameMap.get(session.getId()));
        System.out.println(userNameMap);
        userNoMap.put(session.getId(),user_no);
        System.out.println(session.getId()+"의 유저번호 : "+userNoMap.get(session.getId()));
        System.out.println(userNoMap);
        
        
        sessions.add(session);
    }
    
    @OnMessage
    public void onMessage(String msg,  Session session){
    	sendAllSessionToMessage( session, msg );
    	
    	JsonObject jsonObjectAlt = JsonParser.parseString(msg).getAsJsonObject();
    	if(jsonObjectAlt.get("type").toString().equals("\"message\"")) {
    		jsonObjectAlt.addProperty("name", "나");
    	}
    	msg=jsonObjectAlt.toString();
    	try {
    		final Basic basic = session.getBasicRemote();
    			basic.sendText(msg);
    	} catch (IOException ex) {
    		ex.printStackTrace();
    	}
    	
    }
   

    private void sendAllSessionToMessage(Session self, String message){
    	
        try {
            for( Session session : LectureWebSocket.sessions ){
                if( ! self.getId().equals(session.getId()) ) {
                	if(lectureNoMap.get(self.getId())==lectureNoMap.get(session.getId())) {
                		session.getBasicRemote().sendText(message);
                		
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
		
//    	testss();
//    	AttendanceVO vo=new AttendanceVO();
//    	vo.setLecture_no(1l);
//    	vo.setUser_no(3l);
//    	vo.setAttendance_state("test");
//    	System.out.println("vo는 제대로 찍힘"+vo);
//    	lectureService.setAttend(vo);
    	
    	new SetAttend().start();
        System.out.println("Session " +session.getId()+" has ended");
        String str="{\"type\":\"nonAttendance\",\"id\":\""+session.getUserPrincipal().getName()+"\", \"name\":\""+userNameMap.get(session.getId())+"\" }";
        sendAllSessionToMessage( session, str );
        lectureNoMap.remove(session.getId());
        userNameMap.remove(session.getId());
        userNoMap.remove(session.getId());
        sessions.remove(session);
    }
    
    class SetAttend extends Thread{
    	
    	public void run() {
//    		testss();
    		AttendController attend=new AttendController();
    		AttendanceVO vo=new AttendanceVO();
        	vo.setLecture_no(1l);
        	vo.setUser_no(3l);
        	vo.setAttendance_state("absent");
        	System.out.println("클래스 불러오기");
    		attend.putAbsent(vo);
    		return;
    	}
    	
    }
    
//    @GetMapping("testss")
//	public void testss() {
//    	
//    	
//		AttendanceVO vo=new AttendanceVO();
//    	vo.setLecture_no(1l);
//    	vo.setUser_no(3l);
//    	vo.setAttendance_state("test");
//    	System.out.println("testVO"+vo);
//    	lectureService.setAttend(vo);
//	}


    
}
 