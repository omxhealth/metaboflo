module TestSubjectsHelper

  def test_subject_tree(test_subject)
    tree = Tree.new(:label => "#{TestSubject.title} #{test_subject.code}", :url => test_subject_path(test_subject), :icon_open => tree_icon("subjects/#{SUBJECT_CONFIG[:tree_image]}"), :image_path => image_path('tmp').gsub(/\/tmp/, '')) do |tree|
      tree << Node.new(:label => 'Medications', :url => test_subject_medications_path(test_subject), :icon_open => tree_icon('medicine.png'))
      tree << Node.new(:label => 'Lab Tests', :url => test_subject_lab_tests_path(test_subject), :icon_open => tree_icon('test.png'))
      tree << Node.new(:label => "#{TestSubject.title} Evaluations", :url => test_subject_test_subject_evaluations_path(test_subject), :icon_open => tree_icon('evaluation.png'))

      tree << sample_sub_tree(test_subject, test_subject) # Add the samples for this test_subject
      tree << cohort_sub_tree(test_subject) # Add the cohorts for this test_subject
    end
    
    tree.to_s.html_safe
  end

  protected

  def sample_sub_tree(parent, test_subject)
    samples_url = parent.kind_of?(TestSubject) ? test_subject_samples_path(parent) : sample_samples_path(parent)
    label = parent.kind_of?(TestSubject) ? 'Samples' : 'Aliquots'

    tree = Node.new(:label => label, :url => samples_url) do |node|
      parent.samples.each do |sample|
        sample_url = sample.sample ? sample_sample_path(sample.sample, sample) : test_subject_sample_path(test_subject, sample)
        sample_label = sample.sample ? "Aliquot #{sample.id}" : "Sample #{sample.id}"
        sub_samples = Node.new(:label => sample_label, :url => sample_url) do |sub_node|
          sub_node << sample_sub_tree(sample, test_subject)
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
        experiment_node = Node.new(:label => "#{experiment.name} (#{experiment.experiment_type.name})", :url => sample_experiment_path(experiment.sample, experiment))
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
        node << Node.new(:label => "#{data_file.filename} (#{data_file.data_file_type.name})", :url => experiment_data_file_path(experiment, data_file), :icon_open => tree_icon('file.png'))
      end
    end
    tree.icon = tree.icon_open = tree_icon('folder.png')
    return tree
  end

  def cohort_sub_tree(test_subject)
    tree = Node.new(:label => 'Cohorts', :url => test_subject_cohort_assignments_path(test_subject)) do |node|
      test_subject.cohort_assignments.each do |cohort_assignment|
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
