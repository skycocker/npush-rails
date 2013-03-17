module Npush
  class ToherokuGenerator < Rails::Generators::Base
    def clone_npush_repo
      @appname = Rails.application.class.parent_name
      @reponame = 'npush' + @appname.to_s.downcase
      @npush_secret = SecureRandom.base64
      @npush_server = 'http://' + @reponame + '.herokuapp.com'
      @listen_port = "80";
      
      in_root do
        git :clone => "git://github.com/skycocker/npush.git"
        inside "npush" do
          create_file 'config.json' do
            "{\n"+
            '  "npush_secret": "' + @npush_secret + '",' + "\n"+
            '  "port": "' + @listen_port + '"' + "\n"+
            '}'
          end
          system 'heroku create ' + @reponame
          system 'git push heroku master'
          system 'heroku config:add listen_port=' + @listen_port + ' npush_secret=' + @npush_secret
        end
        
        inside "config/initializers" do
          create_file 'npush.rb' do
            "unless Rails.env.production?\n"+
            "  ENV['npush_server'] = '" + @npush_server + "'\n"+
            "  ENV['npush_secret'] = '" + @npush_secret + "'\n"+
            "end\n"
          end
        end
        
        #to vendor :p
        inside "app/assets/javascripts" do
          create_file 'npush.js' do
            "window.npush = io.connect('" + @npush_server + ':' + @listen_port + "');\n"
          end
        end
        
        prepend_file 'app/assets/javascripts/application.js', "//= require socket.io.min.js\n"
      end
    end
  end
end
