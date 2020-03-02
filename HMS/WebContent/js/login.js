var signInClicked = false; //Set true when a sign in btn is pressed, stops the google auth from auto signing users in.

function easyInput(name, value) {
	var input = document.createElement("input");
	input.type = "text";
	input.name = name;
	input.value = value;
	return input;
}

function onSignIn(googleUser) {
	/*//Check if an account has been selected
	var accountTypeInput =  document.getElementById("accountTypeInput");
	//If an account type hasn't been picked then stop from signing up
	if(accountTypeInput.value == "") {
		return; //Stops from requesting page
	}*/

	if(!signInClicked) return; //If a sign in btn has been pressed then user shouldn't be loggin in

	// The ID token you need to pass to your backend:
	var id_token = googleUser.getAuthResponse().id_token;
	console.log(id_token);
	console.log(googleUser.getBasicProfile());
	
	// Pass id token to backend and fetch result
	var xhr = new XMLHttpRequest();
	xhr.open('POST', 'http://www.vetpet.online:8080/openid.jsp');
	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xhr.onload = function() {
		if(this.responseText != "") {
			console.log(this.responseText);
			//redirect to register using a form so I can post variables
			var user = JSON.parse(this.responseText);

			var postForm = document.createElement("FORM");
			postForm.method = "POST";
			postForm.action = "registrationForm.jsp";
			postForm.style.display = "none";
			document.body.appendChild(postForm);

			//fill in parts of the form
			postForm.appendChild(easyInput("AccountType", "Patient")); //TODO: Needs to allow changing account type
			postForm.appendChild(easyInput("Email", user.email));
			postForm.appendChild(easyInput("FirstName", user.firstName));
			postForm.appendChild(easyInput("LastName", user.lastName));

			postForm.submit(); //redirects to the registration form with part of it filled in
		} else {
			//redirect to home page, they should be logged in 
			window.location.replace("index.html");
		}
	};
	xhr.send('id_token=' + id_token + "&account_type=" + "Patient"); //TODO: Make it allow anyaccount type
};


/*//Attaches an onclick listener to the passed in element thta will cause google:wq login to start
function attachSignin(element) {
    console.log(element.id);
    auth2.attachClickHandler(element, {},
        function(googleUser) {
          document.getElementById('name').innerText = "Signed in: " +
              googleUser.getBasicProfile().getName();
        }, function(error) {
          alert(JSON.stringify(error, undefined, 2));
        });
}*/

window.addEventListener("load", function() { 
	//Annotate that a sign btn has been pressed
	var googleSignInBtns = document.getElementsByClassName("google-signin");
	Array.from(googleSignInBtns).forEach(function(googleSignInBtn) {
		googleSignInBtn.addEventListener("click", function(e) {
			signInClicked = true;
			gapi.auth2.grantOfflineAccess().then(signInCallback); //Callto the google sign-in api
		});
	});
});
