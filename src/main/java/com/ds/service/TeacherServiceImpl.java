package com.ds.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ds.domain.AuthVO;
import com.ds.domain.Criteria;
import com.ds.domain.LectureVO;
import com.ds.domain.QuestionsVO;
import com.ds.domain.SignupVO;
import com.ds.domain.TeacherQuestionsVO;
import com.ds.domain.TeacherVO;
import com.ds.domain.UserVO;
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
	public void register(LectureVO lecture) {
		log.info("regist.......");
		mapper.registlecture(lecture);
	}
	public void register_class_list(LectureVO lecture,Long user_no) {
		log.info("regist.......");
		mapper.register_class_list(lecture,user_no);
	}
	@Override
	public TeacherVO lecture_get(Long lecture_no) {
		log.info("lecture_modify......" );
		return mapper.lecture_get(lecture_no);
	}
	@Override
	public TeacherVO lecture_modify(TeacherVO vo) {
		log.info("lecture_modify......" );
		return mapper.lecture_modify(vo);
	}
	@Override
	public void lecture_modify_nochange_picture(TeacherVO vo) {
		log.info("lecture_modify_nochange_picture......" );
//		return 
		mapper.lecture_modify_nochange_picture(vo);
	}
	@Override
	public boolean remove(Long teacher_no) {
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
	public List<TeacherVO> cancel(Long lecture_no) {
		log.info("cancel......" );
		return mapper.read_cancel(lecture_no);
	}
	@Override
	public List<TeacherVO> sign_up(Long lecture_no) {
		log.info("sign_up......" ); 
		return mapper.read_sign_up(lecture_no);
	}
	@Override
	public List<TeacherVO> refresh(String[] checkArr,Long lecture_no) {
		SignupVO vo = new SignupVO();
		vo.setLecture_no(lecture_no);
		vo.setCheckArr(checkArr); 
		log.info("checkArr:::" + Arrays.toString(checkArr));
		int result = mapper.read_refresh(vo);
		log.info("refresh update::"+result);
		return mapper.read_cancel(lecture_no); 
	}
	@Override
	public void reject(String[] checkArr,Long lecture_no) {
		SignupVO vo = new SignupVO();
		vo.setLecture_no(lecture_no);
		vo.setCheckArr(checkArr); 
		log.info("checkArr:::" + Arrays.toString(checkArr));
		mapper.reject(vo);
	}
	@Override
	public List<TeacherVO> cancelrefresh(String[] checkArr,Long lecture_no) {
		SignupVO vo = new SignupVO();
		vo.setLecture_no(lecture_no);
		vo.setCheckArr(checkArr); 
		log.info("checkArr:::" + Arrays.toString(checkArr));
		int result = mapper.cancelrefresh(vo);
		log.info("refresh update::"+result);
		return mapper.read_sign_up(lecture_no); 
	}
	@Override
	public List<TeacherVO> regetlist_canecl(Long lecture_no) {
		log.info("getList..........");
		return mapper.regetlist_canecl(lecture_no);
	}
	@Override
	public List<TeacherVO> regetlist_sign_up(Long lecture_no) {
		log.info("getList..........");
		return mapper.regetlist_sign_up(lecture_no);
	}
	@Override
	public List<TeacherVO> getList(Long user_no) {
		log.info("getList..........");
		return mapper.getList(user_no);
	}
	@Override
	public List<TeacherVO> getUserTypeList(Criteria cri) {
		return mapper.getUserTypeList(cri);
	}
	@Override
	public List<TeacherVO> call_no(Long lecture_no) {
		log.info("call_no..........");
		return mapper.call_no(lecture_no);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	
	@Override
	public UserVO user_read(String user_id) {
		return mapper.user_read(user_id);				
	}

	@Override
	public boolean user_modify(UserVO vo) {		
		vo.setUser_pw(pwencoder.encode(vo.getUser_pw()));		//비밀번호 없으면 사용못함
		boolean modifyResult = mapper.user_update(vo) == 1;		
		return modifyResult;		
	}

	@Override
	public boolean user_delete(Long user_no) {
		System.out.println("서비스 impl_delete");
		return mapper.user_delete(user_no) == 1;
	}

	@Override
	public List<TeacherQuestionsVO> tqa_list(Long user_no) {
		return mapper.tqa_list(user_no);		
	}
	
	@Override
	public TeacherQuestionsVO tqa_get(Long tqa_no) {
		return mapper.tqa_get(tqa_no);
	}
	
	@Override
	public boolean tQnA_modify(TeacherQuestionsVO vo) {
		boolean modifyResult = mapper.tQnA_update(vo) == 1;		
		return modifyResult;
	}
	
}
