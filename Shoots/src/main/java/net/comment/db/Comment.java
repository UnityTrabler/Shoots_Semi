package net.comment.db;

public class Comment {
	private int comment_id;
	private int post_id;
	private int comment_ref_id;
	private int writer;
	private String content;
	private String register_date;
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public int getComment_ref_id() {
		return comment_ref_id;
	}
	public void setComment_ref_id(int comment_ref_id) {
		this.comment_ref_id = comment_ref_id;
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