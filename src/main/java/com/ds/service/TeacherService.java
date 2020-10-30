package com.ds.service;

import java.util.List;

import com.ds.domain.Criteria;
import com.ds.domain.SignupVO;
import com.ds.domain.TeacherVO;

public interface TeacherService {
	public String duplicateId(String id);
	public void regist(TeacherVO vo);
	public boolean remove(int lecture_no);
	public boolean modify(TeacherVO cust);
	public List<TeacherVO> cancel(int lecture_no);
	public List<TeacherVO> sign_up(int lecture_no); 
	public List<TeacherVO> getList();
	public List<TeacherVO> call_no(int lecture_no);
	public List<TeacherVO> refresh(String[] checkArr,int lecture_no);
	public List<TeacherVO> cancelrefresh(String[] checkArr,int lecture_no);
	public int getTotal(Criteria cri);
	public List<TeacherVO> getList(Criteria cri);
}
