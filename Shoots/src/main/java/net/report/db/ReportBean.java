package net.report.db;

public class ReportBean {

	private int report_id;
	private String report_type;
	private int report_ref_id;
	private int reporter;
	private int target;
	private String title;
	private String content;
	private String report_file;
	private String register_date;
	private int post_id;
	private int match_id;
	private String reporter_name;
	private String target_name;
	
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public int getMatch_id() {
		return match_id;
	}
	public void setMatch_id(int match_id) {
		this.match_id = match_id;
	}
	public int getReport_id() {
		return report_id;
	}
	public void setReport_id(int report_id) {
		this.report_id = report_id;
	}
	public String getReport_type() {
		return report_type;
	}
	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}
	public int getReport_ref_id() {
		return report_ref_id;
	}
	public void setReport_ref_id(int report_ref_id) {
		this.report_ref_id = report_ref_id;
	}
	public int getReporter() {
		return reporter;
	}
	public void setReporter(int reporter) {
		this.reporter = reporter;
	}
	public int getTarget() {
		return target;
	}
	public void setTarget(int target) {
		this.target = target;
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
	public String getReport_file() {
		return report_file;
	}
	public void setReport_file(String report_file) {
		this.report_file = report_file;
	}
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	public String getReporter_name() {
		return reporter_name;
	}
	public void setReporter_name(String reporter_name) {
		this.reporter_name = reporter_name;
	}
	public String getTarget_name() {
		return target_name;
	}
	public void setTarget_name(String target_name) {
		this.target_name = target_name;
	}
	
	
}
