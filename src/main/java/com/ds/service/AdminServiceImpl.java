package com.ds.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.ds.domain.AuthVO;
import com.ds.domain.Criteria;
import com.ds.domain.QuestionsVO;
import com.ds.domain.UserVO;
import com.ds.mapper.AdminMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService{

	@Setter(onMethod_ = {@Autowired})
	private AdminMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;

	@Override
	public void admin_regist(UserVO vo) {
		vo.setUser_pw(pwencoder.encode(vo.getUser_pw()));
		List<AuthVO> list = new ArrayList<AuthVO>();
		list.add(new AuthVO("ROLE_ADMIN"));
		vo.setAuthList(list);
		
		mapper.admin_regist(vo);
		log.info("+여기까지됌+"+vo.getAuthList());
		vo.getAuthList().forEach(auth ->{
			log.info("+++"+vo.getUser_no());
			auth.setUser_no(String.valueOf(vo.getUser_no()));
			log.info("+AUTH확인+"+auth);
			mapper.admin_registAuth(auth);
		});
	}

	@Override
	public void teacher_regist(UserVO vo) {
		vo.setUser_pw(pwencoder.encode(vo.getUser_pw()));
		List<AuthVO> list = new ArrayList<AuthVO>();
		list.add(new AuthVO("ROLE_TEACHER"));
		vo.setAuthList(list);
		mapper.teacher_regist(vo);
		vo.getAuthList().forEach(auth ->{
			auth.setUser_no(String.valueOf(vo.getUser_no()));
			mapper.teacher_registAuth(auth);
		});
		
	}

	@Override
	public String duplicateId(String user_id) {
		return mapper.duplicateId(user_id);
	}

	@Override
	public List<QuestionsVO> getList(Criteria cri) {
		return mapper.getQueList(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}



	@Override
	public UserVO get(int user_no) {
		return mapper.read(user_no);
	}

	@Override
	public boolean remove(int user_no) {
		return mapper.delete(user_no) == 1;
	}
	
	@Override
	public int getUserTypeTotal(Criteria cri) {
		return mapper.getUserTypeTotal(cri);
	}

	@Override
	public List<UserVO> getUserTypeList(Criteria cri) {
		return mapper.getUserTypeList(cri);
	}

	@Override
	public List<QuestionsVO> getList2(Criteria cri) {
		return mapper.getQueList2(cri);
	}

	@Override
	public int getTotal2(Criteria cri) {
		return mapper.getTotalCount2(cri);
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
	public void main_regist(QuestionsVO vo) {
		mapper.main_regist(vo);
		
	}

	@Override
	public QuestionsVO main_get(int qa_no) {
		return mapper.main_read(qa_no);
	}

	@Override
	public boolean main_remove(int qa_no) {
		return mapper.main_delete(qa_no) == 1;
	}

}