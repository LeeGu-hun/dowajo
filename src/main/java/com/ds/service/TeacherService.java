package com.ds.service;

import java.util.List;

import com.ds.domain.Criteria;
import com.ds.domain.LectureVO;
import com.ds.domain.TeacherQuestionsVO;
import com.ds.domain.TeacherVO;
import com.ds.domain.UserVO;

public interface TeacherService {
	public String duplicateId(String id);
	public void register(LectureVO lecture);
	public void register_class_list(LectureVO lecture,Long user_no);
	public TeacherVO lecture_modify(TeacherVO vo);
	public TeacherVO lecture_get(Long lecture_no);
	public boolean remove(Long lecture_no);
	public boolean modify(TeacherVO cust);
	public List<TeacherVO> cancel(Long lecture_no);
	public List<TeacherVO> sign_up(Long lecture_no); 
	public List<TeacherVO> getList(Long user_no);
	public List<TeacherVO> regetlist_canecl(Long lecture_no);
	public List<TeacherVO> regetlist_sign_up(Long lecture_no);
	public List<TeacherVO> call_no(Long lecture_no);
	public List<TeacherVO> refresh(String[] checkArr,Long lecture_no);
	public List<TeacherVO> cancelrefresh(String[] checkArr,Long lecture_no);
	public int getTotal(Criteria cri);
//	public List<TeacherVO> getList(Criteria cri);
	
	public List<TeacherVO> getUserTypeList(Criteria cri);
	
	public UserVO user_read(String user_id);	//사용자 마이페이지
	public boolean user_modify(UserVO vo);		//사용자 정보 수정
	public boolean user_delete(Long user_no);	//사용자 삭제
	
	public List<TeacherQuestionsVO> tqa_list(Long user_no);
	public TeacherQuestionsVO tqa_get(Long tqa_no);
}
