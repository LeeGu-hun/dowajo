package com.ds.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class Criteria {
	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	private String user_auth;
	private Long user_no;
	private String user_name;

	public Criteria() {
		this(1, 10);
	}

	public Criteria(int pageNum, int amount) {		
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {}:type.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
		.queryParam("user_auth", this.user_auth)
		.queryParam("user_name", this.user_name)
		.queryParam("pageNum", this.pageNum)
		.queryParam("amount", this.amount)
		.queryParam("type", this.type)
		.queryParam("keyword", this.keyword);
	return builder.toUriString();
		
	}
}