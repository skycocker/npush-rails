#npush-rails - Rails plugin for [npush](https://github.com/skycocker/npush)
###Implement push notifications in your Rails app in less than a minute

##Installation
Add npush-rails to your Gemfile

    gem 'npush-rails', git: 'git://github.com/skycocker/npush-rails.git'
    
and then run

    bundle install
    
**Before going to the next step make sure you have [git](http://git-scm.com/) and [heroku toolbelt](https://toolbelt.heroku.com/) installed and configured.**

Now the coolest part - run

    rails generate npush:toheroku
    
And that's it - congratulations, you have just setup push notifications in your Rails app! :)

##What will this generator do?
**It will:**

1. Clone my [npush](https://github.com/skycocker/npush) repo to the root directory of your app
2. Create your own Heroku repository named "npush(yourappname)" and push contents of cloned in the previous step repo to it, along with setting proper variables
3. Create "npush.rb" file inside config/initializers directory of your app filled with proper settings matching set in previous step Heroku variables
4. Add created "config/initializers/npush.rb" file to gitignore in the root of your app (because of the authorization secret inside)
5. Create "npush.js" file inside app/assets/javascripts directory of your app filled with socket.io initialization code
6. Prepend requisition of socket.io.min.js to your app/assets/javascripts/application.js

**Make sure to set**

    ENV['npush_server']
    ENV['npush_secret']
    
**matching development equivalents from npush.rb initializer somewhere in your production environment - on Heroku you probably want to do it by running**

    heroku config:add npush_server=(server address here)
    heroku config:add npush_secret=(secret here)
    
**inside the root directory of your app.**

##Usage
###Client
Now you can use **window.npush** anywhere in your javascript as a standard [socket.io](http://socket.io/) object - for example

    var socket = window.npush;
    socket.on('connection', function() {
      console.log("connected :)");
    });

####npush comes up with some cool methods you can run from your client!
**join channel**

    socket.emit('join channel', { channel: 'Donald Duck news feed updates' });
    socket.on("Donald woke up", function(data) {
      alert(data);
    });
    
**set id**

    socket.emit('set id', { id: window.user.id });
    socket.on("new message", function(data) {
      alert(data);
    });

###Server
####in your Rails controller

    Npush.broadcast "Donald Duck news feed updated", "Donald woke up", "Donald woke up at 11 am today!"
    
####or if you want to send push to a specific user

    Npush.push "user-id-goes-here", "new message", "it's still snowing in April :/"
    
##How to remove Npush from my app?
Simply run

    rails d npush:toheroku
    
**Keep in mind it will not delete the created Heroku repo. It will also leave npush folder in the root directory of your application untouched - you can**

    rm -rf npush
    
**from the root of your app in order to get rid of it.**
