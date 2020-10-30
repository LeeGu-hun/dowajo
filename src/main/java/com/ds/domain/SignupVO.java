package com.ds.domain;

import java.util.List;

import lombok.Data;

@Data
public class SignupVO {
	int lecture_no;
	String[] checkArr;
	List<String> list;
}
