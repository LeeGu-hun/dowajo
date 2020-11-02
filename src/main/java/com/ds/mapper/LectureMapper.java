package com.ds.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ds.domain.AttendanceVO;
import com.ds.domain.FileVO;
import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;

public interface LectureMapper {

	public LectureVO lectureInfo(Long lecture_no);
	public List<UserVO> lectureUser(Long lecture_no);
	
	public void fileState(@Param("file_status") boolean file_status, @Param("lecture_no") Long lecture_no);
	public void fileSave(FileVO vo);
	public void fileDelete(String file_name);
	public List<FileVO> fileList(@Param("lecture_no") Long lecture_no, @Param("user_no") Long user_no);
	public void fileDeleteAll(Long lecture_no);
	public List<FileVO> fileListAll(Long lecture_no);
	
	public void setAttend(AttendanceVO vo);
	public List<AttendanceVO> viewAttend(@Param("lecture_no") Long lecture_no, @Param("user_id") String user_id);
	
}
