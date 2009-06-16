class Concentration < ActiveRecord::Base
  belongs_to :data_file
  belongs_to :metabolite
  
  validates_presence_of :data_file_id, :metabolite_id
end
