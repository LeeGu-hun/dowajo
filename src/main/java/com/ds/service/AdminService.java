package com.ds.service;

import java.util.List;

import com.ds.domain.Criteria;
import com.ds.domain.LectureVO;
import com.ds.domain.QuestionsVO;
import com.ds.domain.UserVO;
	
public interface AdminService {
	
	//admin
	public void admin_regist(UserVO vo);
	public void teacher_regist(UserVO vo);
	
	public String duplicateId(String user_id);
	
	public List<QuestionsVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
	public List<QuestionsVO> getList2(Criteria cri);
	public int getTotal2(Criteria cri);
	
	public int getUserTypeTotal(Criteria cri);
	public List<UserVO> getUserTypeList(Criteria cri);

	public UserVO get(int user_no);
	public boolean remove(int user_no);
	
	public UserVO user_read(String user_id);	//사용자 마이페이지
	public boolean user_modify(UserVO vo);		//사용자 정보 수정
	public boolean user_delete(Long user_no);	//사용자 삭제
	
}