class Correction < ActiveRecord::Base
  belongs_to :sample

  validates :initial_ph, presence: true
  validates :final_ph, presence: true
  validates :buffer_amount, presence: true
end
