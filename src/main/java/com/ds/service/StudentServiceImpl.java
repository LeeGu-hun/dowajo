package com.ds.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;
import com.ds.mapper.LectureMapper;
import com.ds.mapper.StudentMapper;
import com.ds.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class StudentServiceImpl implements StudentService{

	private StudentMapper mapper;

	@Override
	public List<LectureVO> lectureList(Long user_no) {		
		return mapper.lectureList(user_no);
	}
	
	@Override
	public List<LectureVO> lectureAllList(){
		return mapper.lectureAllList();		
	}
	

	

}