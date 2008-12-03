require "fileutils"
RAILS_ROOT||='../../../'
sourcedir="#{RAILS_ROOT}/vendor/plugins/tree"
 
%w(/public/javascripts/tree.js /public/stylesheets/tree.css /lib/node.rb /lib/tree.rb /lib/instanceoptions.rb).each do |f|
  FileUtils.cp("#{sourcedir}#{f}", "#{RAILS_ROOT}#{f}")
end

FileUtils.mkdir_p("#{RAILS_ROOT}/public/images/tree") unless File.exist? "#{RAILS_ROOT}/public/images/tree"
FileUtils.cp(Dir.glob(sourcedir+'/public/images/tree/*.*') , "#{RAILS_ROOT}/public/images/tree")

