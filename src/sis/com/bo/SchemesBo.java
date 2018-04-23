package sis.com.bo;

import java.io.Serializable;

public class SchemesBo implements Serializable{

	private int id;
	private String name;
	private String domain;
	
	public SchemesBo(){
		
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	
}
