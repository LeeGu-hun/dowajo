package com.ds.domain;

import java.util.List;

import lombok.Data;

@Data
public class SignupVO {
	Long lecture_no;
	Long user_no;
	String[] checkArr;
	List<String> list;
}
