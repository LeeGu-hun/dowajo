package com.ds.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ds.domain.LectureVO;
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
	public List<String> lectureUser(Long lecture_no) {
		
		return  mapper.lectureUser(lecture_no);
	}

	

}