package com.ds.mapper;

import java.util.List;

import com.ds.domain.AuthVO;
import com.ds.domain.Criteria;
import com.ds.domain.QuestionsVO;
import com.ds.domain.UserVO;

public interface AdminMapper {
	
	public List<QuestionsVO> getQueList(Criteria cri);
	public int getTotalCount(Criteria cri);
	public List<QuestionsVO> getQueList2(Criteria cri);
	public int getTotalCount2(Criteria cri);
	
	public List<UserVO> admin_List(Criteria cri);
	public List<UserVO> teahcer_List(Criteria cri);
	public List<UserVO> student_List(Criteria cri);
	public int getlistTotal(Criteria cri);
	public int getlistTotal2(Criteria cri);
	public int getlistTotal3(Criteria cri);
	
	public void admin_regist(UserVO vo);
	public void admin_registAuth(AuthVO auth);
	public void teacher_regist(UserVO vo);
	public void teacher_registAuth(AuthVO auth);
	
	public String duplicateId(String user_id);
	
	public UserVO read(int user_no);
	public int delete(int user_id);
	
	public UserVO user_read(String user_id);	//사용자 정보보기
	public int user_update(UserVO vo);			//회원정보 업데이트
	public int user_delete(Long user_no);		//사용자 삭제
	
}
