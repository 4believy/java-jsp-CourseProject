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

import business_logic.SendEmail;
import dao.HibernateDAOFactory;
import domain.Product;

@Path("product")
public class ProductService {

	@GET
	@Path("getAllProducts/supermarket_id/{supermarket_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Product> getAllProducts(@PathParam(value = "supermarket_id") String id) {
		Long supermarketId = Long.parseLong(id);
		return HibernateDAOFactory.getInstance().getProductDAO().getAllForSupermarket(supermarketId);
	}

	@POST
	@Path("addProduct/description/{description}/name/{name}/remnant/{remnant}/supermarketId/{supermarketId}")
	public void addProduct(@PathParam("description") String description, @PathParam("expDate") String expDate,
			@PathParam("name") String name, @PathParam("remnant") String remnant,
			@PathParam("supermarketId") String supermarketId) {
		Product product = new Product();
		product.setDescription(description);
		product.setName(name);
		int remnantI = Integer.parseInt(remnant);
		product.setRemnant(remnantI);
		Long supermarketIdL = Long.parseLong(supermarketId);
		product.setSupermarket(
				HibernateDAOFactory.getInstance().getSupermarketDAO().getSupermarketById(supermarketIdL));
		HibernateDAOFactory.getInstance().getProductDAO().createProduct(product);
	}

	@DELETE
	@Path("deleteProduct/{productid}")
	public void deleteProduct(@PathParam("productid") String productid) {
		Long productId = Long.parseLong(productid);
		HibernateDAOFactory.getInstance().getProductDAO().deleteProductById(productId);
	}

	@PUT
	@Path("updateProduct/id/{productid}/description/{description}/name/{name}/remnant/{remnant}/supermarketId/{supermarketId}")
	public void updateProduct(@PathParam("productid") String productid, @PathParam("description") String description,
			@PathParam("expDate") String expDate, @PathParam("name") String name, @PathParam("remnant") String remnant,
			@PathParam("supermarketId") String supermarketId) {
		Long productId = Long.parseLong(productid);
		Product product = HibernateDAOFactory.getInstance().getProductDAO().getProductById(productId);
		product.setDescription(description);
		product.setName(name);
		int remnantI = Integer.parseInt(remnant);
		product.setRemnant(remnantI);
		if(remnantI < 30) {
			String email = HibernateDAOFactory.getInstance().getSupplierDAO().getMailOfTheLowestPriceSupplier(productId);
			SendEmail.sendEmail(email, name);
		}
		Long supermarketIdL = Long.parseLong(supermarketId);
		product.setSupermarket(
				HibernateDAOFactory.getInstance().getSupermarketDAO().getSupermarketById(supermarketIdL));
		HibernateDAOFactory.getInstance().getProductDAO().updateProduct(product);
	}
}
