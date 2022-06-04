package service;

import java.util.List;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import dao.HibernateDAOFactory;
import domain.Supplier;

@Path("supplier")
public class SupplierService {

	@GET
	@Path("getAllSuppliers/productid/{productid}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Supplier> getAllSuppliers(@PathParam(value = "productid") String id) {
		Long productID = Long.parseLong(id);
		return HibernateDAOFactory.getInstance().getSupplierDAO().getAllProductSuppliersOrderedByPrice(productID);
	}

	@POST
	@Path("addSupplier/address/{address}/mail/{mail}/name/{name}/phone/{phone}/price/{price}/productId/{productId}")
	public void addSupplier(@PathParam("address") String address, @PathParam("mail") String mail,
			@PathParam("name") String name, @PathParam("phone") String phone, @PathParam("price") String price,
			@PathParam("productId") String productId) {
		Supplier supplier = new Supplier();
		supplier.setAddress(address);
		supplier.setMail(mail);
		supplier.setName(name);
		supplier.setPhone(phone);
		float priceF = Float.parseFloat(price);
		supplier.setPrice(priceF);
		Long productIdL = Long.parseLong(productId);
		supplier.setProduct(HibernateDAOFactory.getInstance().getProductDAO().getProductById(productIdL));
		HibernateDAOFactory.getInstance().getSupplierDAO().createSupplier(supplier);
	}

	@DELETE
	@Path("deleteSupplier/{supplierid}")
	public void deleteSupplier(@PathParam("supplierid") String supplierid) {
		Long supplierId = Long.parseLong(supplierid);
		HibernateDAOFactory.getInstance().getSupplierDAO().deleteSupplierById(supplierId);
	}

	@PUT
	@Path("updateSupplier/id/{supplierid}/address/{address}/mail/{mail}/name/{name}/phone/{phone}/price/{price}/productId/{productId}")
	public void updateSupplier(@PathParam("supplierid") String supplierid, @PathParam("address") String address,
			@PathParam("mail") String mail, @PathParam("name") String name, @PathParam("phone") String phone,
			@PathParam("price") String price, @PathParam("productId") String productId) {
		Long supplierId = Long.parseLong(supplierid);
		Supplier supplier = HibernateDAOFactory.getInstance().getSupplierDAO().getSupplierById(supplierId);
		supplier.setAddress(address);
		supplier.setMail(mail);
		supplier.setName(name);
		supplier.setPhone(phone);
		float priceF = Float.parseFloat(price);
		supplier.setPrice(priceF);
		Long productIdL = Long.parseLong(productId);
		supplier.setProduct(HibernateDAOFactory.getInstance().getProductDAO().getProductById(productIdL));
		HibernateDAOFactory.getInstance().getSupplierDAO().updateSupplier(supplier);
	}
}
