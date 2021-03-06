<%@taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<portlet:defineObjects />

<!-- Defining the resourceURL -->
<portlet:resourceURL var="submitForm" />

<script type="text/javascript">

	function submitFormToServer(){
	
		AUI().use('aui-io-request', function(A){
			A.io.request('<%=submitForm%>', {
					method : 'post',
					dataType: 'json',
					
					// Sending the form to the server.
					form : {
						id: 'calculator'
					},
					
					// Receiving data from the server.
					on: {
						success: function() {
							var response = this.get('responseData');
							document.getElementById('result').innerHTML = response.result;
						}
					}
				});
			});
	}
	
	$(document).on('ready',function(){
		jQuery('[id=submit]').click(function(event) {
			
			$.ajax({
				url:'<%=submitForm%>',
				dataType: "json",
				data:{
					data: $('#calculator').serialize()
				},
				type: "post",
				success: function(data){
					console.log(data);
					document.getElementById('result').innerHTML = data.result;
				}
			});
		});
	});
	
</script>

<form id="calculator">
	
	<div>Super calculator !</div>
	<br/>
	<table>
		<tr>
			<td><input type="text" name="firstInput"/></td>
			<td>+</td>
			<td><input type="text" name="secondInput"/></td>
			<td>=</td>
			<td><div id="result"></div></td>
		</tr>
	</table>

	<br />
	<input type="button" id="submit" value="Submit" onclick="submitFormToServer()">
</form>