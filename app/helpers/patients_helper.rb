module AnimalsHelper

  def animal_tree(animal)
    Tree.new(:label => "Animal #{animal.code}", :url => animal_path(animal), :icon_open => tree_icon('animal.png'), :image_path => image_path('tmp').gsub(/\/tmp/, '')) do |tree|
      tree << Node.new(:label => 'Medications', :url => animal_medications_path(animal), :icon_open => tree_icon('medicine.png'))
      tree << Node.new(:label => 'Lab Tests', :url => animal_lab_tests_path(animal), :icon_open => tree_icon('test.png'))
      tree << Node.new(:label => 'Animal Evaluations', :url => animal_animal_evaluations_path(animal), :icon_open => tree_icon('evaluation.png'))

      tree << sample_sub_tree(animal, animal) # Add the samples for this animal
      tree << cohort_sub_tree(animal) # Add the cohorts for this animal
    end
  end

  protected

  def sample_sub_tree(parent, animal)
    samples_url = parent.kind_of?(Animal) ? animal_samples_path(parent) : sample_samples_path(parent)
    label = parent.kind_of?(Animal) ? 'Samples' : 'Aliquots'

    tree = Node.new(:label => label, :url => samples_url) do |node|
      parent.samples.each do |sample|
        sample_url = sample.sample ? sample_sample_path(sample.sample, sample) : animal_sample_path(animal, sample)
        sample_label = sample.sample ? "Aliquot #{sample.id}" : "Sample #{sample.id}"
        sub_samples = Node.new(:label => sample_label, :url => sample_url) do |sub_node|
          sub_node << sample_sub_tree(sample, animal)
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

  def cohort_sub_tree(animal)
    tree = Node.new(:label => 'Cohorts', :url => animal_cohort_assignments_path(animal)) do |node|
      animal.cohort_assignments.each do |cohort_assignment|
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
