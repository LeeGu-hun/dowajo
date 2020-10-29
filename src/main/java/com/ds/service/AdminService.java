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
	
	public List<UserVO> admin_list(Criteria cri);
	public List<UserVO> teacher_list(Criteria cri);
	public List<UserVO> student_list(Criteria cri);
	public int getlistTotal(Criteria cri);
	
	public UserVO get(int user_no);
	public boolean remove(int user_no);
	
}