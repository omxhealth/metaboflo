require 'test_helper'

class PatientTest < ActiveSupport::TestCase
  def test_name
    assert_equal 'J F S', patients(:one).name
    assert_equal '', Patient.new(:first_initial => '', :last_initial => '').name
    assert_equal 'J B', Patient.new(:first_initial => 'J', :last_initial => 'B').name
  end
end
