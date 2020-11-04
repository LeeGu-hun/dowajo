package com.ds.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ds.domain.ClassListVO;
import com.ds.domain.Criteria;
import com.ds.domain.LectureVO;
import com.ds.domain.QuestionsVO;
import com.ds.domain.UserVO;

public interface StudentMapper {
	public List<LectureVO> lectureList(Long user_no);
	public List<LectureVO> lectureConfirmList(Long user_no);
	public List<LectureVO> lectureAllList(Criteria cri);
	public List<LectureVO> lectureInfo(Long lecture_no);
	
	public int getTotalCount(Criteria cri);	
	
	public void applyClass(ClassListVO vo);
	
	public int applyDuplicated(@Param("user_no")Long user_no, @Param("lecture_no")Long lecture_no);
	
	//사용자 정보보기
	public UserVO user_read(String user_id);
	//회원정보 업데이트
	public int user_update(UserVO vo);
	//사용자 삭제
	public int user_delete(Long user_no);
	//내 질문 리스트
	public List<QuestionsVO> qa_list(Long user_no);	
	

}
