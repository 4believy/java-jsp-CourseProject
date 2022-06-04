<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cities page</title>
<link rel="stylesheet" href="styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
  jQuery( document ).ready(function() {
    //Send ajax request for show city list
    jQuery.ajax({
      url: 'rest/city/getAllCitys',
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        jQuery('#headerrow').after(createDataRowsFromJson(data));
      }
    });
    jQuery( "#addcity").click(function() {
      var url = 'rest/city/addCity/name/' +
        jQuery("#cityname").val() + '/postcode/' +
        jQuery("#postcode").val() + '/population/' +
        jQuery("#population").val();
      //Send ajax request for adding new city
      jQuery.ajax({
        url: url,
        dataType: 'json',
        type: 'POST',
        success: function(data) {
          //Send ajax request for refresh city list after adding city
          jQuery.ajax({
            url: 'rest/city/getAllCitys',
            dataType: 'json',
            type: 'GET',
            success: function(data) {
              jQuery('.datarow').remove();
              jQuery('#headerrow').after(createDataRowsFromJson(data));
              jQuery("#cityname").val('');
              jQuery("#postcode").val('');
              jQuery("#population").val('');
            }
          });
        }
      });
    });
  });

  function createDataRowsFromJson(data) {
    var tableContent = "";
    for (var key in data) {
      if (data.hasOwnProperty(key)) {
        tableContent = tableContent + "<tr class='datarow'>";
        tableContent = tableContent + "<td>";
        tableContent = tableContent + data[key].cityName;
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "<td>";
        tableContent = tableContent + data[key].postcode;
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "<td>";
        tableContent = tableContent + data[key].population;
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "<td>";
        tableContent = tableContent + "<a href='supermarket.jsp?cityname=" + data[key].cityName + "'>Список супермаркетів</a>";
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "<td>";
        tableContent = tableContent + "<input type='button' onclick='deleteCity(\"" + data[key].cityName + "\")'value='Видалити'/>";
        tableContent = tableContent + "<input type='button' onclick='editCity(this)' value='Редагувати'/>";
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "</tr>";
      }
    }
    return tableContent;
  }

  function deleteCity(cityName) {
    var url = 'rest/city/deleteCity/' + cityName;
    //Send ajax request for deleting city
    jQuery.ajax({
      url: url,
      dataType: 'json',
      type: 'DELETE',
      success: function(data) {
        jQuery.ajax({
          url: 'rest/city/getAllCitys',
          dataType: 'json',
          type: 'GET',
          success: function(data) {
            jQuery('.datarow').remove();
            jQuery('#headerrow').after(createDataRowsFromJson(data));
          }
        });
      }
    });
  }

  function editCity(button) {
	    jQuery(button).closest('tr').children().each(function(index, value){
	      if(index != 4 && index != 0 && index != 3){
	        jQuery(this).html("<input type='text' value='" +
	          jQuery(this).text() + "'/>");
	      } else if (index == 4){
	        var actionHtml = "<input type='button' onclick='applyEditCity(this)' value='Оновити'/>"
	        actionHtml = actionHtml + "<input type='button' onclick='cancelEdit(this)' value='Скасувати'/>"
	        jQuery(this).html(actionHtml);	
	      }
	    });
	  }

  function cancelEdit(button) {
    var id;
    jQuery(button).closest('tr').children().each(function(index, value){
      if(index == 0){
        id = jQuery(this).text();
      } else if(index != 0 && index != 3 && index != 4){
        jQuery(this).html(jQuery(this).find('input').val());	
      } else if (index == 4){
        var actionHtml = "<input type='button' onclick='deleteCity(" + id +
          ")' value='Видалити'/>"
        actionHtml = actionHtml + "<input type='button' onclick='editCity(this)' value='Редагувати'/>"
        jQuery(this).html(actionHtml);	
      }
    });
  }

  function applyEditCity(button){
    var id, name, population;
    jQuery(button).closest('tr').children().each(function(index, value){
      if(index == 0){
    	 name = jQuery(this).text();
      } else if(index == 1){
        postcode = jQuery(this).find('input').val();
      } else if (index == 2){
        population = jQuery(this).find('input').val();
      }
    });
    //Send ajax request for upating city
    var url = 'rest/city/updateCity/name/' + name +'/postcode/' + postcode +
      '/population/' + population;
    jQuery.ajax({
      url: url,
      dataType: 'json',
      type: 'PUT',
      success: function(data) {
        jQuery.ajax({
          url: 'rest/city/getAllCitys',
          dataType: 'json',
          type: 'GET',
          success: function(data) {
            jQuery('.datarow').remove();
            jQuery('#headerrow').after(createDataRowsFromJson(data));
          }
        });
      }
    });
  }
</script>
</head>
<body>
	<h1>Список міст</h1>
	<table style="width: 100%" border="1" id="citytable">
		<tr id="headerrow">
			<th>Назва</th>
			<th>Поштовий індекс</th>
			<th>Населення</th>
			<th>Список супермаркетів</th>
			<th>Дія</th>
		</tr>
		<tr>
			<td><input type="text" id="cityname" /></td>
			<td><input type="text" id="postcode" /></td>
			<td><input type="text" id="population" /></td>
			<td></td>
			<td><input type="button" id="addcity" value="Додати місто"></td>
		</tr>
	</table>
</body>
</html>

