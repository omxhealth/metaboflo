class Concentration < ActiveRecord::Base
  belongs_to :data_file
  belongs_to :metabolite
end
