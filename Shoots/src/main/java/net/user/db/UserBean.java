package net.user.db;

public class UserBean {
	private String id;
	private String password;
	private String name;
	private String RRN;
	private String gender;
	private String tel;
	private String email;
	private String nickname;
	private String userfile;
	
	public String getRRN() {
		return RRN;
	}
	public void setRRN(String RRN1, String RRN2) {
		this.RRN = RRN1+"-"+RRN2;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUserfile() {
		return userfile;
	}
	public void setUserfile(String userfile) {
		this.userfile = userfile;
	}
}