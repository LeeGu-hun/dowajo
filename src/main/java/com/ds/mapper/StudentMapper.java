package com.ds.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ds.domain.ClassListVO;
import com.ds.domain.Criteria;
import com.ds.domain.LectureVO;

public interface StudentMapper {
	public List<LectureVO> lectureList(Long user_no);
	public List<LectureVO> lectureConfirmList(Long user_no);
	public List<LectureVO> lectureAllList(Criteria cri);
	public List<LectureVO> lectureInfo(Long lecture_no);
	
	public int getTotalCount(Criteria cri);	
	
	public void applyClass(ClassListVO vo);
	
	public int applyDuplicated(@Param("user_no")Long user_no, @Param("lecture_no")Long lecture_no);	
	

}
