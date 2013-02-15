class NpushGenerator < Rails::Generators::Base
  def clone_npush_repo
    in_root do
      git :clone => "git://github.com/skycocker/npush.git"
      inside "npush" do
        
      end
    end
  end
end
