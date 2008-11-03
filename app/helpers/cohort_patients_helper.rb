module CohortPatientsHelper
  
  def patient_check_boxes(num_per_row, param_str, patient_list, model_has_list)
    count = 0
    out = "<table border=0 cellpadding=3 cellspacing=3><tr>"
    patient_list.each do |p|
  	  if count % num_per_row == 0
        out += "</tr><tr>"
  	  end
      count += 1

  	  out += "<td>"
  	  out += check_box_tag(param_str, p.id, model_has_list.include?(p))
  	  
  	  out += p.name
      out += "</td>"
    end
    out += "</tr></table>"
  end
  
end
