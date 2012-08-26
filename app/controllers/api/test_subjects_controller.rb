class Api::TestSubjectsController < Api::BaseController
  before_filter :find_test_subject, :only => [ :tree ]

  def tree
    
  end

  protected
  def find_test_subject(param_name = :id)
    super
  end
end
