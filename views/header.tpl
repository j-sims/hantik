<!-- Header -->
<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Hantik Starter App">
    <meta name="author" content="Jim Sims">
    <link rel="shortcut icon" href="">
    % include('css.tpl', title='Top')
    % include('js.tpl', title='Top')
    <style>body{padding-top:50px;}.starter-template{padding:40px 15px;text-align:center;}</style>

    <!--[if IE]>
        <script src="/js/html5shiv.min.js"></script>
        <script src="/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="/">Hantik</a>
                </div>
                <div id="navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="/about">About</a></li>
                        % if role != "":
                        <!-- Dynamic Addon Menu -->
                        % for a in addons:
                        <!-- {{a}} -->
                        % for k, v in addonmenus[a].iteritems():
                        % if len(v.keys()) == 1:
                        % for key, value in v.iteritems():
                        <li><a href="/{{a}}{{value}}">{{key}}</a></li>
                        % end
                        % elif len(v.keys()) > 1:
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                {{k}}
                                <b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu">
                            % for key, value in v.iteritems():
                                <li><a href="/{{a}}{{value}}" target="_blank">{{key}}</a></li>
                            % end
                            </ul>
                        </li>
                        % end
                        % end
                        % end
                        % end
                        <!-- End Dynamic Addon Menu -->
                        % if role == "admin":
                        <li><a href="/admin">Admin</a></li>
                        % end
                        % if role != "":
                        <li><a href="/logout">Logout</a></li>
                        % else:
                        <li><a href="/login">Login</a></li>
                        % end
                        <li><a href="/help">Help</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                    </ul>
                </div>
            </div>
        </nav>

<!-- End Header -->
