package com.ds.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ds.domain.AttendanceVO;
import com.ds.domain.FileVO;
import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;
import com.ds.mapper.LectureMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class LectureServiceImpl implements LectureService{

	private LectureMapper mapper;

	@Override
	public LectureVO lectureInfo(Long lecture_no) {

		return mapper.lectureInfo(lecture_no);
	}
	@Override
	public List<UserVO> lectureUser(Long lecture_no) {
		
		return  mapper.lectureUser(lecture_no);
	}
	
	
	
	@Override
	public void fileState(boolean file_status, Long lecture_no) {
		mapper.fileState(file_status, lecture_no);
		
	}
	@Override
	public void fileSave(FileVO vo) {
		mapper.fileSave(vo);
		
	}
	@Override
	public void fileDelete(String file_name) {
		mapper.fileDelete(file_name);
		
	}
	@Override
	public List<FileVO> fileList(Long lecture_no, Long user_no) {
		
		return mapper.fileList(lecture_no, user_no);
	}
	@Override
	public void fileDeleteAll(Long lecture_no) {
		mapper.fileDeleteAll(lecture_no);
		
	}
	@Override
	public List<FileVO> fileListAll(Long lecture_no) {
		
		return mapper.fileListAll(lecture_no);
	}
	
	
	
	@Override
	public void setAttend(AttendanceVO vo) {
		mapper.setAttend(vo);
		
	}
	@Override
	public List<AttendanceVO> viewAttend(Long lecture_no, String user_id) {
		
		return mapper.viewAttend(lecture_no, user_id);
	}
	
	
	
	
	

}