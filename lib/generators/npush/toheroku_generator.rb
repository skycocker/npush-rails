module Npush
  class ToherokuGenerator < Rails::Generators::Base
    def clone_npush_repo
      @appname = Rails.application.class.parent_name
      @reponame = @appname.to_s.downcase
      
      in_root do
        git :clone => "git://github.com/skycocker/npush.git"
        inside "npush" do
          system 'echo "'+@reponame+'"'
        end
      end
    end
  end
end
