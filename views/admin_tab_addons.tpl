<style>
th, td {
    padding: 10px;
}
</style>
<!-- Scripts -->
<div class="container">
    <div class="row">
        <div class="col-md-6" style="padding-left: 2em;">
            <h4>Addon Management</h4>
            % if len(addons) == 0:
            <p>No addons installed.</p>
            % elif len(addons) > 0:
            <div class="table-responsive">
            <table class="table table-hover">
                <tr><td><bold>Name</bold></td><td><bold>Description</bold></td><td><bold>Action</bold></td></tr>
            % for a in addons:

                <tr>
                    <td width="80">{{a.capitalize()}}</td>
                    <td width="320">{{addondescriptions[a]}}</td>
                    <td><a href="/removeaddon?addon={{a}}">Delete</a></td>
                </tr>



            % end
            </table>
            </div>
            % end
        </div>
        <div class="col-md-3" style="padding-left: 2em;">
            <h4>Install New Addon</h4>
            <form action="/upload" method="post" enctype="multipart/form-data">
                Select a file: <input type="file" name="upload" /><p></p>
                <button type="submit" class="btn btn-default btn-xs">Start upload</button>
            </form>
        </div>
    </div>
</div>

