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
import domain.City;

@Path("city")
public class CityService {

	@GET
	@Path("getAllCitys")
	@Produces(MediaType.APPLICATION_JSON)
	public List<City> getAllCitys() {
		return HibernateDAOFactory.getInstance().getCityDAO().getAllCitys();
	}

	@POST
	@Path("addCity/name/{cityname}/postcode/{postcode}/population/{population}")
	public void addCity(@PathParam("cityname") String cityName, @PathParam("postcode") String postcode,
			@PathParam("population") String population) {
		City city = new City();
		city.setCityName(cityName);
		city.setPostcode(postcode);
		int popul = Integer.parseInt(population);
		city.setPopulation(popul);
		HibernateDAOFactory.getInstance().getCityDAO().createCity(city);
	}

	@DELETE
	@Path("deleteCity/{cityid}")
	public void deleteCity(@PathParam("cityid") String cityid) {
		HibernateDAOFactory.getInstance().getCityDAO().deleteCityById(cityid);
	}

	@PUT
	@Path("updateCity/name/{cityname}/postcode/{postcode}/population/{population}")
	public void updateCity(@PathParam("cityname") String cityname, @PathParam("postcode") String postcode,
			@PathParam("population") String population) {
		City city = HibernateDAOFactory.getInstance().getCityDAO().getCityById(cityname);
		city.setPostcode(postcode);
		int popul = Integer.parseInt(population);
		city.setPopulation(popul);
		HibernateDAOFactory.getInstance().getCityDAO().updateCity(city);
	}
}
