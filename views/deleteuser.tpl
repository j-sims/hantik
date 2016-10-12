<div id="deleteuser" class="col-xs-6">
<h4>Delete User:</h4>
<script src="/js/jquery.js" type="text/javascript"></script>
<form action="/delete_user" id="deleteuserForm">
<input type="text" name="username" placeholder="username">
<input type="submit" value="Delete" class="btn btn-default btn-xs">
</form>
<p><div id="deleteresult"><br></div>
<script>

$("#deleteuserForm" ).submit(
    function( event ) {
        // Stop form from submitting normally
        event.preventDefault();
        // Get some values from elements on the page:
        var $form = $( this ),
            user = $form.find( "input[name='username']" ).val(),
            url = $form.attr( "action" );
        // Send the data using post
        $.ajax( 
            { 
                type: "POST", 
                url: url, 
                data: { username: user }, 
                contentType: "application/json; charset=utf-8", 
                dataType: "json", 
                success: function( data, textStatus, jQxhr ) {
                   if ( data.success == true ) { 
                       $("#deleteresult").empty().append( data.msg );
                       //document.reload();
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

