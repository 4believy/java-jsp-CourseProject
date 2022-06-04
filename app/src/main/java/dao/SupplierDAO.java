package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

import domain.Supplier;

public class SupplierDAO {

	private Session session;

	public SupplierDAO(Session session) {
		this.session = session;
	}

	/**
	 * This method create new entity
	 */
	public Supplier createSupplier(Supplier supplier) {
		Transaction transaction = session.beginTransaction();
		session.saveOrUpdate(supplier);
		transaction.commit();
		return supplier;
	}

	/**
	 * This method update existing supplier
	 */
	public Supplier updateSupplier(Supplier supplier) {
		Transaction transaction = session.beginTransaction();
		session.merge(supplier);
		transaction.commit();
		return supplier;
	}

	/**
	 * This method delete existing supplier
	 */
	public void deleteSupplier(Supplier supplier) {
		Transaction transaction = session.beginTransaction();
		session.delete(supplier);
		transaction.commit();
	}

	/**
	 * This method remove entity by id
	 */
	public void deleteSupplierById(Long supplierId) {
		Supplier supplier = (Supplier) session.get(Supplier.class, supplierId);
		deleteSupplier(supplier);
	}

	/**
	 * This method return all entities
	 */
	public List<Supplier> getAllSuppliers() {
		NativeQuery<Supplier> query = session.createNativeQuery("select * from Supplier", Supplier.class);
		List<Supplier> supplierList = query.list();
		return supplierList;
	}
	
	/**
	 * This method return all entities
	 */
	public List<Supplier> getAllProductSuppliersOrderedByPrice(Long productID) {
		NativeQuery<Supplier> query = session.createNativeQuery("select * from Supplier where product_id=?1 order by price", Supplier.class);
		query.setParameter(1, productID);
		List<Supplier> supplierList = query.list();
		return supplierList;
	}
	
	/**
	 * This method return all entities
	 */
	public String getMailOfTheLowestPriceSupplier(Long productID) {
		NativeQuery<Supplier> query = session.createNativeQuery("select * from Supplier where product_id=?1 order by price limit 1", Supplier.class);
		query.setParameter(1, productID);
		String mail = query.list().get(0).getMail();
		return mail;
	}

	public Supplier getSupplierById(Long supplierId) {
		Supplier supplier = (Supplier) session.get(Supplier.class, supplierId);
		return supplier;
	}
}
