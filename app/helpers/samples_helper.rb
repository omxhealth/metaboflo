module SamplesHelper
  # Prepares a new sample for creation (via form) by adding the required number of nested associations
  def setup_sample(sample)
    sample.tap do |s|
      1.upto(4) do |i|
        s.stored_files.build
      end
    end
  end

  def sample_types
    ['Urine', 'Blood', 'Feces', 'Saliva', 'CSF', 'Bile', 'Amniotic Fluid', 'Cellular Cytoplasm', 'Breast Milk', 'Semen', 'Pericardial Effusion', 'Aqueous Humour', 'Ascites Fluid', 'Lymph', 'Sweat', 'Tears']
  end
end
