require 'test_helper'

class AnimalTest < ActiveSupport::TestCase
  def test_name
    assert_equal 'J F S', animals(:one).name
    assert_equal '', Animal.new(:first_initial => '', :last_initial => '').name
    assert_equal 'J B', Animal.new(:first_initial => 'J', :last_initial => 'B').name
  end
end
