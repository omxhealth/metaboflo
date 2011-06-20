class Grouping < ActiveRecord::Base
  has_many :grouping_assignments, :dependent => :destroy
  
  validates_presence_of :name, :type

  def assignable_type
    self.class.to_s.sub(/Grouping$/, '')
  end
  
  def self.factory(type, params = nil)
    class_name = type + 'Grouping'
    class_name.constantize.new(params)
  end
    
  def to_s
    return name
  end
  
  # Get a list of possible grouping subclasses
  def Grouping.valid_types
    return ['TestSubject', 'Sample', 'Experiment']
    # Use the object space to get the subclasses and remove the Grouping itself)
    # klasses = ObjectSpace.enum_for(:each_object, class << self; self; end).to_a - [ self ]
    # klasses.collect { |klass| klass.to_s }.sort
  end
  
end
