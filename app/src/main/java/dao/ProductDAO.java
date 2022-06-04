package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

import domain.Product;

public class ProductDAO {

	private Session session;

	public ProductDAO(Session session) {
		this.session = session;
	}

	/**
	 * This method create new entity
	 */
	public Product createProduct(Product product) {
		Transaction transaction = session.beginTransaction();
		session.saveOrUpdate(product);
		transaction.commit();
		return product;
	}

	/**
	 * This method update existing product
	 */
	public Product updateProduct(Product product) {
		Transaction transaction = session.beginTransaction();
		session.merge(product);
		transaction.commit();
		return product;
	}

	/**
	 * This method delete existing product
	 */
	public void deleteProduct(Product product) {
		Transaction transaction = session.beginTransaction();
		session.delete(product);
		transaction.commit();
	}

	/**
	 * This method remove entity by id
	 */
	public void deleteProductById(Long productId) {
		Product product = (Product) session.get(Product.class, productId);
		deleteProduct(product);
	}

	/**
	 * This method return all entities
	 */
	public List<Product> getAllProducts() {
		NativeQuery<Product> query = session.createNativeQuery("select * from Product", Product.class);
		List<Product> productList = query.list();
		return productList;
	}

	public Product getProductById(Long productId) {
		Product product = (Product) session.get(Product.class, productId);
		return product;
	}
	
	/**
	 * This method return all entities
	 */
	public List<Product> getAllForSupermarket(Long id) {
		Query<Product> query = session.createNativeQuery("select * from Product where supermarket_id = ?1",
				Product.class);
		query.setParameter(1, id);
		List<Product> productList = query.list();
		return productList;
	}
}
