<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seller page</title>
<link rel="stylesheet" href="styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	var param =  new URLSearchParams(window.location.search).get('id');
  jQuery( document ).ready(function() {
	 var head1 = document.getElementById("head1");
	head1.innerHTML = "Cписок продавців супермаркета №" + param;
    //Send ajax request for show seller list
    jQuery.ajax({
      url: 'rest/seller/getAllSellers/supermarket_id/' + param,
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        jQuery('#headerrow').after(createDataRowsFromJson(data));
      }
    });
    jQuery( "#addseller").click(function() {
      var url = 'rest/seller/addSeller/cashierNumber/' + jQuery("#cashierNumber").val()
      + '/supermarketId/' + param + '/fio/' + jQuery("#fio").val()
      + '/phone/' + jQuery("#phone").val() + '/salary/' + jQuery("#salary").val()
      + '/workExp/' + jQuery("#workExp").val();
      //Send ajax request for adding new seller
      jQuery.ajax({
        url: url,
        dataType: 'json',
        type: 'POST',
        success: function(data) {
          //Send ajax request for refresh seller list after adding seller
          jQuery.ajax({
            url: 'rest/seller/getAllSellers/supermarket_id/' + param,
            dataType: 'json',
            type: 'GET',
            success: function(data) {
              jQuery('.datarow').remove();
              jQuery('#headerrow').after(createDataRowsFromJson(data));
              jQuery("#cashierNumber").val('');
              jQuery("#fio").val('');
              jQuery("#phone").val('');
              jQuery("#salary").val('');
              jQuery("#workExp").val('');
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
            tableContent = tableContent + data[key].fio;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].workExp;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].cashierNumber;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].phone;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + data[key].salary;
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "<td>";
            tableContent = tableContent + "<input type='button' onclick='deleteSeller(\"" + data[key].id + "\")'value='Видалити'/>";
            tableContent = tableContent + "<input type='button' onclick='editSeller(this)' value='Редагувати'/>";
            tableContent = tableContent + "</td>";
            tableContent = tableContent + "</tr>";
          }
    }
    return tableContent;
  }

  function deleteSeller(id) {
    var url = 'rest/seller/deleteSeller/' + id;
    //Send ajax request for deleting seller
    jQuery.ajax({
      url: url,
      dataType: 'json',
      type: 'DELETE',
      success: function(data) {
        jQuery.ajax({
          url: 'rest/seller/getAllSellers/supermarket_id/' + param,
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

  function editSeller(button) {
    jQuery(button).closest('tr').children().each(function(index, value){
      if(index != 0 && index != 6){
        jQuery(this).html("<input type='text' value='" +
          jQuery(this).text() + "'/>");
      }  else if (index == 6){
        var actionHtml = "<input type='button' onclick='applyEditSeller(this)' value='Зберігти'/>"
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
        var actionHtml = "<input type='button' onclick='deleteSeller(" + id +
          ")' value='Видалити'/>"
        actionHtml = actionHtml + "<input type='button' onclick='editSeller(this)' value='Редагувати'/>"
        jQuery(this).html(actionHtml);	
      }
    });
  }
  
  function applyEditSeller(button){
	  var id, cashierNumber, fio, phone, salary, workExp;
	    jQuery(button).closest('tr').children().each(function(index, value){
	      if(index == 0){
	        id = jQuery(this).text();
	      } else if(index == 1){
	    	  fio = jQuery(this).find('input').val();
	      } else if (index == 2){
	    	  workExp = jQuery(this).find('input').val();
	      } else if(index == 3){
	    	  cashierNumber = jQuery(this).find('input').val();
	      } else if (index == 4){
	    	  phone = jQuery(this).find('input').val();
	      } else if (index == 5){
	    	  salary = jQuery(this).find('input').val();
	      }
	    });
	    //Send ajax request for upating seller
	    var url = 'rest/seller/updateSeller/id/'+ id + '/cashierNumber/' + cashierNumber
	    + '/supermarketId/' + param + '/fio/' + fio
	    + '/phone/' + phone + '/salary/' + salary
	    + '/workExp/' + workExp;
	    jQuery.ajax({
	      url: url,
	      dataType: 'json',
	      type: 'PUT',
	      success: function(data) {
	        jQuery.ajax({
	          url: 'rest/seller/getAllSellers/supermarket_id/' + param,
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
	<table style="width: 100%" border="1" id="sellertable">
		<tr id="headerrow">
			<td>Код продавця</td>
			<td>ФІО</td>
			<td>Стаж роботи</td>
			<td>Номер каси</td>
			<td>Телефон</td>
			<td>Оклад</td>
			<td>Дія</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="text" id="fio" /></td>
			<td><input type="text" id="workExp" /></td>
			<td><input type="text" id="cashierNumber" /></td>
			<td><input type="text" id="phone" /></td>
			<td><input type="text" id="salary" /></td>
			<td><input type="button" id="addseller" value="Додати"></td>
		</tr>
	</table>
</body>
</html>
		
