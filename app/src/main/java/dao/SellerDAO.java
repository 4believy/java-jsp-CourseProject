package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

import domain.Seller;

public class SellerDAO {

	private Session session;

	public SellerDAO(Session session) {
		this.session = session;
	}

	/**
	 * This method create new entity
	 */
	public Seller createSeller(Seller seller) {
		Transaction transaction = session.beginTransaction();
		session.saveOrUpdate(seller);
		transaction.commit();
		return seller;
	}

	/**
	 * This method update existing seller
	 */
	public Seller updateSeller(Seller seller) {
		Transaction transaction = session.beginTransaction();
		session.merge(seller);
		transaction.commit();
		return seller;
	}

	/**
	 * This method delete existing seller
	 */
	public void deleteSeller(Seller seller) {
		Transaction transaction = session.beginTransaction();
		session.delete(seller);
		transaction.commit();
	}

	/**
	 * This method remove entity by id
	 */
	public void deleteSellerById(Long sellerId) {
		Seller seller = (Seller) session.get(Seller.class, sellerId);
		deleteSeller(seller);
	}

	/**
	 * This method return all entities
	 */
	public List<Seller> getAllSellers() {
		NativeQuery<Seller> query = session.createNativeQuery("select * from Seller", Seller.class);
		List<Seller> sellerList = query.list();
		return sellerList;
	}

	public Seller getSellerById(Long sellerId) {
		Seller seller = (Seller) session.get(Seller.class, sellerId);
		return seller;
	}
	
	/**
	 * This method return all entities
	 */
	public List<Seller> getAllForSupermarket(Long id) {
		Query<Seller> query = session.createNativeQuery("select * from Seller where supermarket_id = ?1",
				Seller.class);
		query.setParameter(1, id);
		List<Seller> sellerList = query.list();
		return sellerList;
	}
}
