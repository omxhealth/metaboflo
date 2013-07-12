require 'roo'
class SampleManifest < ActiveRecord::Base
 # attr_accessible :file,:biofluid_sample_manifests_attributes, :tissue_sample_manifests_attributes, :cell_sample_manifests_attributes
  attr_accessible :verified, :file
  belongs_to :client
  has_many :biofluid_sample_manifests, :dependent => :destroy
  has_many :tissue_sample_manifests, :dependent => :destroy
  has_many :cell_sample_manifests, :dependent => :destroy

  has_attached_file :file, :path => ":rails_root/public/system/sample_manifests/:basename.xlsx"
  
  has_many :stored_files, :as => :attachable
  accepts_nested_attributes_for :stored_files, :allow_destroy => true

  accepts_nested_attributes_for :biofluid_sample_manifests, :allow_destroy => true, :reject_if => proc {|attributes| attributes.all?{|key,value| value.blank? || value.eql?("0") || key.eql?("_destroy")}}
  accepts_nested_attributes_for :tissue_sample_manifests, :allow_destroy => true, :reject_if => proc {|attributes| attributes.all?{|key,value| value.blank? || value.eql?("0") || key.eql?("_destroy")}}
  accepts_nested_attributes_for :cell_sample_manifests, :allow_destroy => true, :reject_if => proc {|attributes| attributes.all?{|key,value| value.blank? || value.eql?("0") || key.eql?("_destroy")}}
  
  after_save :parse_file
  
  # Returns the number of samples in this sample_manifest.
  def total_samples
    self.biofluid_sample_manifests.count + self.tissue_sample_manifests.count + self.cell_sample_manifests.count
  end 
  
  # Returns the number of tests to be done in this sample_manifest.
  def total_tests
    total = 0
    self.biofluid_sample_manifests.each do |s|
      total += s.tests
    end
    self.tissue_sample_manifests.each do |s|
      total += s.tests
    end
    self.cell_sample_manifests.each do |s|
      total += s.tests
    end
    
    total
  end
  
  # Returns a quote for all samples in the sample_manifest.
  def estimate
    total = 0
    self.biofluid_sample_manifests.each do |s|
      total += s.estimate
    end
    self.tissue_sample_manifests.each do |s|
      total += s.estimate
    end
    self.cell_sample_manifests.each do |s|
      total += s.estimate
    end

    total
  end
  
  # Populates an array to hold the text indicating what 
  # modules should be done to this sample.
  def self.module_codes(manifest)
    codes = []
    codes << "MP#1" if manifest.module_1?
    codes << "MP#2" if manifest.module_2?
    codes << "MP#3" if manifest.module_3?
    codes << "MP#4" if manifest.module_4?
    codes << "MP#5" if manifest.module_5?
    codes << "MP#6" if manifest.module_6?
    codes << "MP#7" if manifest.module_7?
    codes << "MP#8" if manifest.module_8?
    codes << "MP#9" if manifest.module_9?
    codes << "MP#10" if manifest.module_10?
    codes << "MP#11" if manifest.module_11?
    codes << "MP#12" if manifest.module_12?
    codes
  end
  
  private
  # Parse the attached sample_manifest if it exists.
  def parse_file
    if file.exists?
        reset_manifest
        workbook = Roo::Excelx.new(file.path)
        set_sample_manifest_attributes workbook
        headers = column_headers
        sheets = sheet_index
        first_row = 19
        read_tissue_sheet workbook, sheets[:tissue], first_row, headers
        read_biofluids_sheet workbook, sheets[:biofluids], first_row, headers
        read_cells_sheet workbook, sheets[:cell], first_row, headers
        new_file_name
        self.save!
      end 
  end
  
  # Set a sample to have a particular 
  # test done on it.
  def set_module(sample,num)
    case 
      when num == 1
        sample.module_1 = true
      when num == 2
        sample.module_2 = true
      when num == 3
        sample.module_3 = true
      when num == 4
        sample.module_4 = true
      when num == 5
        sample.module_5 = true
      when num == 6
        sample.module_6 = true
      when num == 7
        sample.module_7 = true
      when num == 8
        sample.module_8 = true
      when num == 9
        sample.module_9 = true
      when num == 10
        sample.module_10 = true
      when num == 11
        sample.module_11 = true
      when num == 12
        sample.module_12 = true
    end
  end
  
  # Returns a hash of column headers to column number 
  # in the manifest spreadsheet.
  def column_headers
    {tube_id: 1,
     species: 2,
     matrix: 3,
     cell_line: 3,
     group_id: 4,
     tissue_weight: 5,
     sample_volume: 5,
     viable_cells: 5,
     units: 6,
     first_module: 7,
     last_module: 18}
  end
  
  # Returns a hash of the corresponding page index
  # of each manifest in the excel workbook.
   def sheet_index
    {tissue: 0,
      biofluids: 1,
      cell: 2}
  end
  
  # Change the attatched file to .xlsx, and
  # return the new filename.
  def new_file_name
     name = "sample_manifest_#{self.id}.xlsm"
     dir = File.dirname(file.path)
     file_path = "#{dir}/#{name}"
     File.rename(file.path,file_path)
     name
  end
  
  # Read the excel biofluids sheet.
  def read_biofluids_sheet(workbook, sheet_number, first_row, headers)
    workbook.default_sheet = workbook.sheets[sheet_number]
     (first_row..workbook.last_row).each do |row|
          if (valid_row workbook,row)
             sample = self.biofluid_sample_manifests.build
             set_common_attributes sample, workbook, row, headers
             sample.matrix = strip_decimal workbook.cell(row,headers[:matrix])  
             sample.sample_volume = workbook.cell(row,headers[:sample_volume])
             sample.volume_units = workbook.cell(row,headers[:units])   
           end
        end
  end
  
  # Read the excel tissue sheet.
  def read_tissue_sheet(workbook,sheet_number, first_row, headers)
    workbook.default_sheet = workbook.sheets[sheet_number]
    (first_row..workbook.last_row).each do |row|
          if (valid_row workbook,row)
             sample = self.tissue_sample_manifests.build
             set_common_attributes sample, workbook, row, headers
             sample.matrix = strip_decimal workbook.cell(row,headers[:matrix])  
             sample.tissue_weight = workbook.cell(row,headers[:tissue_weight])
             sample.weight_units = workbook.cell(row,headers[:units])   
         end
      end   
  end
  
  # Read the excel cells sheet.
  def read_cells_sheet(workbook, sheet_number, first_row, headers)
    workbook.default_sheet = workbook.sheets[sheet_number]
    (first_row..workbook.last_row).each do |row|
          if (valid_row workbook,row)
             sample = self.cell_sample_manifests.build
             set_common_attributes sample, workbook, row, headers
             sample.cell_line = strip_decimal workbook.cell(row,headers[:cell_line])
             sample.viable_cells = workbook.cell(row,headers[:viable_cells]).to_i 
         end
      end    
  end
  
  # Set the common attributes that are the same among the 
  # different spreadsheets in the excel workbook.
  def set_common_attributes(sample, workbook, row, headers)
     sample.tube_id = workbook.cell(row,headers[:tube_id]).to_i
     sample.species = strip_decimal workbook.cell(row,headers[:species])
     sample.group_id = workbook.cell(row,headers[:group_id]).to_i
      (headers[:first_module]..headers[:last_module]).each do |num|
          if !workbook.cell(row,num).nil?
            set_module sample,num - headers[:first_module] + 1
          end
      end  
  end
  
  # Check if a row is valid, by checking if the 
  # client entered in any information.
  def valid_row(workbook,row)
    (2..18).each do |index|
      if (!workbook.cell(row,index).nil?)
        return true
      end
    end
    return false
  end
  
  # Remove the decimal from the variable if it's a number.
  def strip_decimal(entry)
    if entry.is_a? Numeric
      entry = entry.to_i
    end
    
    entry
  end
  
  # Return a hash of location of the data that is the same
  # across all of the sheets.
  def common_data_cells
      {title: [6,2],
       client_institution: [7,2],
       submitter_email: [8,2],
       pi_email: [9,2] }
  end
  # Set the sample_manifests data for all 3 sheets
  def set_sample_manifest_attributes(workbook)
    row_column_info = common_data_cells
    self.title = workbook.cell(row_column_info[:title][0],row_column_info[:title][1])
    self.client_institution = workbook.cell(row_column_info[:client_institution][0],
                                            row_column_info[:client_institution][1])
    self.submitter_email = workbook.cell(row_column_info[:submitter_email][0],
                                         row_column_info[:submitter_email][1])
    self.pi_email = workbook.cell(row_column_info[:pi_email][0],row_column_info[:pi_email][1])    
  end
  
  def reset_manifest
    # reset all nested sample before reading the file
    self.biofluid_sample_manifests.each do |sample|
      sample.destroy
    end
    self.cell_sample_manifests.each do |sample|
      sample.destroy
    end
    self.tissue_sample_manifests.each do |sample| 
      sample.destroy
    end
  end
  
end