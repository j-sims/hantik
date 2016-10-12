% include('header.tpl', title='header')
        <div class="container">
            <div class="row">
                <div class="col-md-9" style="padding-left: 2em;">
                    <br>
                    <h1>Frequently Asked Questions</h1>
                    <br>
                    <ul class="list-unstyled"><h4>Support</h4>
                        <hr>
                        <li>Q: Is app "supported"?</li>
                        <li>A: This app is a community developed app and is supported only by volunteer contributors.</li>
                        <br>
                        <li>Q: What is services is the app running?</li>
                        <li>A: The app is built upon an MVC framework comprising of python based code. The app uses a combination of bottle (http://bottlepy.org) for the app server, pound (http://www.apsis.ch/pound/) for the reverse ssl proxy, and sqlite3 for the authentication database. All services are built from open source code and the associated licenses are included in the extract folder.</li>
                        <hr>
                        <h4>Security</h4>
                        <li>Q: How secure is the app? Will it introduce any additional security risk into the environment?</li>
                        <li>A: The app utilizes a combination of strong cryptographic tools to ensure that it does not introduce additional security risk. It is recommended that you operate this app behind an https reverse proxy such as nginx for best results.</li>
                        <br>
                        <li>Q: What do I need to know to create an addon?</li>
                        <li>A: Addons are created with a mixture of  html, css, javascript and a minimum of python.</li>
                        <br>

                        <li>Q: I've got a great idea for an addon. How do I go about creating one?</li>
                        <li>A: You can click <a href="/example">here</a> to download the sample, extract it, rename folder & files, then edit to suit for your purposes. Once your new addon is complete; zip up the directory structure and got to <a href="/admin#config">admin settings</a> to upload it.</li>
                            </table>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
% include('footer.tpl', title='footer')
