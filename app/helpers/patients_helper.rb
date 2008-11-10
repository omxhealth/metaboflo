module PatientsHelper

  def BMI(height, weight)
    bmi = weight * 703 #weight in pounds * 703
    bmi = bmi / (height**2) #divided by height in inches squared
    if bmi < 18.5
      status = 'Underweight'
    elsif bmi < 24.9
      status = 'Normal'
    elsif bmi < 29.9
      status = 'Overweight'
    else
      status = 'Obese'
    end
    
    "#{bmi} (#{status})"
  end

end
