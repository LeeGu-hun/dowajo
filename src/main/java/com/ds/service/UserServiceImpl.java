package com.ds.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;
import com.ds.mapper.LectureMapper;
import com.ds.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService{

	private UserMapper mapper;

	@Override
	public List<LectureVO> lecutureList(Long user_no) {
		log.info("check service");
		return mapper.lecutureList(user_no);
	}
	

	

}