module TestSubjectsHelper

  def test_subject_tree(test_subject)
    tree = Tree.new(:label => "#{TestSubject.title} #{test_subject.code}", :url => test_subject_path(test_subject), :icon_open => tree_icon("subjects/#{SUBJECT_CONFIG[:tree_image]}"), :image_path => image_path('tmp').gsub(/\/tmp/, ''), :css_class => (controller_name == 'test_subjects' && action_name == 'show' && params[:id] == test_subject.to_param ? 'node-selected' : nil)) do |tree|
      tree << Node.new(:label => 'Medications', :url => test_subject_medications_path(test_subject), :icon_open => tree_icon('medicine.png'), :css_class => (controller_name == 'medications' && params[:test_subject_id] == test_subject.to_param ? 'node-selected' : nil))
      tree << Node.new(:label => 'Lab Tests', :url => test_subject_lab_tests_path(test_subject), :icon_open => tree_icon('test.png'), :css_class => (controller_name == 'lab_tests' && params[:test_subject_id] == test_subject.to_param ? 'node-selected' : nil))
      tree << Node.new(:label => "#{TestSubject.title} Evaluations", :url => test_subject_test_subject_evaluations_path(test_subject), :icon_open => tree_icon('evaluation.png'), :css_class => (controller_name == 'test_subject_evaluations' && params[:test_subject_id] == test_subject.to_param ? 'node-selected' : nil))
      tree << all_experiments(test_subject)
      tree << all_samples(test_subject)
      tree << cohort_sub_tree(test_subject) # Add the cohorts for this test_subject
    end
    
    tree.to_s.html_safe
  end

  protected
    def all_experiments(test_subject)
      css_class = (controller_name == 'experiments' && action_name == 'index' && params[:test_subject_id] == test_subject.id ? 'node-selected' : nil)
      tree = Node.new(:label => 'Experiments', :url => test_subject_experiments_path(test_subject), :css_class => css_class) do |node|
        test_subject.experiments.each do |experiment|
          experiment_url = sample_experiment_path(experiment.sample, experiment)
          experiment_label = "#{experiment.name} (#{experiment.experiment_type.name})"
          experiment_css_class = (controller_name == 'experiments' && action_name == 'show' && params[:id] == experiment.to_param ? 'node-selected' : nil)
          experiment_icon = 'experiment.png'
          node << Node.new(:label => experiment_label, :url => experiment_url, :css_class => experiment_css_class, :icon_open => tree_icon(experiment_icon))
        end
      end
      
      tree.icon = tree.icon_open = tree_icon('folder.png')
      return tree
    end
    
    def all_samples(test_subject)
      css_class = (controller_name == 'samples' && action_name == 'index' && params[:test_subject_id] == test_subject.to_param ? 'node-selected' : nil)
      tree = Node.new(:label => 'Samples', :url => test_subject_samples_path(test_subject), :css_class => css_class) do |node|
        test_subject.samples.each do |sample|
          sample_url = test_subject_sample_path(test_subject, sample)
          sample_label = sample.aliquot? ? "Aliquot #{sample.id}" : "Sample #{sample.id}"
          sample_css_class = (controller_name == 'samples' && action_name == 'show' && params[:id] == sample.to_param ? 'node-selected' : nil)
          sample_icon = sample.aliquot? ? 'aliquot.png' : 'sample.png'
          node << Node.new(:label => sample_label, :url => sample_url, :css_class => sample_css_class, :icon_open => tree_icon(sample_icon))
        end
      end
      
      tree.icon = tree.icon_open = tree_icon('folder.png')
      return tree
    end
    
    def cohort_sub_tree(test_subject)
      tree = Node.new(:label => 'Cohorts', :url => test_subject_cohort_assignments_path(test_subject), :css_class => (controller_name == 'cohort_assignments' && action_name == 'index' && params[:test_subject_id] == test_subject.to_param ? 'node-selected' : nil)) do |node|
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
