module Npush
  class ToherokuGenerator < Rails::Generators::Base
    def clone_npush_repo
      @appname = Rails.application.class.parent_name
      @reponame = 'npush' + @appname.to_s.downcase
      @npush_secret = SecureRandom.base64
      @npush_server = 'http://' + @reponame + '.herokuapp.com/'
      
      in_root do
        git :clone => "git://github.com/skycocker/npush.git"
        inside "npush" do
          create_file 'config.json' do
            "{\n"+
            '  "npush_secret": "' + @npush_secret + '",' + "\n"+
            '  "port": "80"' + "\n"+
            '}'
          end
          #system 'heroku create ' + @reponame
        end
        inside "config/initializers" do
          create_file 'npush.rb' do
            "unless Rails.env.production?\n"+
            "  ENV['npush_server'] = '" + @npush_server + "'\n"+
            "  ENV['npush_secret'] = '" + @npush_secret + "'\n"+
            "end\n"
          end
        end
      end
    end
  end
end
