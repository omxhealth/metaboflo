class Sample < ActiveRecord::Base
  SAMPLE_TYPES = SUBJECT_CONFIG[:sample_types].freeze

  scope :location_cont,
    ->(name) { where('building LIKE :name OR room LIKE :name', name: "%#{name}%") }

  belongs_to :batch
  belongs_to :client
  belongs_to :test_subject
  belongs_to :sample
  belongs_to :site

  belongs_to :collected_by, class_name: 'User'
  belongs_to :prepped_by, class_name: 'User'
  belongs_to :protocol

  has_many :samples, dependent: :destroy
  has_many :experiments, dependent: :destroy

  has_many :grouping_assignments, as: :assignable, dependent: :destroy
  has_many :groupings, through: :grouping_assignments

  has_many :corrections, dependent: :destroy
  accepts_nested_attributes_for :corrections, allow_destroy: true

  has_many :stored_files, as: :attachable
  accepts_nested_attributes_for :stored_files, allow_destroy: true

  before_validation :assign_parent_type
  before_validation :set_test_subject_id

  validates :original_amount, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :actual_amount, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :barcode, presence: true

  validate :sample_chronology
  validate :same_parent?
  validate :client_blank?

  validate :preparations, if: :preparing_sample?
  attr_accessor :preparing

  def self.sample_types
    pluck('sample_type').uniq.sort
  end

  def self.ransackable_scopes(auth_object = nil)
    %i(location_cont)
  end

  def preparing_sample?
    preparing
  end

  def preparations
    valid = true

    if self.dss_concentration.blank?
      valid = false
      errors.add(:dss_concentration, "can not be blank")
    end

    if self.dss_lot.blank?
      valid = false
      errors.add(:dss_lot, "can not be blank")
    end

    if self.protocol.blank?
      valid = false
      errors.add(:protocol, "can not be blank")
    end

    return valid
  end

  # Required so that Experiments, Samples, and TestSubjects can be displayed in groupings
  def to_s
    return "#{self.barcode.blank? ? 'No barcode' : self.barcode} (#{sample_type.blank? ? 'No sample type' : sample_type} - #{original_amount.blank? ? 'Unknown amount' : "#{original_amount} #{original_unit}"})"
  end

  def to_label
    to_s
  end

  # sample takes precedence over test subject
  def parent
    sample || test_subject
  end

  def aliquot?
    sample.present?
  end

  def root_sample
    aliquot? ? sample.root_sample : self
  end

  def root
    test_subject
  end

  # Returns true if this sample contains at least one sample location value
  def location_information?
    [:site, :building, :room, :freezer, :shelf, :box, :box_position].detect { |l| self.send(l).present? }
  end

  # calculates the theoretical amount of this sample = original amount - sum(original amount of each child)
  #
  # assumes that original_unit for this sample and all children are the same
  def theoretical_amount
    theoretical = self.original_amount.to_f
    self.samples.each do |child|
      theoretical -= child.original_amount.to_f
    end
    theoretical
  end

  private

  def assign_parent_type
    self.sample_type = self.sample.sample_type if self.sample
  end

  # if test subject is nil, sets the test subject to that of parent sample if parent sample exists
  def set_test_subject_id
    self.test_subject_id = self.sample.test_subject_id if self.test_subject_id.blank? && !self.sample.nil?
  end

  def sample_chronology
    if (test_subject && test_subject.birthdate && collected_on && test_subject.birthdate > collected_on)
      errors.add(:collected_on, "for sample cannot be before the #{TestSubject.title}'s birthdate")
    end
  end

  def same_parent?
    if self.sample && self.sample.test_subject_id != self.test_subject_id
      errors.add(:test_subject_id, "is not the same as that of parent sample")
    end
  end

  def client_blank?
    errors.add(:client_id, "cannot be set for aliquots") if !self.sample_id.blank? && !self.client_id.blank?
  end
end
