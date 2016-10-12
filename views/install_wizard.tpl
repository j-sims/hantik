<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Begin Header -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="/images/favicon.ico">


        <!-- Bootstrap core CSS -->
        <link href="/css/bootstrap.min.css" rel="stylesheet">
        <!-- End Header -->

    </head>

    <body>
        <!-- Nav bar -->
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div id="navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="/about">About</a></li>
                        <!-- Dynamic Addon Menu -->
                        <!-- End Dynamic Addon Menu -->
                        <li><a href="/login">Login</a></li>
                        <li><a href="/help">Help</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- End NavBar-->
        <div class="container">
            <br><br><br>
            <div class="starter-template">
                <br>
                <p class="lead">Welcome to the Install Wizard</p>
                <p></p>
                <div id="deleteuser" class="col-xs-6">

                    <script src="/js/jquery.js" type="text/javascript"></script>
                    <script>function checkPass()
                        {
                            //Store the password field objects into variables ...
                            var pass1 = document.getElementById('password');
                            var pass2 = document.getElementById('password2');
                            //Store the Confimation Message Object ...
                            var message = document.getElementById('confirmMessage');
                            //Set the colors we will be using ...
                            var goodColor = "#66cc66";
                            var badColor = "#ff6666";
                            //Compare the values in the password field
                            //and the confirmation field
                            if(pass1.value == pass2.value){
                                //The passwords match.
                                //Set the color to the good color and inform
                                //the user that they have entered the correct password
                                pass2.style.backgroundColor = goodColor;
                                message.style.color = goodColor;
                                message.innerHTML = "Passwords Match!"
                            }else{
                                //The passwords do not match.
                                //Set the color to the bad color and
                                //notify the user.
                                pass2.style.backgroundColor = badColor;
                                message.style.color = badColor;
                                message.innerHTML = "Password MisMatch!"
                            }
                        }  </script>
                    <h4>Set Admin Password:</h4>
                    <form action="/install_wizard" id="setadminpassForm">
                        <table border="0">
                            <tr><td width="80"><label for="pass1">Password:</label></td>
                                <td width="120"><input type="password" name="password" id="password" placeholder="password"></td></tr>
                            <tr><td><label for="pass2">Confirm:</label></td>
                                <td><input type="password" name="password2" id="password2" placeholder="confirm" onkeyup="checkPass(); return false;"></td></tr>
                            <tr><td>&nbsp;</td><td><div id="confirmMessage" class="confirmMessage"></div></td></tr>
                        </table>
                        <input type="submit" value="Submit" class="btn btn-default btn-xs">
                    </form>
                    <div id="deleteresult"></div>
                    <script>
                        $("#setadminpassForm" ).submit(
                            function( event ) {
                                // Stop form from submitting normally
                                event.preventDefault();
                                // Get some values from elements on the page:
                                var $form = $( this ),
                                    pass = $form.find( "input[name='password']" ).val(),
                                    url = $form.attr( "action" );
                                // Send the data using post
                                $.ajax(
                                    {
                                        type: "POST",
                                        url: url,
                                        data: { password: pass },
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function( data, textStatus, jQxhr ) {
                                            if ( data.success == true ) {
                                                $("#deleteresult").empty().append( data.msg );
                                                location.reload();
                                            } else {
                                                $("#deleteresult").empty().append( data.msg );
                                            };
                                        },
                                        failure: function(err) { alert(err); }
                                    }
                                );

                            }
                        );
                    </script>
                </div>
            </div>

        </div><!-- /.container -->




        <!-- Bootstrap core JavaScript
================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="/js/jquery.min.js"></script>
        <script src="/js/bootstrap.min.js"></script>

    </body>
</html>
