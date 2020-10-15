package com.ds.mapper;

import java.util.List;

import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;

public interface UserMapper {

	public UserVO checkLogin(String id);
	public List<LectureVO> lectureList(Long user_no);
	public List<LectureVO> lectureAllList();
	
}
