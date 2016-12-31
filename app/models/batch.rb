class Batch < ActiveRecord::Base
  has_many :samples

  accepts_nested_attributes_for :samples#, :allow_destroy => true, :reject_if => proc { |attributes| attributes[:data].blank? }

  validates :name, :presence => true, uniqueness: true

  # ========= Validations specifically for the pH step =========
  validate :phs, :if => :phing_sample?
  attr_accessor :phing

  def phing_sample?
    phing
  end

  def phs
    valid = true

    self.samples.each do |s|
      if s.corrections.length == 0
        valid = false
        errors.add_to_base("Sample requires at least one pH correction.")
      end
    end

    return valid
  end
  # ========= End of pH validations =========
end
