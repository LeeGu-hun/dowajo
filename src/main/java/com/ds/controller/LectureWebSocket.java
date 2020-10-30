package com.ds.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;

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

import com.ds.domain.AttendanceVO;
import com.ds.mapper.LectureMapper;
import com.ds.service.LectureService;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;



@PreAuthorize("isAuthenticated()")
@Log4j
@Controller("LectureWebSocketController")
@ServerEndpoint(value="/echo/{lecture_no}/{user_name}/{user_no}")
public class LectureWebSocket {
	
//	@Setter(onMethod_ = { @Autowired })
//	private LectureService lectureService;

    private static final java.util.Set<Session> sessions = java.util.Collections.synchronizedSet(new java.util.HashSet<Session>());
    private static final HashMap<String, Integer> lectureNoMap = new HashMap<>();
    private static final HashMap<String, String> userNameMap = new HashMap<>();
    private static final HashMap<String, Long> userNoMap = new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("lecture_no") int lecture_no, @PathParam("user_name") String user_name,  @PathParam("user_no") Long user_no){
    	
    	//UserVO userVo=lecureService.userInfo(user_no); // service는 get이나 post같은 주소 이동때만 작동하는듯.
    	
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
		setAbsent(Long.parseLong(lectureNoMap.get(session.getId()).toString()), Long.parseLong(userNoMap.get(session.getId()).toString()));
//    	new SetAttend().start();
    	
        System.out.println("Session " +session.getId()+" has ended");
        String str="{\"type\":\"nonAttendance\",\"id\":\""+session.getUserPrincipal().getName()+"\", \"name\":\""+userNameMap.get(session.getId())+"\" }";
        sendAllSessionToMessage( session, str );
        lectureNoMap.remove(session.getId());
        userNameMap.remove(session.getId());
        userNoMap.remove(session.getId());
        sessions.remove(session);
    }
    
//    class SetAttend extends Thread{
//    	
//    	public void run() {
//    		
//    		return;
//    	}
//    	
//    }
    

    
    private Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public Connection conDB() throws SQLException{
//		String Driver = "jdbc:oracle:thin:@localhost:1521:xe";
		String Driver = "jdbc:log4jdbc:oracle:thin:@localhost:1521:xe";
		String User = "db7";
		String Pass = "1234";
		conn = DriverManager.getConnection(Driver, User, Pass);
		return conn;
	}
	
	public void closeDB() {
		try {
			if(conn!=null) conn.close();
			if(pstmt!=null) pstmt.close();
			if(rs!=null) rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public void setAbsent(Long lectureNo, Long userNo) {
		String sql = "";
		
		try {
			conn = conDB();
			conn.setAutoCommit(false);
			sql="insert into ds_attendance (LECTURE_NO, USER_NO, ATTENDANCE_STATE) values (?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, lectureNo);
			pstmt.setLong(2, userNo);
			pstmt.setString(3, "absent");
			if(pstmt.executeUpdate()>0) {
				System.out.println("렉쳐나간거완료");
				conn.commit();
				conn.setAutoCommit(true);
			}
			else {
				System.out.println("렉쳐나간거 실패");
				conn.rollback();
				conn.setAutoCommit(true);
				return;
			}
		} catch (SQLException e) {
			
		} finally {
			closeDB();
		}
	}


    
}
 