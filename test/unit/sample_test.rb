require 'test_helper'

class SampleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_taken_on
    #Birthdate == taken_on
    sample = Sample.new(:collected_on => test_subjects(:one).birthdate, :test_subject => test_subjects(:one))
    assert sample.valid?
    
    #Birthdate > taken_on
    sample.collected_on = test_subjects(:one).birthdate - 1
    assert !sample.valid?
    assert sample.errors.invalid?(:collected_on)

    #Birthdate < taken_on
    sample.collected_on = test_subjects(:one).birthdate + 1
    assert sample.valid?


    #When taken_on is nil, still valid
    sample = Sample.new
    sample.valid?
    assert !sample.errors.invalid?(:collected_on)

    sample.test_subject = test_subjects(:one)
    sample.valid?
    assert !sample.errors.invalid?(:collected_on)

    sample.collected_on = test_subjects(:one).birthdate
    
    #When birthdate is nil, still valid
    sample.test_subject.birthdate = nil
    sample.valid?
    assert !sample.errors.invalid?(:collected_on)
  end
  
  def test_root
    assert_equal test_subjects(:one), samples(:one).root
    assert_equal test_subjects(:one), samples(:four).root
  end
  
  def test_theoretical_amount
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
