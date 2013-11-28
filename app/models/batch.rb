class Batch < ActiveRecord::Base
  has_many :samples

  accepts_nested_attributes_for :samples, :allow_destroy => true, :reject_if => proc { |attributes| attributes[:data].blank? }

  validates :name, :presence => true
end
