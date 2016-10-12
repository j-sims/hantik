% include('header.tpl', title='Top')
<div class="container">
    <br>
    <h4>Administration Page</h4>
    <p>Welcome {{current_user.username}}, your role is: {{current_user.role}},
    access time: {{current_user.session_accessed_time}}</p>

    <div role="tabpanel">
        <ul class="nav nav-tabs" role="tablist">
        <!-- <li role="presentation" class="active"><a href="#config" aria-controls="config" role="tab" data-toggle="tab">Config</a></li> -->
        <li role="presentation" class="active"><a href="#users" aria-controls="users" role="tab" data-toggle="tab">Users</a></li>
        <li role="presentation"><a href="#addons" aria-controls="addons" role="tab" data-toggle="tab">Addons</a></li>
        <!-- <li role="presentation"><a href="#roles" aria-controls="roles" role="tab" data-toggle="tab">Roles</a></li> -->
        </ul>
        <div class="tab-content">
            <!-- Config
            <div role="tabpanel" class="tab-pane active" id="config">
                % include('admin_tab_config.tpl', title='Top')
            </div> -->
            <!-- Users -->
            <div role="tabpanel" class="tab-pane active" id="users">
                % include('admin_tab_users.tpl', title='Top')
            </div>
            <!-- Roles
            <div role="tabpanel" class="tab-pane" id="users">
                % include('admin_tab_roles.tpl', title='Top')
            </div>-->

           <!-- Addons -->
            <div role="tabpanel" class="tab-pane" id="addons">
                % include('admin_tab_addons.tpl', title='Top')
            </div>
        </div>
    </div>
</div>
% include('footer.tpl', title='Bottom')
