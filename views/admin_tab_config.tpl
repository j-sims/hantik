<div class="container">
    <div class="row">
        <div class="col-md-6" style="padding-left: 2em;">
            <h4>Configuration</h4>
            <br>
            <p>Configuration options</p>
            <div class="restart-popover-markup">
                Changes to these options require a <a href="#" class="restart-trigger">complete restart</a> of the services in order to pickup the file path changes.
                <script type="text/javascript">
                $('.restart-popover-markup > .restart-trigger').popover({
                        html : true,
                        title: function() {
                          return $(this).parent().find('.restart-head').html();
                        },
                        content: function() {
                          return $(this).parent().find('.restart-content').html();
                        },
                        container: 'body',
                        placement: 'bottom',
                        trigger: 'hover'
                    });
                </script>
                <div class="restart-head hide">
                    Restarting
                </div>
                </div>
            </div>

            <form action="/updateconfig" method="post">
            <table>
            
            % for key, value in config.iteritems():
            % if key != "installdir" and key != "bottledir" and key != "pounddir": #installdir cannot be changed and should not be shown
                % key = key.capitalize()
                <tr><td width="80">{{key}}</td><td><input type="text" name="{{key}}" value="{{value}}" size="30"></td></tr>
            % end
            % end
            </table>
            <input type="submit" value="submit" class="btn btn-default btn-xs">
            </form>
            <hr>
            Click <a href="/restart">here</a> to refresh the app services.
        </div>
    </div>
</div>
<hr>



