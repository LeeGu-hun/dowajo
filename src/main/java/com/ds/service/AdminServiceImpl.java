package com.ds.service;

import java.util.ArrayList;
import java.util.List;

import com.ds.domain.AuthVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;
import com.ds.mapper.LectureMapper;
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
}