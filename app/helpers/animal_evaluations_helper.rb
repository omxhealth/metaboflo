module AnimalEvaluationsHelper
  
  def medical_history_list
    ['Cancer', 'Heart problems', 'Asthma', 'Goiter', 'Leukemia', 'Stroke', 'Cataracts', 'Diabetes', 'Epilepsy', 'Nervous breakdown','Stomach ulcers','Rheumatic fever','Bad headaches','Jaundice','Colitis','Kidney disease','Pneumonia','Psoriasis','Anemia','HIV/AIDS','High Blood Pressure','Emphysema','Glaucoma','Tuberculosis']
  end
  
  def symptoms_list
    #Constitutional:
    l = ['recent weight gain', 'recent weight loss', 'fatigue', 'weakness', 'fever']

    #Hematological:
    l += ['swollen glands', 'tender glands', 'anemia', 'bleeding tendency', 'transfusion']
    
    #Cardiovascular:
    l += ['pain in chest', 'irregular heart beat', 'sudden changes in heart beat', 'high blood pressure', 'heart murmers']
    
    #Neurological system:
    l += ['headaches', 'dizziness', 'fainting', 'muscle spasm', 'loss of consciousness', 'sensitivity or pain of hands and/or feet', 'memory loss', 'night sweats']
    
    #Psychiatric:
    l += ['excessive worries', 'anxiety', 'easily lossing temper', 'depression', 'agitation', 'difficulty falling asleep', 'difficulty staying asleep']
  end
  
  def BMI(height, weight)
    if (not height.blank? and not weight.blank?)
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
    else
      ''
    end
  end
  
end
