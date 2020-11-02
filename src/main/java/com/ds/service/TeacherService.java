package com.ds.service;

import java.util.List;

import com.ds.domain.Criteria;
import com.ds.domain.TeacherVO;
import com.ds.domain.UserVO;

public interface TeacherService {
	public String duplicateId(String id);
	public void regist(TeacherVO vo);
	public boolean remove(int lecture_no);
	public boolean modify(TeacherVO cust);
	public List<TeacherVO> cancel(int lecture_no);
	public List<TeacherVO> sign_up(int lecture_no); 
	public List<TeacherVO> getList();
	public List<TeacherVO> regetlist_canecl(int lecture_no);
	public List<TeacherVO> regetlist_sign_up(int lecture_no);
	public List<TeacherVO> call_no(int lecture_no);
	public List<TeacherVO> refresh(String[] checkArr,int lecture_no);
	public List<TeacherVO> cancelrefresh(String[] checkArr,int lecture_no);
	public int getTotal(Criteria cri);
	public List<TeacherVO> getList(Criteria cri);
	
	public List<TeacherVO> getUserTypeList(Criteria cri);
	
	public UserVO user_read(String user_id);	//사용자 마이페이지
	public boolean user_modify(UserVO vo);		//사용자 정보 수정
	public boolean user_delete(Long user_no);	//사용자 삭제
}
