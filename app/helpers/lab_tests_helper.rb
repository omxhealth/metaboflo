module LabTestsHelper
  
  def tests(lab_test, include_blank = false)
    tests = []
    
    lab_test.attributes.each do |key, value|
      #Count the number of non-blank values:
      if (key.include?('_value'))
        if (include_blank or not value.blank?)
          tests << key.sub('_value', '')
        end
      end
    end
    
    tests
  end  
end

