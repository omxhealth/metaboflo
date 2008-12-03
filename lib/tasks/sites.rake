namespace :db do
  namespace :sites do
    desc 'Destroy all existing sites and load initial sites.'
    task :initialize => [:environment] do |t|
      Site.destroy_all

      [ 'The University of Alberta', 'Duke University' ].each do |name|
        site = Site.new(:name => name)
        site.save!
      end
    end
  end
end
