<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Supplier page</title>
<link rel="stylesheet" href="styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	var param =  new URLSearchParams(window.location.search).get('id');
  jQuery( document ).ready(function() {
	 var head1 = document.getElementById("head1");
	head1.innerHTML = "Cписок постачальника продукта з кодом " + param;
    //Send ajax request for show supplier list
    jQuery.ajax({
      url: 'rest/supplier/getAllSuppliers/productid/' + param,
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        jQuery('#headerrow').after(createDataRowsFromJson(data));
      }
    });
    jQuery( "#addsupplier").click(function() {
      var url = 'rest/supplier/addSupplier/address/' + jQuery("#address").val()
      + '/mail/' + jQuery("#mail").val() + '/name/' + jQuery("#name").val()
      + '/phone/' + jQuery("#phone").val() + '/price/' + jQuery("#price").val()
      + '/productId/' + param;
      //Send ajax request for adding new supplier
      jQuery.ajax({
        url: url,
        dataType: 'json',
        type: 'POST',
        success: function(data) {
          //Send ajax request for refresh supplier list after adding supplier
          jQuery.ajax({
            url: 'rest/supplier/getAllSuppliers/productid/' + param,
            dataType: 'json',
            type: 'GET',
            success: function(data) {
              jQuery('.datarow').remove();
              jQuery('#headerrow').after(createDataRowsFromJson(data));
              jQuery("#address").val('');
              jQuery("#name").val('');
              jQuery("#phone").val('');
              jQuery("#price").val('');
              jQuery("#mail").val('');
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
            tableContent = tableContent + data[key].name;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].address;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].phone;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].price;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].mail;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + "<input type='button' onclick='deleteSupplier(\"" + data[key].id + "\")'value='Видалити'/>";
            tableContent = tableContent + "<input type='button' onclick='editSupplier(this)' value='Редагувати'/>";
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "</tr>";
          }
    }
    return tableContent;
  }

  function deleteSupplier(id) {
    var url = 'rest/supplier/deleteSupplier/' + id;
    //Send ajax request for deleting supplier
    jQuery.ajax({
      url: url,
      dataType: 'json',
      type: 'DELETE',
      success: function(data) {
        jQuery.ajax({
          url: 'rest/supplier/getAllSuppliers/productid/' + param,
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

  function editSupplier(button) {
    jQuery(button).closest('tr').children().each(function(index, value){
      if(index != 0 && index != 6){
        jQuery(this).html("<input type='text' value='" +
          jQuery(this).text() + "'/>");
      }  else if (index == 6){
        var actionHtml = "<input type='button' onclick='applyEditSupplier(this)' value='Зберігти'/>"
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
      } else if(index != 0 && index != 6){
        jQuery(this).html(jQuery(this).find('input').val());	
      } else if (index == 6){
        var actionHtml = "<input type='button' onclick='deleteSupplier(" + id +
          ")' value='Видалити'/>"
        actionHtml = actionHtml + "<input type='button' onclick='editSupplier(this)' value='Редагувати'/>"
        jQuery(this).html(actionHtml);	
      }
    });
  }
  
  function applyEditSupplier(button){
	  var id, address, name, phone, price, mail;
	    jQuery(button).closest('tr').children().each(function(index, value){
	      if(index == 0){
	        id = jQuery(this).text();
	      } else if(index == 1){
	    	  name = jQuery(this).find('input').val();
	      } else if (index == 2){
	    	  address = jQuery(this).find('input').val();
	      } else if(index == 3){
	    	  phone = jQuery(this).find('input').val();
	      } else if (index == 4){
	    	  price = jQuery(this).find('input').val();
	      } else if (index == 5){
	    	  mail = jQuery(this).find('input').val();
	      }
	    });
	    //Send ajax request for upating supplier
	    var url = 'rest/supplier/updateSupplier/id/'+ id + '/address/' + address
	    + '/mail/' + mail + '/name/' + name
	    + '/phone/' + phone + '/price/' + price
	    + '/productId/' + param;
	    jQuery.ajax({
	      url: url,
	      dataType: 'json',
	      type: 'PUT',
	      success: function(data) {
	        jQuery.ajax({
	          url: 'rest/supplier/getAllSuppliers/productid/' + param,
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
	<table style="width: 100%" border="1" id="suppliertable">
		<tr id="headerrow">
			<td>Код Постачальника</td>
			<td>Назва компанії</td>
			<td>Адреса</td>
			<td>Телефон</td>
			<td>Ціна</td>
			<td>E-mail</td>
			<td>Дія</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="text" id="name" /></td>
			<td><input type="text" id="address" /></td>
			<td><input type="text" id="phone" /></td>
			<td><input type="text" id="price" /></td>
			<td><input type="text" id="mail" /></td>
			<td><input type="button" id="addsupplier" value="Додати"></td>
		</tr>
	</table>
</body>
</html>