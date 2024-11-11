package net.inquiryComment.db;

public class InquiryCommentBean {
	private int i_comment_id;
	private int inquiry_id;
	private int writer;
	private String content;
	private String register_date;
	private String user_id;
	private String business_name;
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getBusiness_name() {
		return business_name;
	}
	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}
	public int getI_comment_id() {
		return i_comment_id;
	}
	public void setI_comment_id(int i_comment_id) {
		this.i_comment_id = i_comment_id;
	}
	public int getInquiry_id() {
		return inquiry_id;
	}
	public void setInquiry_id(int inquiry_id) {
		this.inquiry_id = inquiry_id;
	}
	public int getWriter() {
		return writer;
	}
	public void setWriter(int writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	
	
}
