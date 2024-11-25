package net.post.db;

public class PostBean {
	private int post_id;
	private int writer;
	private String category;
	private String title;
	private String content;
	private String post_file;
	private int price;
	private String register_date;
	private int readcount;
	private String user_id;
	private int idx;
	private int comment_id;
	private int comment_ref_id;
	private int commentCount;  // 댓글 수 추가
	private String user_file;
	
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public int getWriter() {
		return writer;
	}
	public void setWriter(int writer) {
		this.writer = writer;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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
	public String getPost_file() {
		return post_file;
	}
	public void setPost_file(String post_file) {
		this.post_file = post_file;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
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
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public int getComment_ref_id() {
		return comment_ref_id;
	}
	public void setComment_ref_id(int comment_ref_id) {
		this.comment_ref_id = comment_ref_id;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public String getUser_file() {
		return user_file;
	}
	public void setUser_file(String user_file) {
		this.user_file = user_file;
	}
	
	
}
