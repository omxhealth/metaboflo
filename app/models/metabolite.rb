class Metabolite < ActiveRecord::Base
  has_many :concentrations
end
