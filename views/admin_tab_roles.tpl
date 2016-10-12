
                <div class="container">
                    <div class="row">
                        <div id="createrole" class="col-xs-6">
                            <h4>Create new role:</h4>
                            <form action="create_role" method="post">
                                <p><label>Role</label> <input type="text" name="role" /></p>
                                <p><label>Level</label> <input type="text" name="level" /></p>
                                <button type="submit" > OK </button>
                                <button type="button" > Cancel </button>
                            </form>
                        </div>
                        <p></p>
                        <div id="roletable" class="col-xs-6">
                            <table width="180">
                                <tr><th>Role</th><th>Level</th></tr>
                                %for r in roles:
                                <tr><td>{{r[0]}}</td><td>{{r[1]}}</td></tr>
                                %end
                            </table><p></p>
                            <small><i>(Reload page to refresh)</i></small>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div id="deleterole" class="col-xs-6">
                            <h4>Delete role:</h4>
                            <form action="delete_role" method="post">
                                <p><label>Role</label> <input type="text" name="role" /></p>
                                <button type="submit" > OK </button>
                                <button type="button" > Cancel </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

