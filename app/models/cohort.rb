class Cohort < ActiveRecord::Base
  ALLOWED_CONTROL_VALUES = [ 'Not Applicable', 'Yes', 'No']

  belongs_to :study
  has_many :cohorts_test_subjects, dependent: :destroy
  has_many :test_subjects, through: :cohorts_test_subjects

  validates_presence_of :label
  validates_inclusion_of :control, in: ALLOWED_CONTROL_VALUES, allow_blank: true

  accepts_nested_attributes_for :cohorts_test_subjects, allow_destroy: true, reject_if: :all_blank
end
