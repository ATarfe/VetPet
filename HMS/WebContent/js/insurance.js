window.addEventListener("load", function() {
	// search by interest
	var searchInsuranceForm = document.getElementById("SearchInsurance");
	searchInsuranceForm.addEventListener("submit", function(e) {
		e.preventDefault();
        
        var petNameInput = searchInsuranceForm.querySelector("*[name=petname]");
		var petTypeInput = searchInsuranceForm.querySelector("*[name=pettype]");
        var petGenderInput = searchInsuranceForm.querySelector("*[name=petgender]");
		var deductibleInput = searchInsuranceForm.querySelector("*[name=deductible]");
        //var petDOBInput = searchInsuranceForm.querySelector("*[name=petdob]");
		//var premiumInput = searchInsuranceForm.querySelector("*[name=premium]");
		
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			
			if(this.readyState == 4 && this.status == 200) {
				// insert html page into this page
				var planTableElement = document.getElementById("InsurancePlanTable");
				planTableElement.innerHTML = this.responseText;
				var radioGroup = planTableElement.querySelector(".radio-group");
                setupDivRadio(radioGroup);
			}
		};
		
		xhttp.open("POST", "insuranceUpdate.jsp", true);
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		var inputStr = "pettype="+petTypeInput.value+"&petname="+petNameInput.value+"&petgender="+petGenderInput.value+"&deductible="+deductibleInput.value;
		inputStr += "&coverage=" + coverageInput.value;
        //inputStr += "&petdob="+petDOBInput.value+"&premium="+premiumInput.value;
		console.log(inputStr);
		xhttp.send(inputStr);
		
		return false;
	});
	
	// select plan
	var insuranceForm = document.getElementById("InsuranceForm");
	insuranceForm.addEventListener(submit, function(e) {
		e.preventDefault();

		var plan_id = insuranceForm.querySelector("*[name=plan_id]");
		var patient_id = insuranceForm.querySelector("*[name=patient_id]");
		var petname = insuranceForm.querySelector("*[name=petname]");

		var xhttp = new XMLHttpRequest();
		xhttp.open("POST", "selectInsurancePlan.jsp", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		var inputStr = "plan_id=" + plan_id.value + "&patient_id=" + patient_id.value + "&petname=" + petname.value;
		console.log(inputStr);
		xhttp.send(inputStr);

		return false;
	})
});