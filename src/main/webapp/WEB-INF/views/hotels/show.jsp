<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
      #map_canvas {
        height: 400px;
        width: 600px;
        border: 1px solid #333;
        margin-top: 0.6em;
      }
</style>


<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">

function getLocation()
{
	var geocoder = new google.maps.Geocoder();
	var finalAddress = document.getElementById("address").innerHTML + " " + document.getElementById("citystatezip").innerHTML; 
	
	geocoder.geocode( { 'address': finalAddress}, function(results, status) {
	
	if (status == google.maps.GeocoderStatus.OK) {
		var map = new google.maps.Map(document.getElementById('map_canvas'), {
		      mapTypeId: google.maps.MapTypeId.ROADMAP,
		      center: results[0].geometry.location,
		      zoom: 15
		    });
		var marker =  new google.maps.Marker({
		     map: map,
		     position: results[0].geometry.location
		   });
		} 
	else
		{
			alert("Problem accessing the map, please reload the page and try again.")
		}
	});
	
	
}
</script>


<h1>${hotel.name}</h1>
<address>
	<span id="address">${hotel.address}</span>
	<br />
	<span id="citystatezip">${hotel.city}, ${hotel.state}, ${hotel.zip}</span>
	<br />
	${hotel.country}
</address>

<body onload="getLocation();"> 
<form action="booking" method="get">
	<p>
		Nightly Rate:
		<spring:bind path="hotel.price">${status.value}</spring:bind>
	</p>
	<input type="hidden" name="hotelId" value="${hotel.id}" />
	<div>
		<button type="submit">Book Hotel</button>
	</div>
</form>

<div id="map_canvas" style="width: 500px; height: 500px;"></div>
  
