require 'test_helper'

class SampleTest < ActiveSupport::TestCase
  test "aliquot cannot have client" do
    sample = Sample.new(:sample => samples(:one), :client => clients(:one))
    sample.valid?
    assert sample.errors[:client_id].any?
  end
  
  test "set_test_subject_id" do
    parent_sample = Sample.new(:test_subject => test_subjects(:one))
    sample = Sample.new
    assert sample.test_subject_id.blank?
    sample.sample = parent_sample
    sample.valid?
    assert_not_nil sample.test_subject_id
    assert_equal parent_sample.test_subject_id, sample.test_subject_id
  end
  
  test "test_subject_id equal to test_subject_id of parent sample" do
    parent_sample = Sample.new(:test_subject => test_subjects(:one), :barcode => '12344')
    sample = Sample.new(:test_subject => test_subjects(:two), :sample => parent_sample, :barcode => '123441')
    assert !sample.valid?
    
    sample.test_subject = test_subjects(:one)
    assert sample.valid?
    
    sample.sample.test_subject = test_subjects(:two)
    assert !sample.valid?
  end
  
  test "taken_on" do
    #Birthdate == taken_on
    sample = Sample.new(:collected_on => test_subjects(:one).birthdate, :test_subject => test_subjects(:one), :barcode => '123455')
    assert sample.valid?
    
    #Birthdate > taken_on
    sample.collected_on = test_subjects(:one).birthdate - 1
    assert !sample.valid?
    assert sample.errors[:collected_on].any?

    #Birthdate < taken_on
    sample.collected_on = test_subjects(:one).birthdate + 1
    assert sample.valid?


    #When taken_on is nil, still valid
    sample = Sample.new
    sample.valid?
    assert !sample.errors[:collected_on].any?

    sample.test_subject = test_subjects(:one)
    sample.valid?
    assert !sample.errors[:collected_on].any?

    sample.collected_on = test_subjects(:one).birthdate
    
    #When birthdate is nil, still valid
    sample.test_subject.birthdate = nil
    sample.valid?
    assert !sample.errors[:collected_on].any?
  end
  
  test "root" do
    assert_equal test_subjects(:one), samples(:one).root
    assert_equal test_subjects(:one), samples(:four).root
  end
  
  test "theoretical_amount" do
    parent = Sample.new(:original_amount => 10.5, :original_unit => 'ml')
    parent.samples << Sample.new(:original_amount => 5.4, :original_unit => 'ml')
    parent.samples << Sample.new(:original_amount => 4.1, :original_unit => 'ml')
    assert (1.0 - parent.theoretical_amount).abs < 1E-7
    
    parent.samples << Sample.new(:original_amount => 0.3, :original_unit => 'g')
    assert (0.7 - parent.theoretical_amount).abs < 1E-7
    
    parent.samples << Sample.new(:original_amount => 2.2, :original_unit => 'ml')
    assert (-1.5 - parent.theoretical_amount).abs < 1E-7
  end
end
