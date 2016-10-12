                        <div class="col-xs-6">
                            <table width="440">
                                <tr><th>Username</th><th>Role</th><th>Email</th><th>Description</th></tr>
                                %for u in users:
                                <tr><td>{{u[0]}}</td><td>{{u[1]}}</td><td>{{u[2]}}</td><td>{{u[2]}}</td>
                                % if u[0] != "admin":
                                <td><a href="/delete_user?user={{u[0]}}">delete</a></td>
                                % end
                              </tr>
                                %end
                            </table><p></p>
                        </div>
