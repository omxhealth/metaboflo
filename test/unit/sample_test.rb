require 'test_helper'

class SampleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_taken_on
    #Birthdate == taken_on
    sample = Sample.new(:taken_on => patients(:one).birthdate, :patient => patients(:one))
    assert sample.valid?
    
    #Birthdate > taken_on
    sample.taken_on = patients(:one).birthdate - 1
    assert !sample.valid?
    assert sample.errors.invalid?(:taken_on)

    #Birthdate < taken_on
    sample.taken_on = patients(:one).birthdate + 1
    assert sample.valid?


    #When taken_on is nil, still valid
    sample = Sample.new
    sample.valid?
    assert !sample.errors.invalid?(:taken_on)

    sample.patient = patients(:one)
    sample.valid?
    assert !sample.errors.invalid?(:taken_on)

    sample.taken_on = patients(:one).birthdate
    
    #When birthdate is nil, still valid
    sample.patient.birthdate = nil
    sample.valid?
    assert !sample.errors.invalid?(:taken_on)
  end
  
end
