package net.inquiry.db;

public class InquiryBean {
	private int inquiry_id;
	private String inquiry_type;
	private int inquiry_ref_idx;
	private String title;
	private String content;
	private String inquiry_file;
	private String register_date;
	public int getInquiry_id() {
		return inquiry_id;
	}
	public void setInquiry_id(int inquiry_id) {
		this.inquiry_id = inquiry_id;
	}
	public String getInquiry_type() {
		return inquiry_type;
	}
	public void setInquiry_type(String inquiry_type) {
		this.inquiry_type = inquiry_type;
	}
	public int getInquiry_ref_idx() {
		return inquiry_ref_idx;
	}
	public void setInquiry_ref_idx(int inquiry_ref_idx) {
		this.inquiry_ref_idx = inquiry_ref_idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getInquiry_file() {
		return inquiry_file;
	}
	public void setInquiry_file(String inquiry_file) {
		this.inquiry_file = inquiry_file;
	}
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	
}
