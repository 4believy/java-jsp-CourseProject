package dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import domain.City;
import domain.Product;
import domain.Seller;
import domain.Supermarket;
import domain.Supplier;

public class HibernateDAOFactory {

	private static HibernateDAOFactory instance;

	private ProductDAO productDAO;
	private CityDAO cityDAO;
	private SellerDAO sellerDAO;
	private SupermarketDAO supermarketDAO;
	private SupplierDAO supplierDAO;

	private Session session;

	// Ініціалізація синглетону
	public static HibernateDAOFactory getInstance() {
		if (null == instance) {
			instance = new HibernateDAOFactory();
		}
		return instance;
	}

	// Створення обєкта Session для взаємодії з Hibernate
	public Session getSession() {
		if (null == session) {
			Configuration configuration = new Configuration();
			configuration.setProperty(Environment.DRIVER, "org.postgresql.Driver");
			configuration.setProperty(Environment.URL, "jdbc:postgresql://localhost:5432/supermarket");
			configuration.setProperty(Environment.USER, "postgres");
			configuration.setProperty(Environment.PASS, "Anbabl31");
			configuration.setProperty(Environment.DIALECT, "org.hibernate.dialect.PostgreSQLDialect");
			configuration.setProperty(Environment.HBM2DDL_AUTO, "create");
			configuration.setProperty(Environment.SHOW_SQL, "true");
			configuration.addAnnotatedClass(Product.class);
			configuration.addAnnotatedClass(Seller.class);
			configuration.addAnnotatedClass(Supermarket.class);
			configuration.addAnnotatedClass(City.class);
			configuration.addAnnotatedClass(Supplier.class);
			StandardServiceRegistryBuilder serviceRegistryBuilder = new StandardServiceRegistryBuilder();
			serviceRegistryBuilder.applySettings(configuration.getProperties());
			ServiceRegistry serviceRegistry = serviceRegistryBuilder.build();
			SessionFactory sessionFactory = configuration.buildSessionFactory(serviceRegistry);
			session = sessionFactory.openSession();
		}
		return session;
	}

	public ProductDAO getProductDAO() {
		if (null == productDAO) {
			productDAO = new ProductDAO(getSession());
		}
		return productDAO;
	}

	public CityDAO getCityDAO() {
		if (null == cityDAO) {
			cityDAO = new CityDAO(getSession());
		}
		return cityDAO;
	}

	public SellerDAO getSellerDAO() {
		if (null == sellerDAO) {
			sellerDAO = new SellerDAO(getSession());
		}
		return sellerDAO;
	}
	
	public SupermarketDAO getSupermarketDAO() {
		if (null == supermarketDAO) {
			supermarketDAO = new SupermarketDAO(getSession());
		}
		return supermarketDAO;
	}
	
	public SupplierDAO getSupplierDAO() {
		if (null == supplierDAO) {
			supplierDAO = new SupplierDAO(getSession());
		}
		return supplierDAO;
	}

	public void closeSession() {
		getSession().close();
	}

}
