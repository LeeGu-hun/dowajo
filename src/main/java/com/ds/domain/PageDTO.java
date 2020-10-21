package com.ds.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class PageDTO {
	private int startPage, endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {		
		this.total = total;
		this.cri = cri;
		
		endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		startPage = endPage-9;
		int realEnd = (int)(Math.ceil(total*1.0/cri.getAmount()));
		
		endPage=(endPage>realEnd)?realEnd:endPage;
		
		
		prev = startPage >1;
		next = endPage < realEnd;
	}
}
