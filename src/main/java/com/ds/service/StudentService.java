package com.ds.service;

import java.util.List;

import com.ds.domain.ClassListVO;
import com.ds.domain.Criteria;

import com.ds.domain.LectureVO;
import com.ds.domain.QuestionsVO;
import com.ds.domain.UserVO;
	
public interface StudentService {
	
	public List<LectureVO> lectureList(Long user_no);
	public List<LectureVO> lectureConfirmList(Long user_no);
	public List<LectureVO> lectureAllList(Criteria cri);
	public List<LectureVO> lectureInfo(Long lecture_no);
	
	public int getTotal(Criteria cri);
	
	public void applyClass(ClassListVO vo);

	public int applyDuplicated(Long user_no, Long lecture_no);	

	public UserVO user_read(String user_id);	//사용자 마이페이지
	public boolean user_modify(UserVO vo);		//사용자 정보 수정
	public boolean user_delete(Long user_no);	//사용자 삭제
	public List<QuestionsVO> qa_list(Long user_no);
	public List<QuestionsVO> qa_register(QuestionsVO vo);
}