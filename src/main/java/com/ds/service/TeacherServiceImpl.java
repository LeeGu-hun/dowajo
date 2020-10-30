package com.ds.service;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ds.domain.Criteria;
import com.ds.domain.SignupVO;
import com.ds.domain.TeacherVO;
import com.ds.mapper.TeacherMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class TeacherServiceImpl implements TeacherService{
	
	@Setter(onMethod_ = {@Autowired})
	private TeacherMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Override
	public String duplicateId(String id) {
		log.info("service duplicateId : " + id);
		id = mapper.duplicateId(id);
		log.info("service mapper.duplicateId : " + id);
		return id;
	}

	@Transactional
	@Override
	public void regist(TeacherVO vo) {
		log.info("registerPost.......");
	}

	@Override
	public boolean remove(int teacher_no) {
		log.info("remove...." + teacher_no);
		return mapper.delete(teacher_no) == 1;
	}

	@Override
	public boolean modify(TeacherVO vo) {
		log.info("modify......" + vo);
		boolean modifyResult = mapper.update(vo) == 1;
		return modifyResult;
	}

	@Override
	public List<TeacherVO> cancel(int lecture_no) {
		log.info("cancel......" );
		return mapper.read_cancel(lecture_no);
	}
	@Override
	public List<TeacherVO> sign_up(int lecture_no) {
		log.info("sign_up......" ); 
		return mapper.read_sign_up(lecture_no);
	}
	@Override
	public List<TeacherVO> refresh(String[] checkArr,int lecture_no) {
		SignupVO vo = new SignupVO();
		vo.setLecture_no(lecture_no);
		vo.setCheckArr(checkArr); 
		log.info("checkArr:::" + Arrays.toString(checkArr));
		int result = mapper.read_refresh(vo);
		log.info("refresh update::"+result);
		return mapper.read_cancel(lecture_no); 
	}
	@Override
	public List<TeacherVO> cancelrefresh(String[] checkArr,int lecture_no) {
		SignupVO vo = new SignupVO();
		vo.setLecture_no(lecture_no);
		vo.setCheckArr(checkArr); 
		log.info("checkArr:::" + Arrays.toString(checkArr));
		int result = mapper.cancelrefresh(vo);
		log.info("refresh update::"+result);
		return mapper.read_sign_up(lecture_no); 
	}

	@Override
	public List<TeacherVO> getList() {
		log.info("getList..........");
		return mapper.getList();
	}
	@Override
	public List<TeacherVO> call_no(int lecture_no) {
		log.info("call_no..........");
		return mapper.call_no(lecture_no);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<TeacherVO> getList(Criteria cri) {
		log.info("getList: "+cri);
		
		return mapper.getListWithPaging(cri);
	}
	
}
