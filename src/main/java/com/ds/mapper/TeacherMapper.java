package com.ds.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ds.domain.AuthVO;
import com.ds.domain.Criteria;
import com.ds.domain.LectureVO;
import com.ds.domain.SignupVO;
import com.ds.domain.TeacherQuestionsVO;
import com.ds.domain.TeacherVO;
import com.ds.domain.UserVO;

public interface TeacherMapper {
	public String duplicateId(String id);
	public UserVO user_read(String user_id);	//사용자 정보보기
	public int user_update(UserVO vo);			//회원정보 업데이트
	public int user_delete(Long user_no);		//사용자 삭제
	
	public void registlecture(LectureVO lecture);
	public void register_class_list(@Param("lecture")LectureVO lecture,@Param("user_no")Long user_no);
	public boolean registAuth(AuthVO auth);
	public int updateAdmin(String id);
	public TeacherVO lecture_modify(TeacherVO vo);
	public TeacherVO lecture_get(Long lecture_no);
	public List<TeacherVO> getList(Long user_no);
	public List<TeacherVO> regetlist_canecl(Long lecture_no);
	public List<TeacherVO> regetlist_sign_up(Long lecture_no);
	public List<TeacherVO> call_no(Long lecture_no);
	public TeacherVO getUser(Long  lecture_no);
	public List<TeacherVO> getUserTypeList(Criteria cri);
	
	public void insert(TeacherVO vo);
	public void insertSelectKey(TeacherVO vo);
	public List<TeacherVO> read_cancel(Long lecture_no); 
	public List<TeacherVO> read_sign_up(Long lecture_no);
	public int read_refresh(SignupVO vo);
	public int cancelrefresh(SignupVO vo);
	public int delete(Long lecture_no);
	public int update(TeacherVO vo);
	
	public List<TeacherVO> getListWithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);
	
	public List<TeacherQuestionsVO> tqa_list(Long user_no);
	public TeacherQuestionsVO tqa_get(Long tqa_no);
}
