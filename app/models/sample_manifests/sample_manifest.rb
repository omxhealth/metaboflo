require 'roo'
require 'prawn'
require 'barby'
require 'barby/barcode/code_39'
require 'barby/outputter/prawn_outputter'
class SampleManifest < ActiveRecord::Base
 # attr_accessible :file,:biofluid_sample_manifests_attributes, :tissue_sample_manifests_attributes, :cell_sample_manifests_attributes
  attr_accessible :file
  belongs_to :client
  has_many :biofluid_sample_manifests, :dependent => :destroy
  has_many :tissue_sample_manifests, :dependent => :destroy
  has_many :cell_sample_manifests, :dependent => :destroy

  has_attached_file :file, :path => ":rails_root/sample_manifests/:basename.xlsx"
  
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
    total += self.class.sheet_estimate(self.biofluid_sample_manifests)
    total += self.class.sheet_estimate(self.tissue_sample_manifests)
    total += self.class.sheet_estimate(self.cell_sample_manifests)
    total
  end
  
  def self.sheet_estimate(samples)
    total = 0
    samples.each do |s|
      total += s.estimate
    end
    total
  end
    
  def generate_barcodes(params)
    Prawn::Document.generate(barcodes_path) do |pdf|
      self.biofluid_sample_manifests.each do |sample|
        barcode_helper(sample,'Biofluids', pdf, params)
       end
      self.cell_sample_manifests.each do |sample|
         barcode_helper(sample,'Cell', pdf, params)
      end
      self.tissue_sample_manifests.each do |sample| 
         barcode_helper(sample,'Tissue', pdf, params)
      end
    end
  end
  
  # assign barcodes to the samples
  def assign_barcodes
    self.biofluid_sample_manifests.each do |sample|
       sample.barcode = get_barcode_content
    end
    self.cell_sample_manifests.each do |sample|
      sample.barcode = get_barcode_content
    end
    self.tissue_sample_manifests.each do |sample| 
      sample.barcode = get_barcode_content
    end
    # save the serial number
    self.client.save!
    # save the barcodes
    self.save!
  end
  
  def barcodes_path
    "barcodes/sm#{self.id}_barcodes.pdf"
  end
  
  def sample_manifest_path
    "sample_manifests/sample_manifest_#{self.id}.xlsm"
  end
  
  # Returns a boolean if this manifest can be confirmed
  def confirmable_manifest?
    if !all_common_fields_present?
      return false
    end
    # Make sure each sample has all required information
    self.biofluid_sample_manifests.each do |s|
      if !s.required_fields_present?
        return false
      end     
    end
    self.tissue_sample_manifests.each do |s|
      if !s.required_fields_present?
        return false
      end
    end
    self.cell_sample_manifests.each do |s|
      if !s.required_fields_present?
        return false
      end
    end
    return true
  end
  
  def all_common_fields_present?
    !self.client_institution.blank? && !self.pi_email.blank? && !self.submitter_email.blank?
  end
  
  def self.barcode_textbox_name(sample)
    "#{sample.class.to_s}#{sample.tube_id}"
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
     File.rename(file.path,sample_manifest_path)
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
             sample.tissue_weight = round_num(workbook.cell(row,headers[:tissue_weight]))
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
             sample.viable_cells = to_int(workbook.cell(row,headers[:viable_cells]))
         end
      end    
  end
  
  # Set the common attributes that are the same among the 
  # different spreadsheets in the excel workbook.
  def set_common_attributes(sample, workbook, row, headers)
     sample.tube_id = workbook.cell(row,headers[:tube_id]).to_i
     sample.species = strip_decimal workbook.cell(row,headers[:species])
     sample.group_id = to_int(workbook.cell(row,headers[:group_id]))
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
  
  # Round number if it's Numeric
  def round_num(num)
    if num.is_a? Numeric
      num = num.round
      puts num
      puts "raffi"
    end
    
    num
  end
  
  def to_int(num)
    if num.is_a? Numeric
      num = num.to_i
    end
    
    num
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
  
  
  # Barcode generator helper
  def barcode_helper(sample, type, pdf, params)
    if pdf.cursor < 50
      pdf.start_new_page
    end
     pdf.bounding_box([0,pdf.cursor],:width=>pdf.bounds.right,:height => 50) do
          barcode = Barby::Code39.new(sample.barcode)
          outputter = Barby::PrawnOutputter.new(barcode)
          if !params[self.class.barcode_textbox_name(sample)].blank?
            description = params[self.class.barcode_textbox_name(sample)]
          else
            description = "#{type} ##{sample.tube_id}"
          end
          title = sample.to_s
          pdf.text_box(title, :at => [0,pdf.cursor], :height => 50, :width => (pdf.bounds.right - outputter.width - 50), 
                        :valign => :center, :align => :justify, :overflow => :shrink_to_fit)
          outputter.annotate_pdf(pdf,:height => 30,:x => (pdf.bounds.right - outputter.width), :y=>10)
          pdf.text_box(description,:at => [(pdf.bounds.right - outputter.width + 5), 5],:width => (outputter.width - 5), 
          :height => 8, :overflow => :shrink_to_fit, :align => :center) 
     end
     # make space between barcodes
     pdf.move_down 10
  end
  
  def pad_number num
    digits = num.to_s.size
    padded_string = ""
    if digits < 4
      (4 - digits).times do
        padded_string += '0'
      end
    end
    padded_string += num.to_s
  end
  
  
  # Returns the content for the barcode using the serial number
  def get_barcode_content
     barcode_content = pad_number(self.client_id) + '-' + pad_number(self.client.serial_number)
     # increment the serial by one
     self.client.serial_number += 1
     barcode_content
  end

end