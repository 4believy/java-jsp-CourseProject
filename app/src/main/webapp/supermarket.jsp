<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Supermarket page</title>
<link rel="stylesheet" href="styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	var param =  new URLSearchParams(window.location.search).get('cityname');
  jQuery( document ).ready(function() {
	 var head1 = document.getElementById("head1");
	head1.innerHTML = "Cписок супермаркетів города " + param;
    //Send ajax request for show supermarket list
    jQuery.ajax({
      url: 'rest/supermarket/getAllSupermarkets/city_name/' + param,
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        jQuery('#headerrow').after(createDataRowsFromJson(data));
      }
    });
    jQuery( "#addsupermarket").click(function() {
      var url = 'rest/supermarket/addSupermarket/address/' + jQuery("#address").val()
      + '/cityName/' + param + '/costs/' + jQuery("#costs").val()
      + '/directorFIO/' + jQuery("#directorFIO").val() + '/income/' + jQuery("#income").val()
      + '/phone/' + jQuery("#phone").val();
      //Send ajax request for adding new supermarket
      jQuery.ajax({
        url: url,
        dataType: 'json',
        type: 'POST',
        success: function(data) {
          //Send ajax request for refresh supermarket list after adding supermarket
          jQuery.ajax({
            url: 'rest/supermarket/getAllSupermarkets/city_name/' + param,
            dataType: 'json',
            type: 'GET',
            success: function(data) {
              jQuery('.datarow').remove();
              jQuery('#headerrow').after(createDataRowsFromJson(data));
              jQuery("#address").val('');
              jQuery("#costs").val('');
              jQuery("#directorFIO").val('');
              jQuery("#income").val('');
              jQuery("#phone").val('');
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
            tableContent = tableContent + data[key].id;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].address;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].directorFIO;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].phone;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].income;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].costs;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + "<a href='seller.jsp?id=" + data[key].id + "'>Список продавців</a>";
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + "<a href='product.jsp?id=" + data[key].id + "'>Список продуктів</a>";
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + "<input type='button' onclick='deleteSupermarket(\"" + data[key].id + "\")'value='Видалити'/>";
            tableContent = tableContent + "<input type='button' onclick='editSupermarket(this)' value='Редагувати'/>";
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "</tr>";
          }
    }
    return tableContent;
  }

  function deleteSupermarket(id) {
    var url = 'rest/supermarket/deleteSupermarket/' + id;
    //Send ajax request for deleting supermarket
    jQuery.ajax({
      url: url,
      dataType: 'json',
      type: 'DELETE',
      success: function(data) {
        jQuery.ajax({
          url: 'rest/supermarket/getAllSupermarkets/city_name/' + param,
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

  function editSupermarket(button) {
    jQuery(button).closest('tr').children().each(function(index, value){
      if(index != 0 && index != 6 && index != 7 && index != 8){
        jQuery(this).html("<input type='text' value='" +
          jQuery(this).text() + "'/>");
      }  else if (index == 8){
        var actionHtml = "<input type='button' onclick='applyEditSupermarket(this)' value='Зберігти'/>"
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
      } else if(index != 0 && index != 6 && index != 7 && index != 8){
        jQuery(this).html(jQuery(this).find('input').val());	
      } else if (index == 8){
        var actionHtml = "<input type='button' onclick='deleteSupermarket(" + id +
          ")' value='Видалити'/>"
        actionHtml = actionHtml + "<input type='button' onclick='editSupermarket(this)' value='Редагувати'/>"
        jQuery(this).html(actionHtml);	
      }
    });
  }
  
  function applyEditSupermarket(button){
	  var id, address, costs, directorFIO, income, phone;
	    jQuery(button).closest('tr').children().each(function(index, value){
	      if(index == 0){
	        id = jQuery(this).text();
	      } else if(index == 1){
	    	  address = jQuery(this).find('input').val();
	      } else if (index == 2){
	    	  directorFIO = jQuery(this).find('input').val();
	      } else if(index == 3){
	    	  phone = jQuery(this).find('input').val();
	      } else if (index == 4){
	    	  income = jQuery(this).find('input').val();
	      } else if (index == 5){
	    	  costs = jQuery(this).find('input').val();
	      }
	    });
	    //Send ajax request for upating supermarket
	    var url = 'rest/supermarket/updateSupermarket/id/'+ id + '/address/' + address
	    + '/cityName/' + param + '/costs/' + costs
	    + '/directorFIO/' + directorFIO + '/income/' + income
	    + '/phone/' + phone;
	    jQuery.ajax({
	      url: url,
	      dataType: 'json',
	      type: 'PUT',
	      success: function(data) {
	        jQuery.ajax({
	          url: 'rest/supermarket/getAllSupermarkets/city_name/' + param,
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
	<h1 id="head1"></h1>
	<table style="width: 100%" border="1" id="supermarkettable">
		<tr id="headerrow">
			<td>Номер супермаркета</td>
			<td>Адреса</td>
			<td>Директор</td>
			<td>Телефон</td>
			<td>Доходи</td>
			<td>Витрати</td>
			<td>Список продавців</td>
			<td>Список продуктів</td>
			<td>Дія</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="text" id="address" /></td>
			<td><input type="text" id="directorFIO" /></td>
			<td><input type="text" id="phone" /></td>
			<td><input type="text" id="income" /></td>
			<td><input type="text" id="costs" /></td>
			<td></td>
			<td></td>
			<td><input type="button" id="addsupermarket" value="Додати"></td>
		</tr>
	</table>
</body>
</html>

