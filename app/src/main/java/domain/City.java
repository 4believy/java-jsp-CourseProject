package domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class City {
	
	@Id
	@Column(name = "city_name")
	private String cityName;
	
	@Column(length = 20)
	private String postcode;

	private int population;
	
	@OneToMany(mappedBy = "city",cascade = CascadeType.ALL)
	private List<Supermarket> supermarketsArray = new ArrayList<Supermarket>();

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public int getPopulation() {
		return population;
	}

	public void setPopulation(int population) {
		this.population = population;
	}

	public List<Supermarket> getSupermarketsArray() {
		return supermarketsArray;
	}

	public void setSupermarketsArray(List<Supermarket> supermarketsArray) {
		this.supermarketsArray = supermarketsArray;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	
}
