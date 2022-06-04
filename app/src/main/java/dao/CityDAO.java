package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

import domain.City;

public class CityDAO {

	private Session session;

	public CityDAO(Session session) {
		this.session = session;
	}

	/**
	 * This method create new entity
	 */
	public City createCity(City city) {
		Transaction transaction = session.beginTransaction();
		session.saveOrUpdate(city);
		transaction.commit();
		return city;
	}

	/**
	 * This method update existing city
	 */
	public City updateCity(City city) {
		Transaction transaction = session.beginTransaction();
		session.merge(city);
		transaction.commit();
		return city;
	}

	/**
	 * This method delete existing city
	 */
	public void deleteCity(City city) {
		Transaction transaction = session.beginTransaction();
		session.delete(city);
		transaction.commit();
	}

	/**
	 * This method remove entity by id
	 */
	public void deleteCityById(String cityName) {
		City city = (City) session.get(City.class, cityName);
		deleteCity(city);
	}

	/**
	 * This method return all entities
	 */
	public List<City> getAllCitys() {
		NativeQuery<City> query = session.createNativeQuery("select * from City", City.class);
		List<City> cityList = query.list();
		return cityList;
	}

	public City getCityById(String cityName) {
		City city = (City) session.get(City.class, cityName);
		return city;
	}
}
