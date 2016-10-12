% include('header.tpl', title='header')


<script>
$(document).ready( function() { togglemodal(); starttimer(); calldeleteaddon(); });
</script>

<script>
function togglemodal() { $('#myModal').modal('toggle') }
</script>

<script>
function calldeleteaddon() {
    setTimeout(function() {
        $.post( "/deleteaddon", { "addon" : "{{addon}}" });
    }, 3000);
};
</script>
<script>
function starttimer() {
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
};
</script>

<br>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">Removing Addon {{addon}}...</h4>
                </div>
                <div class="modal-body">
                    <p>Please wait while the addon is removed and services are refreshed.</p>
                    <p>(This process will take 5 seconds.)</p>
                    <p> Page will load automatically upon completion </p>
                    <p class="hideme"><br>Restarting in <a id="timer"></a></p>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
</div>
% include('footer.tpl', title='footer')
