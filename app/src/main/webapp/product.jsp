<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product page</title>
<link rel="stylesheet" href="styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	var param =  new URLSearchParams(window.location.search).get('id');
  jQuery( document ).ready(function() {
	 var head1 = document.getElementById("head1");
	head1.innerHTML = "Cписок продуктів супермаркета №" + param;
    //Send ajax request for show product list
    jQuery.ajax({
      url: 'rest/product/getAllProducts/supermarket_id/' + param,
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        jQuery('#headerrow').after(createDataRowsFromJson(data));
      }
    });
    jQuery( "#addproduct").click(function() {
      var url = 'rest/product/addProduct/description/' + jQuery("#description").val()
      + '/name/' + jQuery("#name").val() + '/remnant/' + jQuery("#remnant").val()
      + '/supermarketId/' + param;
      //Send ajax request for adding new product
      jQuery.ajax({
        url: url,
        dataType: 'json',
        type: 'POST',
        success: function(data) {
          //Send ajax request for refresh product list after adding product
          jQuery.ajax({
            url: 'rest/product/getAllProducts/supermarket_id/' + param,
            dataType: 'json',
            type: 'GET',
            success: function(data) {
              jQuery('.datarow').remove();
              jQuery('#headerrow').after(createDataRowsFromJson(data));
              jQuery("#description").val('');
              jQuery("#remnant").val('');
              jQuery("#name").val('');
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
            tableContent = tableContent + data[key].description;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].remnant;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + "<a href='supplier.jsp?id=" + data[key].id + "'>Список постачальників</a>";
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + "<input type='button' onclick='deleteProduct(\"" + data[key].id + "\")'value='Видалити'/>";
            tableContent = tableContent + "<input type='button' onclick='editProduct(this)' value='Редагувати'/>";
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "</tr>";
          }
    }
    return tableContent;
  }

  function deleteProduct(id) {
    var url = 'rest/product/deleteProduct/' + id;
    //Send ajax request for deleting product
    jQuery.ajax({
      url: url,
      dataType: 'json',
      type: 'DELETE',
      success: function(data) {
        jQuery.ajax({
          url: 'rest/product/getAllProducts/supermarket_id/' + param,
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

  function editProduct(button) {
    jQuery(button).closest('tr').children().each(function(index, value){
      if(index != 0 && index != 4 && index != 5){
        jQuery(this).html("<input type='text' value='" +
          jQuery(this).text() + "'/>");
      }  else if (index == 5){
        var actionHtml = "<input type='button' onclick='applyEditProduct(this)' value='Зберігти'/>"
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
      } else if(index != 0 && index != 4 && index != 5){
        jQuery(this).html(jQuery(this).find('input').val());	
      } else if (index == 5){
        var actionHtml = "<input type='button' onclick='deleteProduct(" + id +
          ")' value='Видалити'/>"
        actionHtml = actionHtml + "<input type='button' onclick='editProduct(this)' value='Редагувати'/>"
        jQuery(this).html(actionHtml);	
      }
    });
  }
  
  function applyEditProduct(button){
	  var id, description, remnant, name;
	    jQuery(button).closest('tr').children().each(function(index, value){
	      if(index == 0){
	        id = jQuery(this).text();
	      } else if(index == 1){
	    	  name = jQuery(this).find('input').val();
	      } else if (index == 2){
	    	  description = jQuery(this).find('input').val();
	      } else if(index == 3){
	    	  remnant = jQuery(this).find('input').val();
	      }
	    });
	    //Send ajax request for upating product
	    var url = 'rest/product/updateProduct/id/'+ id + '/description/' + description
	    + '/name/' + name + '/remnant/' + remnant
	    + '/supermarketId/' + param;
	    jQuery.ajax({
	      url: url,
	      dataType: 'json',
	      type: 'PUT',
	      success: function(data) {
	        jQuery.ajax({
	          url: 'rest/product/getAllProducts/supermarket_id/' + param,
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
	<table style="width: 100%" border="1" id="producttable">
		<tr id="headerrow">
			<td>Код продукта</td>
			<td>Назва</td>
			<td>Опис</td>
			<td>Залишок</td>
			<td>Список постачальників</td>
			<td>Дія</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="text" id="name" /></td>
			<td><input type="text" id="description" /></td>
			<td><input type="text" id="remnant" /></td>
			<td></td>
			<td><input type="button" id="addproduct" value="Додати"></td>
				
		</tr>
	</table>
</body>
</html>
