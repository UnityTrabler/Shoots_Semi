package net.comment.db;

public class CommentBean {
	private int comment_id;
	private int post_id;
	private int comment_ref_id;
	private int writer;
	private String content;
	private String register_date;
	private String user_id;
	private int idx;
	private String user_file;
	private String post_title;
	
	public String getPost_title() {
		return post_title;
	}
	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}
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
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUser_file() {
		return user_file;
	}
	public void setUser_file(String user_file) {
		this.user_file = user_file;
	}
	
	
	
}