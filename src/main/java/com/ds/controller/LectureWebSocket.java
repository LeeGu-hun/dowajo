package com.ds.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;

import com.ds.domain.LectureVO;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.log4j.Log4j;



@PreAuthorize("isAuthenticated()")
@Log4j
@Controller("LectureWebSocketController")
@ServerEndpoint(value="/echo/{lecture_no}/{user_name}/{user_no}")
public class LectureWebSocket {
	
//	@Setter(onMethod_ = { @Autowired })
//	private LectureService lectureService;

    private static final java.util.Set<Session> sessions = java.util.Collections.synchronizedSet(new java.util.HashSet<Session>());
    private static final HashMap<String, Long> lectureNoMap = new HashMap<>();
    private static final HashMap<String, String> userNameMap = new HashMap<>();
    private static final HashMap<String, Long> userNoMap = new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("lecture_no") Long lecture_no, @PathParam("user_name") String user_name,  @PathParam("user_no") Long user_no){
    	
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
		//setAbsent(Long.parseLong(lectureNoMap.get(session.getId()).toString()), Long.parseLong(userNoMap.get(session.getId()).toString()));
    	new SetAttend(Long.parseLong(lectureNoMap.get(session.getId()).toString()), Long.parseLong(userNoMap.get(session.getId()).toString())).start();
    	
        System.out.println("Session " +session.getId()+" has ended");
        String str="{\"type\":\"nonAttendance\",\"id\":\""+session.getUserPrincipal().getName()+"\", \"name\":\""+userNameMap.get(session.getId())+"\" }";
        sendAllSessionToMessage( session, str );
        lectureNoMap.remove(session.getId());
        userNameMap.remove(session.getId());
        userNoMap.remove(session.getId());
        sessions.remove(session);
    }
    
    class SetAttend extends Thread{
    	private Long lectureNo;
    	private Long userNo;

        public SetAttend(Long lectureNo, Long userNo) {
            this.lectureNo = lectureNo;
            this.userNo = userNo;
        }
        
        @Override
    	public void run() {
    		setAbsent(lectureNo, userNo);
    		return;
    	}
    	
    }
    

    
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
			pstmt.setString(3, "퇴실");
			if(pstmt.executeUpdate()>0) {
				System.out.println("퇴실처리됨");
				conn.commit();
				conn.setAutoCommit(true);
			}
			else {
				System.out.println("퇴실처리안됨");
				conn.rollback();
				conn.setAutoCommit(true);
				return;
			}
		} catch (SQLException e) {
			
		} finally {
			closeDB();
		}
	}
	
	@Scheduled(cron="1 * * * * *")  
	public void getDeadline() throws Exception{
		log.info("스케쥴1분마다실행");
		System.out.println("스케쥴1분마다실행 syso");
		String str="{\"type\":\"clsHomework\"}";
		String str2="{\"type\":\"clsHomeworkForTeacher\"}";
		List<LectureVO> list = getDeadlineList();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getFile_deadline()!=null) {
				Date listdate=list.get(i).getFile_deadline();
				Date nowdate=new Date();
				String listdateString=dateFormat.format(list.get(i).getFile_deadline());
				String nowdateString=dateFormat.format(new Date());
				System.out.println("listdate : "+listdateString);
				System.out.println("nowdate : "+nowdateString);
				System.out.println("compare : "+listdate.compareTo(nowdate));
				if(listdate.compareTo(nowdate)<0) {
					System.out.println("getDeadlineList : "+list.get(i));
					Iterator<Session> session=sessions.iterator();
					while(session.hasNext()) {
						Session nowSession=session.next();
						if(list.get(i).getLecture_no() == lectureNoMap.get(nowSession.getId())) {
							System.out.println("nowSession's lectureNo : "+lectureNoMap.get(nowSession.getId()));
							nowSession.getBasicRemote().sendText(str);
							nowSession.getBasicRemote().sendText(str2);
						}
						
					}
					System.out.println("getDeadlineLectureNo : "+list.get(i).getLecture_no());
					setFileState(list.get(i).getLecture_no());
					
				}
			}
			
		}
		
		
		
		
		
		
		
	}
	

	
	public List<LectureVO> getDeadlineList() {
		List<LectureVO> list = new ArrayList<LectureVO>();
		String sql = "select LECTURE_NO, LECTURE_NAME, LECTURE_DESCRIPTION, LECTURE_AFREECAID, REGDATE, FILE_STATUS, FILE_DEADLINE from ds_lecture";
		
		try {
			conn = conDB();
			pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				LectureVO vo=new LectureVO();
				vo.setLecture_no(rs.getLong(1));
				vo.setFile_deadline(rs.getDate(7));
				list.add(vo);
			}
			
		} catch (SQLException e) {
			
		} finally {
			closeDB();
		}
		return list;
	}
	
	
	public void setFileState(Long lectureNo) {
		String sql = "";
		
		try {
			conn = conDB();
			conn.setAutoCommit(false);
			sql="update ds_lecture set file_status = 0, file_deadline =null where lecture_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, lectureNo);
			if(pstmt.executeUpdate()>0) {
				System.out.println("과제마감상태로 변경");
				conn.commit();
				conn.setAutoCommit(true);
			}
			else {
				System.out.println("과제마감상태로 변경 실패");
				conn.rollback();
				conn.setAutoCommit(true);
				return;
			}
		} catch (SQLException e) {
			
		} finally {
			closeDB();
		}
	}
	
	
	@Scheduled(cron="0 0 2 * * *")  
	public void deleteFileAll() throws Exception{
		

		/////////////////////////////////////////////////파일삭제 시작
				
		// Calendar 객체 생성
		Calendar cal = Calendar.getInstance() ;
		long todayMil = cal.getTimeInMillis() ;     // 현재 시간(밀리 세컨드)
		long oneDayMil = 24*60*60*1000 ;            // 일 단위
		
		Calendar fileCal = Calendar.getInstance() ;
		Date fileDate = null ;
		
		
		File path = new File("c:\\upload") ;
		File[] flist = path.listFiles() ;            // 파일 리스트 가져오기
		
		
		for(int j=0 ; j < flist.length; j++){
			// 파일의 마지막 수정시간 가져오기
			fileDate = new Date(flist[j].lastModified()) ;
			
			// 현재시간과 파일 수정시간 시간차 계산(단위 : 밀리 세컨드)
			fileCal.setTime(fileDate);
			long diffMil = todayMil - fileCal.getTimeInMillis() ;
			
			//날짜로 계산
			int diffDay = (int)(diffMil/oneDayMil) ;
			
			
			
			
			
			
			
			// 30일이 지난 파일 삭제
			if(diffDay > 30 && flist[j].exists()){
				
				
				try {
					File path2 = new File(flist[j].toString());
					File[] flist2;
					flist2 = path2.listFiles();
					for(int k=0 ; k < flist2.length; k++){
						flist2[k].delete() ;
						System.out.println(flist2[k].getName() + " 파일(폴더안)을 삭제했습니다.");
					}
				} catch (Exception e) {
					//e.printStackTrace();
					//System.out.println("폴더가 아니라 파일임");
				}
				
				
				flist[j].delete() ;
				System.out.println(flist[j].getName() + " 파일을 삭제했습니다.");
			}
		
		}
		
		/////////////////////////////////////////////////파일삭제 끝
		
	}


    
}
 