package domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Supermarket {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(length = 30)
	private String address;

	@Column(name = "director_fio", length = 30)
	private String directorFIO;

	@Column(name = "phone_number", length = 20)
	private String phone;

	private float income;

	private float costs;

	@ManyToOne
	@JoinColumn(name = "city_name")
	private City city = null;

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "supermarket_id")
	private List<Product> productsArray = new ArrayList<Product>();

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "supermarket_id")
	private List<Seller> sellersArray = new ArrayList<Seller>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDirectorFIO() {
		return directorFIO;
	}

	public void setDirectorFIO(String directorFIO) {
		this.directorFIO = directorFIO;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public float getIncome() {
		return income;
	}

	public void setIncome(float income) {
		this.income = income;
	}

	public float getCosts() {
		return costs;
	}

	public void setCosts(float costs) {
		this.costs = costs;
	}

	public City getCity() {
		return city;
	}

	public void setCity(City city) {
		this.city = city;
	}

	public List<Product> getProductsArray() {
		return productsArray;
	}

	public void setProductsArray(List<Product> productsArray) {
		this.productsArray = productsArray;
	}

	public List<Seller> getSellersArray() {
		return sellersArray;
	}

	public void setSellersArray(List<Seller> sellersArray) {
		this.sellersArray = sellersArray;
	}
	
	
}
