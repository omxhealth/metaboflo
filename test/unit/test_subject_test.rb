require 'test_helper'

class TestSubjectTest < ActiveSupport::TestCase
  test "samples vs child_samples" do
    assert_equal 3, test_subjects(:one).samples.count
    assert_equal 2, test_subjects(:one).child_samples.count
  end
end
