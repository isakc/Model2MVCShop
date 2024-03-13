package com.model2.mvc.common;

public class Paginate {
	private int now;    	//현재페이지
	private int total;  	//전체 게시물 수
	private int numBlock;	//한 페이지에 보여질 페이징 블록의 갯수
	private int numPage;	//한 페이지당 보여질 게시물 갯수
	private int totalPage;  //전체 페이지 수
	private int nowBlock;   //현재 블록
	private int totalBlock; //총 페이지 블럭 갯수
	
	public Paginate(int now, int total, int numBlock, int numPage) {
		this.now = now;
		this.total = total;
		this.numBlock = numBlock;
		this.numPage = numPage;
		this.totalPage = (int)Math.ceil((double)total/numPage);
		this.nowBlock = (int)Math.ceil((double)now/numBlock);
		this.totalBlock = (int) Math.ceil((double) totalPage/numBlock);// 총 페이지 블럭 갯수
	}

	public int getNow() {
		return now;
	}

	public int getTotal() {
		return total;
	}

	public int getNumPage() {
		return numPage;
	}

	public int getNumBlock() {
		return numBlock;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getNowBlock() {
		return nowBlock;
	}

	public int getTotalBlock() {
		return totalBlock;
	}

	public void setNow(int now) {
		this.now = now;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public void setNumPage(int numPage) {
		this.numPage = numPage;
	}

	public void setNumBlock(int numBlock) {
		this.numBlock = numBlock;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public void setNowBlock(int nowBlock) {
		this.nowBlock = nowBlock;
	}

	public void setTotalBlock(int totalBlock) {
		this.totalBlock = totalBlock;
	}
	
	@Override
	public String toString() {
		return "현재페이지 now: " + this.getNow() + "\n전체 게시물 수 total: " + this.getTotal()+ "\n한 페이지당 보여질 게시물 개수 Numpage: " + this.getNumPage() 
		+ "\n한 페이지에 보여질 페이징 블록의 갯수 numBlock: " + this.getNumBlock() + "\n전체 페이지 수 totalPage: " + this.getTotalPage()+
				"\n현재 블록 nowblock: " +this.getNowBlock() + "\n총 페이지 블럭 갯수 totalBlock: " +this.getTotalBlock();
	}
}
