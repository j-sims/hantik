% include('header.tpl', title='header')
</style>
        <script>
            // Register at Start
            $(document).ready(function(){
                $("#hide").click(function(){
                    $(".hideme").hide();
            });
            $("#cancel").click(function(){
                $(".hideme").hide();
            });
            $("#show").click(function(){
                $(".hideme").show();
            });
        });</script>
        <script>
            $(document).ready(function(){$(".hideme").hide();})
        </script>
        <script>
            $(function() {
                $(".restart").click(function() {
                    var count=5;
                    var counter=setInterval(timer, 1000); //1000 will  run it every 1 second
                    function timer()
                    {
                        count=count-1;
                        if (count < 0)
                        {
                            clearInterval(counter);
                            window.location = "/";
                            return;
                        }

                        document.getElementById("timer").innerHTML=count + " seconds"; // watch for spelling
                    }
            });
            });
        </script>
        <script>
        function callrestart() {
            setTimeout(function() {
                $.get( "/dorestart", function( data ) { });
            }, 3000);
        }
        </script>
        <br>
        <div class="container">
            <div class="row">
                <div class="col-md-6" style="padding-left: 2em;">

                    <!-- Button trigger modal -->
                    <a href="#" data-toggle="modal" data-backdrop="static" data-target="#myModal">
                        Refresh
                    </a> Services



                </div>
            </div>
        </div>
                    <!-- Modal -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="hide"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="myModalLabel">Confirm Restart?</h4>
                                </div>
                                <div class="modal-body">
                                    <p>Are you sure you want to refresh the services? </p>
                                    (This process will take 20 seconds.)
                                    <p class="hideme"><br>Restarting in <a id="timer"></a></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal" id="cancel">Cancel</button>
                                    <button type="button" class="btn btn-primary restart" id="show" onclick="callrestart()">Restart</button>
                                </div>
                            </div>
                        </div>
                    </div>
% include('footer.tpl', title='footer')
