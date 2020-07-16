package com.team404.command;

import com.team404.util.Criteria;

import lombok.Data;

@Data
public class PageVO {
	//criteria를 받아서 화면에 보여질 버튼을 계산할 클래스
	private int startPage; //첫페이지번호
	private int endPage; //끝페이지 번호
	private boolean prev; //이전버튼
	private boolean next; //다음버튼
	
	private int pageNum; //현재 페이지번호
	private int amount; //보여질 데이터 갯수
	private int total; //총 게시글 수
	
	private Criteria cri; //게시글 검색 키워드를 저장

	//반드시 cri와 total을 전달
	public PageVO(Criteria cri, int total) {
		 this.pageNum = cri.getPageNum();
		 this.amount = cri.getAmount();
		 this.total = total;
		 this.cri = cri;
		 
		 //끝페이지 계산
		 //pageNum이 11을 가르킬 때 -> 20번이되어야함
		 //공식 -> (int)Math.ceil(조회페이지번호/보여질페이지수) * 보여질페이지수
		 this.endPage = (int)Math.ceil(this.pageNum / 10.0) * 10;
		 
		 //처음페이지
		 //공식 -> 끝페이지 - 보여질페이지수 + 1
		 this.startPage = endPage - 10 + 1;
		 
		 //실제 마지막 번호
		 //ex) 만약 총 게시물이 53개라면 realEnd는 6까지 처리
		 //ex) 만약 총 게시물이 112개라면 realEnd는 12까지 처리
		 //공식 -> (int)Math.ceil(총 게시글 수 / 화면에 보여질 데이터 수 (나누는 숫자가 int형이면 소수자리가 잘리기 때문에 double형으로 형변환));
		 int realEnd = (int)Math.ceil(this.total / (double)this.amount);
		 
		 if(this.endPage > realEnd) {
			 this.endPage = realEnd;
		 }
		 
		 //이전버튼 활성화여부
		 //시작버튼이 활성화되는 경우는 11번 페이지부터
		 this.prev = startPage > 1;
		 
		 //다음버튼 활성화여부
		 this.next = realEnd > this.endPage;
		 
		 
	}


}
