package com.ds.service;

import java.util.List;

import com.ds.domain.FileVO;
import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;

public interface LectureService {
	
	public LectureVO lectureInfo(Long lecture_no);
	public List<UserVO> lectureUser(Long lecture_no);
	
	public void fileState(boolean file_status, Long lecture_no);	
	public void fileSave(FileVO vo);
	public void fileDelete(String file_name);
	public List<FileVO> fileList(Long lecture_no, Long user_no);
	public void fileDeleteAll(Long lecture_no);
	public List<FileVO> fileListAll(Long lecture_no);

}