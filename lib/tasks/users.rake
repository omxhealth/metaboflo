namespace :db do
  namespace :users do
    desc 'Destroy all existing users and load initial users.'
    task :initialize => [:environment] do |t|
      User.transaction do
        User.destroy_all

        admin = User.new(:login => 'admin', :email => 'info@gchelpdesk.ualberta.ca', :password => 'adminadmin', :password_confirmation => 'adminadmin', :rank => 'Administrator')
        admin.save!
      end
    end
  end
end
