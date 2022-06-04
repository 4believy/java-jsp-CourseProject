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
import domain.Supermarket;

@Path("supermarket")
public class SupermarketService {

	@GET
	@Path("getAllSupermarkets/city_name/{city_name}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Supermarket> getAllSupermarkets(@PathParam(value = "city_name") String cityName) {
		return HibernateDAOFactory.getInstance().getSupermarketDAO().getAllForCity(cityName);
	}

	@POST
	@Path("addSupermarket/address/{address}/cityName/{cityName}/costs/{costs}/directorFIO/{directorFIO}/income/{income}/phone/{phone}")
	public void addSupermarket(@PathParam("address") String address, @PathParam("cityName") String cityName,
			@PathParam("costs") String costs, @PathParam("directorFIO") String directorFIO,
			@PathParam("income") String income, @PathParam("phone") String phone) {
		Supermarket supermarket = new Supermarket();
		supermarket.setAddress(address);
		supermarket.setCity(HibernateDAOFactory.getInstance().getCityDAO().getCityById(cityName));
		float costsF = Float.parseFloat(costs);
		supermarket.setCosts(costsF);
		supermarket.setDirectorFIO(directorFIO);
		float incomeF = Float.parseFloat(income);
		supermarket.setIncome(incomeF);
		supermarket.setPhone(phone);
		HibernateDAOFactory.getInstance().getSupermarketDAO().createSupermarket(supermarket);
	}

	@DELETE
	@Path("deleteSupermarket/{supermarketid}")
	public void deleteSupermarket(@PathParam("supermarketid") String supermarketid) {
		Long supermarketId = Long.parseLong(supermarketid);
		HibernateDAOFactory.getInstance().getSupermarketDAO().deleteSupermarketById(supermarketId);
	}

	@PUT
	@Path("updateSupermarket/id/{supermarketid}/address/{address}/cityName/{cityName}/costs/{costs}/directorFIO/{directorFIO}/income/{income}/phone/{phone}")
	public void updateSupermarket(@PathParam("supermarketid") String supermarketid,
			@PathParam("address") String address, @PathParam("cityName") String cityName,
			@PathParam("costs") String costs, @PathParam("directorFIO") String directorFIO,
			@PathParam("income") String income, @PathParam("phone") String phone) {
		Long supermarketId = Long.parseLong(supermarketid);
		Supermarket supermarket = HibernateDAOFactory.getInstance().getSupermarketDAO()
				.getSupermarketById(supermarketId);
		supermarket.setAddress(address);
		supermarket.setCity(HibernateDAOFactory.getInstance().getCityDAO().getCityById(cityName));
		float costsF = Float.parseFloat(costs);
		supermarket.setCosts(costsF);
		supermarket.setDirectorFIO(directorFIO);
		float incomeF = Float.parseFloat(income);
		supermarket.setIncome(incomeF);
		supermarket.setPhone(phone);
		HibernateDAOFactory.getInstance().getSupermarketDAO().updateSupermarket(supermarket);
	}
}
