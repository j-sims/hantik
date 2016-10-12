#!/usr/bin/env python
#### Imports
from bottle import Bottle, run, mount, route, TEMPLATE_PATH, post, get, view, template, static_file, request, debug, hook, response
from beaker.middleware import SessionMiddleware
from cork import Cork
import logging
from json import dumps
import sys
import commands
from datetime import datetime
import os
import re

# Logging First!
logging.basicConfig(format='localhost - - [%(asctime)s] %(message)s', level=logging.DEBUG)
log = logging.getLogger("bottle")

# Basic Vars
INSTALLDIR = '/app'
APPDIR = INSTALLDIR #+ '/bottle' #os.path.dirname(sys.argv[0])
TEMPLATE_PATH.insert(0, APPDIR +'/views')
dbfile = APPDIR + '/bottle.db'
d = {}
aaa = Cork(APPDIR + '/auth')

__version__ = '0.9.0'
osversion = commands.getoutput('uname') + " " + commands.getoutput('uname -r')

d['version'] = __version__
d['osversion'] = osversion

# Enable bottle debug logging - is this even useful?
debug(True)

# Create Bottle instance
rootapp = Bottle()

#### Dynamically import addons
import importdir, glob
addons = []
addonmenus = {}
addondescriptions = {}

if not os.path.exists(APPDIR +'/addons/'):
    os.mkdir(APPDIR +'/addons/')

for i in glob.glob(os.path.dirname(APPDIR +'/addons/')+"/*/"):
    try:
        importdir.do(i, globals())
        addons.append(os.path.split(os.path.realpath(i))[1])
        modulename = addons[-1]
        rootapp.mount('/'+modulename, eval((modulename + '.app')))
    except Exception, err:
        log.error("Error importing module: %s" % err)

# Build Addon menu
for a in addons:
    try:
        addonmenus[a] = eval(a).menuitems()
        addondescriptions[a] = eval(a).describe()
    except Exception, err:
        log.error("Error importing %s: %s" %(a, err))

d['addonmenus'] = addonmenus
d['addons'] = addons
d['addondescriptions'] = addondescriptions

#### ugly config file needed for shellscripts
configfile = APPDIR + '/config'
f = open(configfile, 'r')
c = f.readlines()
f.close()
config = {}

for line in c:
    if not re.match("^#",line):
        key, value = line.split('=')
        config[key] = value.replace('"', '').strip('\n')

d['config'] = config

# Sessions Settings
session_opts = {
    'session.cookie_expires': True,
    'session.encrypt_key': 'laskdjrl;kq23j409adsufasnfl;iw34u590asufgokfl;kqweu4589q3ful;adksfj;dks',
    'session.httponly': True,
    'session.timeout': 3600,   # 1 hour
    'session.type': 'cookie',
    'session.validate_key': True }
#### END STARTUP

#### Functional methods
# The intent is to strip off the right slash from urls before routing, doesn't seem to be effective
#@hook('before_request')
#def strip_path():
#    request.environ['PATH_INFO'] = request.environ['PATH_INFO'].rstrip('/')

class fix_https(object):
  def __init__(self, app):
      self.app = app
  def __call__(self, e, h):
    e['wsgi.url_scheme'] = 'https'
    return self.app(e, h)

def unzip(zipName):
    from zipfile import ZipFile as zip
    z = zip(zipName)
    for f in z.namelist():
        if f.endswith('/'):
            os.makedirs(f)
        else:
            z.extract(f)

###
@rootapp.route('/')
def home():
    if os.path.exists(APPDIR + '/firstrun'):
        return template('install_wizard')
    if not aaa.user_is_anonymous:
        d['role'] = aaa.current_user.role
    else:
        d['role'] = ''
    return template('home', **d)

@rootapp.route('/help')
def help():
    if not aaa.user_is_anonymous:
        d['role'] = aaa.current_user.role
    else:
        d['role'] = ''
    return template('help', **d)

@rootapp.route('/faq')
def faq():
    if not aaa.user_is_anonymous:
        d['role'] = aaa.current_user.role
    else:
        d['role'] = ''
    return template('faq', **d)

@rootapp.route('/about')
def about():
    if not aaa.user_is_anonymous:
        d['role'] = aaa.current_user.role
    else:
        d['role'] = ''
    return template('about', **d)

@rootapp.route('/login')
def login_form():
    if os.path.exists(APPDIR + '/firstrun'):
        return template('install_wizard')
    if not aaa.user_is_anonymous:
        d['role'] = aaa.current_user.role
    else:
        d['role'] = ''
    return template('login_form', **d)

@rootapp.post('/install_wizard')
def install_wizard():
    username = 'admin'
    user = aaa.user(username)
    tstamp = str(datetime.utcnow())
    aaa._store.users[username] = {
        'role': "admin",
        'hash': aaa._hash(username, postd().password),
        'email_addr': username + '@localhost.local',
        'desc': username,
        'creation_date': tstamp
    }
    aaa._store.save_users()
    os.remove(APPDIR + '/firstrun')
    return { "success" : True, "msg" : "Password Set Successfully" }

@rootapp.route('/example')
def example():
    filename = 'example.zip'
    return static_file(filename, root=APPDIR, download=filename)

#### Administration tasks
@rootapp.route('/admin')
def admin():
    aaa.require(role='admin', fail_redirect='/login')
    d['current_user'] = aaa.current_user
    d['users'] = aaa.list_users()
    d['roles'] = aaa.list_roles()
    d['role'] = aaa.current_user.role
    return template('admin_page', **d)

@rootapp.route('/changepass')
def changepass():
    aaa.require(role='admin', fail_redirect='/login')
    return template('setpass')

@rootapp.route('/sorry_page')
def sorry_page():
    """Serve sorry page"""
    return '<p>Sorry, this action requires the admin role. Please relogin as admin.</p>'

@rootapp.post('/create_user')
def create_user():
    aaa.require(role='admin', fail_redirect='/login')
    try:
        log.info(postd().username)
        log.info(postd().role)
        aaa.create_user(postd().username, postd().role, postd().password)
        log.info('Success Creating User: %s,%s' % (postd().username, postd().role))
        return { "success" : True, "msg" : "User Created Successfully" }
    except Exception, e:
        log.error('Error creating user: %s - %s,%s' % (e, postd().username, postd().role))
        return dict(success=False, msg=e.message)

@rootapp.route('/delete_user')
def delete_user():
    log.info("Delete User")
    aaa.require(role='admin', fail_redirect='/login')
    user  = request.query.user
    try:
        aaa.delete_user(request.query.user)
        log.info("Deleted User: %s" % request.query.user)
        response.status = 303
        response.set_header('Location', '/admin')
        return
    except Exception, e:
        return { "success" : False, "msg" : e.message }

# api
def postd():
    return request.forms

def post_get(name, default=''):
    return request.POST.get(name, default).strip()

@rootapp.post('/login')
def login():
    """Authenticate users"""
    username = post_get('username')
    password = post_get('password')
    aaa.login(username, password, success_redirect='/', fail_redirect='/login')

@rootapp.route('/user_is_anonymous')
def user_is_anonymous():
    if aaa.user_is_anonymous:
        return 'True'
    return 'False'

@rootapp.route('/logout')
def logout():
    aaa.logout(success_redirect='/login')

@rootapp.post('/upload')
def do_upload():
    aaa.require(role='admin', fail_redirect='/login')
    upload = request.files.get('upload')
    name, ext = os.path.splitext(upload.filename)
    if ext not in ('.zip'):
        return 'File extension not allowed.'
    save_path = APPDIR + '/addons'
    if not os.path.exists(save_path):
        os.mkdir(save_path)
    if os.path.exists(save_path + '/' + upload.filename):
        os.unlink(save_path + '/' + upload.filename)
    upload.save(save_path)
    os.chdir(APPDIR + '/addons')
    if os.path.exists(APPDIR + '/addons/' + name):
        import shutil
        shutil.rmtree(APPDIR + '/addons/' + name)
    unzip(save_path + '/' + upload.filename)
    os.unlink(save_path + '/' + upload.filename)
    response.status = 303
    response.set_header('Location', '/autorestart')

@rootapp.post('/deleteaddon')
def deleteaddon():
    aaa.require(role='admin', fail_redirect='/login')
    addon = postd().addon
    log.debug("Removing Addon: " + addon)
    if addon in addons:
        addon = addon
        import shutil
        path = APPDIR + '/addons' + '/' + addon
        if os.path.exists(path) and path != '' and len(os.listdir(path)) > 0:
            shutil.rmtree(path)
            log.debug('Success removing the addon')
    else:
        log.error("Addon not found: " + addon)
    return { 'success' : "ok" }

@rootapp.route('/removeaddon')
def removeaddon():
    aaa.require(role='admin', fail_redirect='/login')
    d['addon'] = request.query.addon
    return template('removeaddon', **d)

@rootapp.route('/dorestart')
def dorestart():
    aaa.require(role='admin', fail_redirect='/login')
    output = commands.getoutput('touch %s/app.py' % APPDIR)
    return { "success" : True }

@rootapp.route('/restart')
def restart():
    aaa.require(role='admin', fail_redirect='/login')
    if not aaa.user_is_anonymous:
        d['role'] = aaa.current_user.role
    else:
        d['role'] = ''
    return template('restart', **d)

@rootapp.route('/autorestart')
def restart():
    aaa.require(role='admin', fail_redirect='/login')
    if not aaa.user_is_anonymous:
        d['role'] = aaa.current_user.role
    else:
        d['role'] = ''
    return template('autorestart', **d)

@rootapp.post('/setpass')
def setpassword():
    aaa.require(role='admin', fail_redirect='/login')
    user = aaa.user(postd().username)
    tstamp = str(datetime.utcnow())
    aaa._store.users[postd().username] = {
        'role': user.role,
        'hash': aaa._hash(postd().username, postd().password),
        'email_addr': postd().username + '@localhost.local',
        'desc': postd().username,
        'creation_date': tstamp
    }
    aaa._store.save_users()

# Static pages
@rootapp.route('/css/<filename>')
def css(filename):
    return static_file(filename, root=APPDIR +'/static/css')

@rootapp.route('/js/<filename>')
def js(filename):
    return static_file(filename, root=APPDIR +'/static/js')

@rootapp.route('/fonts/<filename>')
def fonts(filename):
    return static_file(filename, root=APPDIR +'/static/fonts/')

@rootapp.route('/images/<filename>')
def images(filename):
    return static_file(filename, root=APPDIR +'/static/images/')

#### Main
def main():
    run(host='0.0.0.0', port=80, app=rootapp, reloader=True)

rootapp = SessionMiddleware(rootapp, session_opts)

if __name__ == "__main__":
    main()
