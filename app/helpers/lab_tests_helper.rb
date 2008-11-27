module LabTestsHelper
  
  def num_tests(lab_test)
    num = 0
    
    lab_test.attributes.each do |key, value|
      #Count the number of non-blank values:
      if (key.include?('_value') and not value.blank?)
        num += 1
      end
    end
    num
  end
  
end
