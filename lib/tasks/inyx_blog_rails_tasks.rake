require File.expand_path('../../inyx_blog_rails/tasks/install', __FILE__)

namespace :blog do
	desc "Copiar inicializador para la configuración"
	task :copy_initializer do
		InyxBlogRails::Tasks::Install.copy_initializer_file
	end

  desc "Copiar vistas al proyecto"
  task :copy_views do
    InyxBlogRails::Tasks::Install.copy_view_files
  end
end