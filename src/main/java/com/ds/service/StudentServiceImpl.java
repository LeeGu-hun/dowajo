package com.ds.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.ds.domain.ClassListVO;
import com.ds.domain.Criteria;
import com.ds.domain.LectureVO;
import com.ds.domain.QuestionsVO;
import com.ds.domain.TeacherQuestionsVO;
import com.ds.domain.UserVO;
import com.ds.mapper.StudentMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class StudentServiceImpl implements StudentService{

	private StudentMapper mapper;
	@Setter(onMethod_ = {@Autowired})	
	private PasswordEncoder pwencoder;

	@Override
	public List<LectureVO> lectureList(Long user_no) {		
		return mapper.lectureList(user_no);
	}
	
	@Override
	public List<LectureVO> lectureAllList(Criteria cri){
		log.info("impl크리체크.........."+cri);
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
	
	
	@Override
	public void applyClass(ClassListVO vo) {
		mapper.applyClass(vo);
	}


	@Override
	public int applyDuplicated(Long user_no, Long lecture_no) {
		return mapper.applyDuplicated(user_no, lecture_no);
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
	public List<QuestionsVO> qa_list(Long user_no) {		
		return mapper.qa_list(user_no);
	}
	
	@Override
	public void qa_register(QuestionsVO vo) {
		mapper.qa_register(vo);
	}

	@Override
	public QuestionsVO qa_get(Long qa_no) {
		return mapper.qa_get(qa_no);
	}
	
	@Override
	public QuestionsVO main_read(int qa_no) {
		return mapper.main_read(qa_no);
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
	public void tqa_register(TeacherQuestionsVO vo) {
		mapper.tqa_register(vo);
	}
	
	@Override
	public List<String> getTeacherName(Long user_no){
		return mapper.getTeacherName(user_no);
	}

	@Override
	public boolean upHit(int qa_no) {
		 return mapper.upHit(qa_no);
	}
}