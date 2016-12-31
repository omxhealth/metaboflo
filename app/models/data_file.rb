class DataFile < ActiveRecord::Base
  belongs_to :experiment
  has_attached_file :data,
    url: "/system/:attachment/:id/:filename",
    path: ":rails_root/public/system/:attachment/:id/:filename"
  do_not_validate_attachment_file_type :data

  belongs_to :data_file_type
  has_many :concentrations
  serialize :mapping_errors, Array

  after_save :save_concentrations

  def root
    experiment.root
  end

  def save_concentrations
    if has_concentrations and self.mapping_errors == nil
      self.mapping_errors = Array.new
      CSV.foreach(self.data.path, headers: false) do |row|
        add_concentration(row[0], row[1]) #Each row is a concentration
      end
      self.save!
    end
  end

  private

  def add_concentration(name, value)
    if name.present?
      met = Metabolite.find_by("name = ? OR name = ?", name, name.remove(/-/))

      if met == nil
        #If we couldn't find it by name, attempt to find it by synonyms
        potential_matches = Metabolite.where("synonyms LIKE ?", "%#{name}%")
        found_met = nil
        potential_matches.each do |match|
          match.synonyms.split(';').each do |syn|
            syncleaned = syn.strip.downcase
            namecleaned = name.strip.downcase
            if syncleaned.remove(/-/) == namecleaned || syncleaned == namecleaned
              found_met = match
            end
          end
        end

        if found_met.present?
          met = found_met
        end
      end

      if met.present?
        c = Concentration.new
        c.concentration_value = value
        c.concentration_units = self.has_concentration_units
        c.metabolite = met
        c.identified_as = name
        c.data_file = self
        c.save!
      else
        self.mapping_errors << name
      end
    end
  end

end
