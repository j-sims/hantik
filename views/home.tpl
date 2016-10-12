% include('header.tpl', title='header')
<div class="container">
    <br>
    <p class="lead">Welcome</p>
    <div class="row">
        <div class="col-md-6" style="padding-left: 2em;">
            <p>In this app you will some useful tools for easily deploying python web apps.</p>
            <p>To learn more about this app see the <a href="/about">About</a> page.</p>
            <p></p>
            % if len(addons) > 0:
            <p>This application framework uses addons to provide specific functionality. The following
                is a list of the currently installed addons and a description of their functionlity.
                Addons can be access from the navigation bar at the top.</p>
            % else:
            <p>This app has no addons installed. To use the app, first install an addon via the <a href="/admin#addons">admin menu</a>.</p>
            % end
            <ul>
                %for k, v in addondescriptions.iteritems():
                <li><b>{{k.replace('_', ' ').title()}}:</b> {{v}}</li>
                %end
            </ul>
        </div>
    </div>
</div>
% include('footer.tpl', title='footer')
