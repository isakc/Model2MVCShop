package com.model2.mvc.common;

public class Paginate {
	private int now;    	//����������
	private int total;  	//��ü �Խù� ��
	private int numBlock;	//�� �������� ������ ����¡ ����� ����
	private int numPage;	//�� �������� ������ �Խù� ����
	private int totalPage;  //��ü ������ ��
	private int nowBlock;   //���� ���
	private int totalBlock; //�� ������ �� ����
	
	public Paginate(int now, int total, int numBlock, int numPage) {
		this.now = now;
		this.total = total;
		this.numBlock = numBlock;
		this.numPage = numPage;
		this.totalPage = (int)Math.ceil((double)total/numPage);
		this.nowBlock = (int)Math.ceil((double)now/numBlock);
		this.totalBlock = (int) Math.ceil((double) totalPage/numBlock);// �� ������ �� ����
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
		return "���������� now: " + this.getNow() + "\n��ü �Խù� �� total: " + this.getTotal()+ "\n�� �������� ������ �Խù� ���� Numpage: " + this.getNumPage() 
		+ "\n�� �������� ������ ����¡ ����� ���� numBlock: " + this.getNumBlock() + "\n��ü ������ �� totalPage: " + this.getTotalPage()+
				"\n���� ��� nowblock: " +this.getNowBlock() + "\n�� ������ �� ���� totalBlock: " +this.getTotalBlock();
	}
}
