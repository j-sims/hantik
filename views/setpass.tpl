                        <div id="createuser" class="col-xs-6">
                            <h4>Create User:</h4>
                            <script src="/js/jquery.js" type="text/javascript"></script>
                            <form action="/setpass" id="setpassForm">
                                <input type="text" name="username" placeholder="username"><br>
                                <input type="password" name="password" placeholder="password"><br>
                                <input type="submit" value="Change">
                            </form>
                            <!-- the result of the search will be rendered inside this div -->
                            <div id="setpassresult"></div>
                            <script>
                                $("#setpassForm" ).submit(
                                    function( event ) {
                                        // Stop form from submitting normally
                                        event.preventDefault();
                                        // Get some values from elements on the page:
                                        var $form = $( this ),
                                            user = $form.find( "input[name='username']" ).val(),
                                            pass = $form.find( "input[name='password']" ).val(),
                                            url = $form.attr( "action" );
                                        // Send the data using post
                                        $.ajax(
                                            {
                                                type: "POST",
                                                url: url,
                                                data: { username: user, password: pass },
                                                contentType: "application/json; charset=utf-8",
                                                dataType: "json",
                                                success: function( data, textStatus, jQxhr ) {
                                                    if ( data.success == true ) {
                                                        $("#setpassresult").empty().append( data.msg );
                                                        //location.reload(true);
                                                    } else {
                                                        $("#setpassresult").empty().append( data.msg );
                                                    };
                                                },
                                                failure: function(err) { alert(err); }
                                            }
                                        );

                                    }
                                );
                            </script>

                        </div>
