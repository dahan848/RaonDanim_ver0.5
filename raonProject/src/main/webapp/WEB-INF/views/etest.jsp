<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<style type="text/css">
.container-fluid {
	padding-top: 30px;
}

.select2-results-dept-0 { /* do the columns */
	float: left;
	width: 20%;
}

img.flag {
	height: 10px;
	padding-right: 5px;
	width: 15px;
}

/* move close cross [x] from left to right on the selected value (tag) */
#s2id_e2_2.select2-container-multi .select2-choices .select2-search-choice
	{
	padding: 3px 18px 3px 5px;
}

#s2id_e2_2.select2-container-multi .select2-search-choice-close {
	left: auto;
	right: 3px;
}
</style>
<title>Insert 6 6here</title>
</head>
<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.1/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.1/js/select2.min.js"></script>
<body>
	<div class="container-fluid">
		<select id="e2_2" multiple="multiple" style="width: 100%"
			class="select2-multi-col">
			<optgroup label="Alaskan/Hawaiian Time Zone">
				<option value="AK">Alaska</option>
				<option value="HI">Hawaii</option>
				<option value="CA">California</option>
				<option value="NV">Nevada</option>
				<option value="OR">Oregon</option>
				<option value="WA">Washington</option>
				<option value="AZ">Arizona</option>
				<option value="CO">Colorado</option>
				<option value="ID">Idaho</option>
				<option value="MT">Montana</option>
				<option value="NE">Nebraska</option>
				<option value="NM">New Mexico</option>
				<option value="ND">North Dakota</option>
				<option value="UT">Utah</option>
				<option value="WY">Wyoming</option>
				<option value="AL">Alabama</option>
				<option value="AR">Arkansas</option>
				<option value="IL">Illinois</option>
				<option value="IA">Iowa</option>
				<option value="KS">Kansas</option>
				<option value="KY">Kentucky</option>
				<option value="LA">Louisiana</option>
				<option value="MN">Minnesota</option>
				<option value="MS">Mississippi</option>
				<option value="MO">Missouri</option>
				<option value="OK">Oklahoma</option>
				<option value="SD">South Dakota</option>
				<option value="TX">Texas</option>
				<option value="TN">Tennessee</option>
				<option value="WI">Wisconsin</option>
				<option value="CT">Connecticut</option>
				<option value="DE">Delaware</option>
				<option value="FL">Florida</option>
				<option value="GA">Georgia</option>
				<option value="IN">Indiana</option>
				<option value="ME">Maine</option>
				<option value="MD">Maryland</option>
				<option value="MA">Massachusetts</option>
				<option value="MI">Michigan</option>
				<option value="NH">New Hampshire</option>
				<option value="NJ">New Jersey</option>
				<option value="NY">New York</option>
				<option value="NC">North Carolina</option>
				<option value="OH">Ohio</option>
				<option value="PA">Pennsylvania</option>
				<option value="RI">Rhode Island</option>
				<option value="SC">South Carolina</option>
				<option value="VT">Vermont</option>
				<option value="VA">Virginia</option>
				<option value="WV">West Virginia</option>
			</optgroup>
		</select>
	</div>


</body>
<script type="text/javascript">
function format(state) {
	alert("짠");
     if (!state.id) return state.text; // optgroup
     return "<img class='flag' src='//select2.github.io/vendor/images/flags/" + state.id.toLowerCase() + ".png'>" + state.text;
   }

   $("#e2_2").select2({
     placeholder: "Select a state or many…",
     formatResult: format,
     formatSelection: format,
     escapeMarkup: function(m) { return m; }
   });
   
   //테스트
	   $("#e7").select2({
	    placeholder: "Search for a repository",
	    minimumInputLength: 3,
	    ajax: {
	        url: "https://api.github.com/search/repositories",
	        dataType: 'json',
	        quietMillis: 250,
	        data: function (term, page) { // page is the one-based page number tracked by Select2
	            return {
	                q: term, //search term
	                page: page // page number
	            };
	        },
	        results: function (data, page) {
	            var more = (page * 30) < data.total_count; // whether or not there are more results available
	 
	            // notice we return the value of more so Select2 knows if more results can be loaded
	            return { results: data.items, more: more };
	        }
	    },
	    formatResult: repoFormatResult, // omitted for brevity, see the source of this page
	    formatSelection: repoFormatSelection, // omitted for brevity, see the source of this page
	    dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
	    escapeMarkup: function (m) { return m; } // we do not want to escape markup since we are displaying html in results
	});
</script>
</html>