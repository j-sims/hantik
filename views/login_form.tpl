% include('header.tpl', title='header')
<div class="container">
    <div>
        <h2>Login</h2>
        <p>Please insert your credentials:</p>
        <form action="login" method="post" name="login">
            <input type="text" name="username" />
            <input type="password" name="password" />
            <br/><br/>
            <button type="submit" class="btn btn-default btn-xs"> OK </button>
            <button type="reset" class="btn btn-default btn-xs"> Cancel </button>
        </form>
        <br />
    </div>
</div>  
% include('footer.tpl', title='footer')
