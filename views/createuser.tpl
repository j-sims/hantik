                        <div id="createuser" class="col-xs-6">
                            <h4>Create User:</h4>
                            <script src="/js/jquery.js" type="text/javascript"></script>
                            <form action="/create_user" id="createuserForm">
                                <input type="text" name="username" placeholder="username"><br>
                                <input type="password" name="password" placeholder="password"><br>
                                <input type="text" name="role" placeholder="role" value="user"><br>
                                <input type="submit" value="Create" class="btn btn-default btn-xs">
                            </form>
                            <!-- the result of the search will be rendered inside this div -->
                            <div id="createresult"></div>
                            <script>
                                $("#createuserForm" ).submit(
                                    function( event ) {
                                        // Stop form from submitting normally
                                        event.preventDefault();
                                        // Get some values from elements on the page:
                                        var $form = $( this ),
                                            user = $form.find( "input[name='username']" ).val(),
                                            pass = $form.find( "input[name='password']" ).val(),
                                            role = $form.find( "input[name='role']" ).val(),
                                            url = $form.attr( "action" );
                                        // Send the data using post
                                        $.ajax(
                                            {
                                                type: "POST",
                                                url: url,
                                                data: { username: user, password: pass, role: role },
                                                contentType: "application/json; charset=utf-8",
                                                dataType: "json",
                                                success: function( data, textStatus, jQxhr ) {
                                                    if ( data.success == true ) {
                                                        $("#createresult").empty().append( data.msg );
                                                        location.reload(true);
                                                    } else {
                                                        $("#createresult").empty().append( data.msg );
                                                    };
                                                },
                                                failure: function(err) { alert(err); }
                                            }
                                        );

                                    }
                                );
                            </script>

                        </div>
