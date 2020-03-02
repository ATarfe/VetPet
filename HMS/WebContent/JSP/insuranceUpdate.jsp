<%@ page import="com.justice.HttpHelper,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- CSS -->
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../style/fontawesome-all.min.css" />
    <!-- Bootstrap core CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.13/css/mdb.min.css" rel="stylesheet">
    <!-- Changes to mdbootstrap -->
    <link href="../style/mdbootstrap_rework.css" rel="stylesheet">
</head>
<body>
    <main>
    	<div class="container p-0">
		<div class="row">
			<div class="col-12">
				<div id="InsuranceProviderTable"></div>
			</div>
		</div>
		<div class="row">
			  <div class="col-2"></div>
			  <div class="col-8">
				  <input id="SubmitInsuranceFormBtn" type="button" class="btn btn-block btn-primary btn-lg" value="Choose" />
			  </div>
		</div>
	</div>
    </main>

    <!-- JAVASCRIPT -->
    <!-- JQuery -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.13/js/mdb.min.js"></script>

    <!-- Load React. and Babel transpiler for jsx -->
    <script crossorigin src="https://unpkg.com/react@16/umd/react.development.js"></script>
    <script crossorigin src="https://unpkg.com/react-dom@16/umd/react-dom.development.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.21.1/babel.min.js"></script>
    <!-- Load my React component. -->
    <script src="../js/easyPost.js"></script>
    <script charset="utf-8" type="text/babel" src="../js/react_components/filterableTable.js"></script>

    <!-- script specific to this page -->
    <script type="text/babel">
        const submitBtn = document.getElementById("SubmitInsuranceFormBtn");

        asyncPostPage("PublicTables.jsp", "table=insurance_plans", function(responseJson) {
            const data = JSON.parse(responseJson);
            const columns = [
	    	{ name: "provider_name",   displayName: "Provider",    exactFilter: true},
                { name: "plan_name",       displayName: "Plan"},
	    	{ name: "plan_coverage",   displayName: "Coverage",    csvExactFilter: true, forceSpaceAfterComma: true},
	    	{ name: "plan_premium",	   displayName: "Premium",     minMaxFilter: true, render: (columnData) => (<p className="text-center">{"$"+columnData}</p>)},
		{ name: "plan_deduction",  displayName: "Deductible",  minMaxFilter: true, render: (columnData) => (<p className="text-center">{"$"+columnData}</p>)},
		{ name: "pet_type", 	   displayName: "Pet Covered", exactFilter: true, render: (columnData) => (<p className="text-center">{columnData}</p>)}
            ];

            ReactDOM.render(
                <FilterableTable
                    id="ReactInsuranceProviderTable" 
                    data={data} 
                    columns={columns}
                    onRowSelected={(rowObj) => {
                        //Setup to wait for button to be clicked
                        submitBtn.onclick = function(e) {
                            //Create a form from json and submits it
                            var form = document.createElement("FORM");
                            form.style.display = "none";
		    	    form.method = "POST";
		    	    form.action = "selectInsurancePlan.jsp";
                            Object.keys(rowObj).forEach((key) => {
                                var input = document.createElement("INPUT");
                                input.type = "text";
                                input.name = key;
                                input.value = rowObj[key];

                                form.appendChild(input);
                            });

		    	    //Pet type and pet name pass thru
		    	    var petTypeInput = document.createElement("INPUT");
		    	    petTypeInput.type = "text";
		    	    petTypeInput.name = "pettype";
		    	    petTypeInput.value = "<%= request.getParameter("pettype") %>";
		    	    var petNameInput = document.createElement("INPUT");
		    	    petNameInput.type = "text";
		    	    petNameInput.name = "petname";
			    petNameInput.value = "<%= request.getParameter("petname") %>";

                            document.body.appendChild(form);
                            form.submit();
                        };
                    }} />,
                document.getElementById("InsuranceProviderTable")
            );
        });
    </script>
</body>
</html>


