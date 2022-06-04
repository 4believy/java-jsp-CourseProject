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
import domain.Seller;

@Path("seller")
public class SellerService {

	@GET
	@Path("getAllSellers/supermarket_id/{supermarket_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Seller> getAllSellers(@PathParam(value = "supermarket_id") String id) {
		Long supermarketId = Long.parseLong(id);
		return HibernateDAOFactory.getInstance().getSellerDAO().getAllForSupermarket(supermarketId);
	}

	@POST
	@Path("addSeller/cashierNumber/{cashierNumber}/supermarketId/{supermarketId}/fio/{fio}/phone/{phone}/salary/{salary}/workExp/{workExp}")
	public void addSeller(@PathParam("cashierNumber") String cashierNumber, @PathParam("fio") String fio,
			@PathParam("phone") String phone, @PathParam("salary") String salary, @PathParam("workExp") String workExp,
			@PathParam("supermarketId") String supermarketId) {
		Seller seller = new Seller();
		int cashierNumberI = Integer.parseInt(cashierNumber);
		seller.setCashierNumber(cashierNumberI);
		seller.setFio(fio);
		seller.setPhone(phone);
		float salaryF = Float.parseFloat(salary);
		seller.setSalary(salaryF);
		int workExpI = Integer.parseInt(workExp);
		seller.setWorkExp(workExpI);
		Long supermarketIdL = Long.parseLong(supermarketId);
		seller.setSupermarket(HibernateDAOFactory.getInstance().getSupermarketDAO().getSupermarketById(supermarketIdL));
		HibernateDAOFactory.getInstance().getSellerDAO().createSeller(seller);
	}

	@DELETE
	@Path("deleteSeller/{sellerid}")
	public void deleteSeller(@PathParam("sellerid") String sellerid) {
		Long sellerId = Long.parseLong(sellerid);
		HibernateDAOFactory.getInstance().getSellerDAO().deleteSellerById(sellerId);
	}

	@PUT
	@Path("updateSeller/id/{sellerid}/cashierNumber/{cashierNumber}/supermarketId/{supermarketId}/fio/{fio}/phone/{phone}/salary/{salary}/workExp/{workExp}")
	public void updateSeller(@PathParam("sellerid") String sellerid, @PathParam("cashierNumber") String cashierNumber,
			@PathParam("fio") String fio, @PathParam("phone") String phone, @PathParam("salary") String salary,
			@PathParam("workExp") String workExp, @PathParam("supermarketId") String supermarketId) {
		Long sellerId = Long.parseLong(sellerid);
		Seller seller = HibernateDAOFactory.getInstance().getSellerDAO().getSellerById(sellerId);
		int cashierNumberI = Integer.parseInt(cashierNumber);
		seller.setCashierNumber(cashierNumberI);
		seller.setFio(fio);
		seller.setPhone(phone);
		float salaryF = Float.parseFloat(salary);
		seller.setSalary(salaryF);
		int workExpI = Integer.parseInt(workExp);
		seller.setWorkExp(workExpI);
		Long supermarketIdL = Long.parseLong(supermarketId);
		seller.setSupermarket(HibernateDAOFactory.getInstance().getSupermarketDAO().getSupermarketById(supermarketIdL));
		HibernateDAOFactory.getInstance().getSellerDAO().updateSeller(seller);
	}
}
