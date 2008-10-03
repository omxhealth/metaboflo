require 'test_helper'

class PatientTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_name
    assert_equal 'Joe F Shmoe', patients(:one).name
    
    assert_equal '', Patient.new(:first_name => '', :last_name => '').name
    
    assert_equal 'Jim Bo', Patient.new(:first_name => 'Jim', :last_name => 'Bo').name
  end
end
