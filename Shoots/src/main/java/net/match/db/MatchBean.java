package net.match.db;

import java.util.List;

import net.user.db.UserBean;

public class MatchBean {
	private int match_id;
	private int writer;
	private String match_date;
	private String match_time;
	private int player_max;
	private int player_min;
	private String player_gender;
	private int price;
	private int register_date;
	private String business_name;
	private String address;
	private int playerCount;
	private int total;
	private String description;
	
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDescription() {
		return description;
	}
	private boolean isMatchPast;
	private List<UserBean> players;
	
	public List<UserBean> getPlayers() {
		return players;
	}
	public void setPlayers(List<UserBean> players) {
		this.players = players;
	}
	public boolean isMatchPast() {
		return isMatchPast;
	}
	public void setMatchPast(boolean isMatchPast) {
		this.isMatchPast = isMatchPast;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPlayerCount() {
		return playerCount;
	}
	public void setPlayerCount(int playerCount) {
		this.playerCount = playerCount;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getBusiness_name() {
		return business_name;
	}
	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}
	public int getMatch_id() {
		return match_id;
	}
	public void setMatch_id(int match_id) {
		this.match_id = match_id;
	}
	public int getWriter() {
		return writer;
	}
	public void setWriter(int writer) {
		this.writer = writer;
	}
	public String getMatch_date() {
		return match_date;
	}
	public void setMatch_date(String match_date) {
		this.match_date = match_date;
	}
	public String getMatch_time() {
		return match_time;
	}
	public void setMatch_time(String match_time) {
		this.match_time = match_time;
	}
	public int getPlayer_max() {
		return player_max;
	}
	public void setPlayer_max(int player_max) {
		this.player_max = player_max;
	}
	public int getPlayer_min() {
		return player_min;
	}
	public void setPlayer_min(int player_min) {
		this.player_min = player_min;
	}
	public String getPlayer_gender() {
		return player_gender;
	}
	public void setPlayer_gender(String player_gender) {
		this.player_gender = player_gender;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getRegister_date() {
		return register_date;
	}
	public void setRegister_date(int register_date) {
		this.register_date = register_date;
	}
	@Override
	public String toString() {
		return "MatchBean [match_id=" + match_id + ", writer=" + writer + ", match_date=" + match_date + ", match_time="
				+ match_time + ", player_max=" + player_max + ", player_min=" + player_min + ", player_gender="
				+ player_gender + ", price=" + price + ", register_date=" + register_date + ", business_name="
				+ business_name + ", address=" + address + ", playerCount=" + playerCount + ", total=" + total + "]";
	}
}