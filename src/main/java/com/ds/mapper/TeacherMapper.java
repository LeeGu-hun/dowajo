package com.ds.mapper;

import java.util.List;

import com.ds.domain.AuthVO;
import com.ds.domain.Criteria;
import com.ds.domain.SignupVO;
import com.ds.domain.TeacherVO;

public interface TeacherMapper {
	public String duplicateId(String id);
	
	public int registUser(TeacherVO vo);
	public boolean registAuth(AuthVO auth);
	public int updateAdmin(String id);
	public List<TeacherVO> getList();
	public List<TeacherVO> call_no(int lecture_no);
	public TeacherVO getUser(int  lecture_no);
	
	public void insert(TeacherVO vo);
	public void insertSelectKey(TeacherVO vo);
	public List<TeacherVO> read_cancel(int lecture_no); 
	public List<TeacherVO> read_sign_up(int lecture_no);
	public int read_refresh(SignupVO vo);
	public int cancelrefresh(SignupVO vo);
	public int delete(int lecture_no);
	public int update(TeacherVO vo);
	
	public List<TeacherVO> getListWithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);
}
