package net.user.db;

public class UserBean {
	private String id;
	private String password;
	private String name;
	private int RRN;
	private int gender;
	private String tel;
	private String email;
	private String nickname;
	private String userfile;
	
	public int getRRN() {
		return RRN;
	}
	public void setRRN(int rRN) {
		RRN = rRN;
	}
	public void setGender(int gender) {
		this.gender = gender;
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
	public int getGender() {
		return gender;
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