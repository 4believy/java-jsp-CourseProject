package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

import domain.Supermarket;

public class SupermarketDAO {

	private Session session;

	public SupermarketDAO(Session session) {
		this.session = session;
	}

	/**
	 * This method create new entity
	 */
	public Supermarket createSupermarket(Supermarket supermarket) {
		Transaction transaction = session.beginTransaction();
		session.saveOrUpdate(supermarket);
		transaction.commit();
		return supermarket;
	}

	/**
	 * This method update existing supermarket
	 */
	public Supermarket updateSupermarket(Supermarket supermarket) {
		Transaction transaction = session.beginTransaction();
		session.merge(supermarket);
		transaction.commit();
		return supermarket;
	}

	/**
	 * This method delete existing supermarket
	 */
	public void deleteSupermarket(Supermarket supermarket) {
		Transaction transaction = session.beginTransaction();
		session.delete(supermarket);
		transaction.commit();
	}

	/**
	 * This method remove entity by id
	 */
	public void deleteSupermarketById(Long supermarketId) {
		Supermarket supermarket = (Supermarket) session.get(Supermarket.class, supermarketId);
		deleteSupermarket(supermarket);
	}

	/**
	 * This method return all entities
	 */
	public List<Supermarket> getAllSupermarkets() {
		NativeQuery<Supermarket> query = session.createNativeQuery("select * from Supermarket", Supermarket.class);
		List<Supermarket> supermarketList = query.list();
		return supermarketList;
	}

	/**
	 * This method return all entities
	 */
	public List<Supermarket> getAllForCity(String cityName) {
		Query<Supermarket> query = session.createNativeQuery("select * from Supermarket where city_name = ?1",
				Supermarket.class);
		query.setParameter(1, cityName);
		List<Supermarket> supermarketList = query.list();
		return supermarketList;
	}

	public Supermarket getSupermarketById(Long supermarketId) {
		Supermarket supermarket = (Supermarket) session.get(Supermarket.class, supermarketId);
		return supermarket;
	}
}
