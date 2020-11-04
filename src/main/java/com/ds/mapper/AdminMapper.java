package com.ds.mapper;

import java.util.List;

import com.ds.domain.AuthVO;
import com.ds.domain.Criteria;
import com.ds.domain.QuestionsVO;
import com.ds.domain.UserVO;

public interface AdminMapper {
	
	//학생, 선생님 문의 사항
	public List<QuestionsVO> getQueList(Criteria cri);
	public int getTotalCount(Criteria cri);
	public void main_regist(QuestionsVO vo);
		
	//관리자 문의 사항
	public List<QuestionsVO> getQueList2(Criteria cri);
	public int getTotalCount2(Criteria cri);

	//관리자 등록
	public void admin_regist(UserVO vo);
	public void admin_registAuth(AuthVO auth);

	//선생님 등록
	public void teacher_regist(UserVO vo);
	public void teacher_registAuth(AuthVO auth);

	//아이디 중복 체크
	public String duplicateId(String user_id);

	//상세 보기
	public UserVO read(int user_no);
	public QuestionsVO main_read(int qa_no);

	//삭제
	public int delete(int user_id);
	public int main_delete(int qa_no);

	//학생, 교사, 관리자 전체 수
	public int getUserTypeTotal(Criteria cri);

	//학생, 교사, 관리자 전체 목록
	public List<UserVO> getUserTypeList(Criteria cri);
	
	public UserVO user_read(String user_id);	//사용자 정보보기
	public int user_update(UserVO vo);			//회원정보 업데이트
	public int user_delete(Long user_no);		//사용자 삭제
	
}
