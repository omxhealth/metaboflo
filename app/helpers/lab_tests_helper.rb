module LabTestsHelper
  
  def num_tests(lab_test)
    num = 0
    lab_test.attributes.each do |att|
      if att.include?('_value')
        num += 1
      end
    end
    num
  end
  
end
