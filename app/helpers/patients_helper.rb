module PatientsHelper

  def patient_tree(patient)
    Tree.new(:label => "Patient #{patient.code}", :url => patient_path(patient), :icon_open => tree_icon('patient.png'), :image_path => image_path('tmp').gsub(/\/tmp/, '')) do |tree|
      tree << Node.new(:label => 'Medications', :url => patient_medications_path(patient), :icon_open => tree_icon('medicine.png'))
      tree << Node.new(:label => 'Lab Tests', :url => patient_lab_tests_path(patient), :icon_open => tree_icon('test.png'))
      tree << Node.new(:label => 'Patient Evaluations', :url => patient_patient_evaluations_path(patient), :icon_open => tree_icon('evaluation.png'))

      tree << sample_sub_tree(patient, patient) # Add the samples for this patient
      tree << cohort_sub_tree(patient) # Add the cohorts for this patient
    end
  end

  protected

  def sample_sub_tree(parent, patient)
    samples_url = parent.kind_of?(Patient) ? patient_samples_path(parent) : sample_samples_path(parent)
    label = parent.kind_of?(Patient) ? 'Samples' : 'Aliquots'

    tree = Node.new(:label => label, :url => samples_url) do |node|
      parent.samples.each do |sample|
        sample_url = sample.sample ? sample_sample_path(sample.sample, sample) : patient_sample_path(patient, sample)
        sample_label = sample.sample ? "Aliquot #{sample.id}" : "Sample #{sample.id}"
        sub_samples = Node.new(:label => sample_label, :url => sample_url) do |sub_node|
          sub_node << sample_sub_tree(sample, patient)
          sub_node << experiment_sub_tree(sample) # Add the experiments for this sample
        end
        sub_samples.icon = sub_samples.icon_open = sample.sample ? tree_icon('aliquot.png') : tree_icon('sample.png')
        node << sub_samples
      end
    end

    tree.icon = tree.icon_open = tree_icon('folder.png')
    return tree
  end

  def experiment_sub_tree(sample)
    tree = Node.new(:label => 'Experiments', :url => sample_experiments_path(sample)) do |node|
      sample.experiments.each do |experiment|
        experiment_node = Node.new(:label => experiment.name, :url => sample_experiment_path(experiment.sample, experiment))
        experiment_node.icon = experiment_node.icon_open = tree_icon('experiment.png')
        experiment_node << data_file_sub_tree(experiment)
        node << experiment_node
      end
    end
    tree.icon = tree.icon_open = tree_icon('folder.png')
    return tree
  end

  def data_file_sub_tree(experiment)
    tree = Node.new(:label => 'Data Files', :url => experiment_data_files_path(experiment)) do |node|
      experiment.data_files.each do |data_file|
        node << Node.new(:label => data_file.filename, :url => experiment_data_file_path(experiment, data_file), :icon_open => tree_icon('file.png'))
      end
    end
    tree.icon = tree.icon_open = tree_icon('folder.png')
    return tree
  end

  def cohort_sub_tree(patient)
    tree = Node.new(:label => 'Cohorts', :url => patient_cohort_assignments_path(patient)) do |node|
      patient.cohort_assignments.each do |cohort_assignment|
        node << Node.new(:label => cohort_assignment.cohort.name, :url => cohort_path(cohort_assignment.cohort), :icon_open => tree_icon('cohort.png'))
      end
    end
    tree.icon = tree.icon_open = tree_icon('folder.png')
    return tree
  end

  def tree_icon(file)    
    image_path('tree/custom/' + file)
  end

end
