package com.ds.service;

import java.util.List;



import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ds.domain.ClassListVO;
import com.ds.domain.Criteria;
import com.ds.domain.LectureVO;
import com.ds.mapper.StudentMapper;

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
	public List<LectureVO> lectureAllList(Criteria cri){
		return mapper.lectureAllList(cri);		
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public List<LectureVO> lectureInfo(Long lecture_no){
		return mapper.lectureInfo(lecture_no);
	}
	
	@Override
	public List<LectureVO> lectureConfirmList(Long user_no){
		return mapper.lectureConfirmList(user_no);
	}
	
	@Transactional	
	@Override
	public void applyClass(ClassListVO vo) {
		Long user_no = vo.getUser_no();
		Long lecture_no = vo.getLecture_no();
		log.info("유저넘버 확인....."+user_no);
		log.info("렉쳐넘버 확인....."+lecture_no);
		int result = mapper.applyDuplicated(user_no, lecture_no);
		log.info("결과 확인......"+result);
		if(result !=0) {
			log.info("이미 신청한 강의입니다.");
			return;					
		} else { mapper.applyClass(vo);}
		 
	}


	@Override
	public int applyDuplicated(Long user_no, Long lecture_no) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	

}