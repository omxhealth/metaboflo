class CohortPatientsController < ApplicationController
  before_filter :find_cohort
  
  def edit
    @patients = Patient.find(:all)
  end

  def update
    if params[:patients]
      new_patient_ids = params[:patients]
    else
      new_patient_ids = []
    end
    
    prev_patient_ids = @cohort.patients.collect do |p| p.id.to_s end
    
    patients_to_remove = prev_patient_ids - new_patient_ids
    patients_to_add = new_patient_ids - prev_patient_ids

    CohortAssignment.transaction do
      
      CohortAssignment.destroy_all(["cohort_id = ? and patient_id in (?)", @cohort.id, patients_to_remove.join(',') ])
      
      patients_to_add.each do |patient_id|
        CohortAssignment.create(:cohort_id => @cohort.id, :patient_id => patient_id)
      end
      
    end
    
    redirect_to cohort_path(@cohort)
  end
  
  private
  def find_cohort
    @cohort = Cohort.find(params[:cohort_id])
  end

end
