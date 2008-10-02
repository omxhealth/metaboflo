class Sample < ActiveRecord::Base
  belongs_to :patient
  # belongs_to :taken_by, :class_name => 'User', :foreign_key => 'taken_by_id'
end
