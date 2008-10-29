module PatientEvaluationsHelper
  
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
  
  def list_string(list)
    if list.length == 0
      return ''
    end
      
    str = ''
    list.each do |l|
      if str.length == 0
        str += l
      else
        str += ", #{l}"
      end
    end
    return str
  end
  
  def check_boxes(num_per_row, param_str, valid_list, model_has_list)
    count = 0
    out = "<table border=0 cellpadding=3 cellspacing=3><tr>"
    valid_list.each do |c|
  	  if count % num_per_row == 0
        out += "</tr><tr>"
  	  end
      count += 1

  	  out += "<td>"
      out += "<input type=\"checkbox\" name=\"#{param_str}\" value=\"#{c}\""
  	  if model_has_list.include?(c)
  	    out += 'checked="checked"'
  	  end
  	  
  	  out += "/>#{c}"
      out += "</td>"
    end
    out += "</tr></table>"
  end
end
