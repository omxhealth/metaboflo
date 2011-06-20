class CohortsTestSubject < ActiveRecord::Base
  belongs_to :cohort
  belongs_to :test_subject
end
