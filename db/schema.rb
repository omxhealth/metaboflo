# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130701012220) do

  create_table "biofluid_sample_manifests", :force => true do |t|
    t.integer  "sample_manifest_id"
    t.string   "tube_id"
    t.string   "barcode"
    t.string   "species"
    t.string   "matrix"
    t.string   "group_id"
    t.boolean  "module_1"
    t.boolean  "module_2"
    t.boolean  "module_3"
    t.boolean  "module_4"
    t.boolean  "module_5"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.boolean  "module_6"
    t.boolean  "module_7"
    t.boolean  "module_8"
    t.boolean  "module_9"
    t.boolean  "module_10"
    t.boolean  "module_11"
    t.boolean  "module_12"
    t.decimal  "sample_volume"
    t.string   "volume_units"
  end

  create_table "cell_sample_manifests", :force => true do |t|
    t.integer  "sample_manifest_id"
    t.string   "tube_id"
    t.string   "barcode"
    t.string   "cell_line"
    t.string   "group_id"
    t.integer  "viable_cells"
    t.boolean  "module_1"
    t.boolean  "module_2"
    t.boolean  "module_3"
    t.boolean  "module_4"
    t.boolean  "module_5"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "species"
    t.boolean  "module_6"
    t.boolean  "module_7"
    t.boolean  "module_8"
    t.boolean  "module_9"
    t.boolean  "module_10"
    t.boolean  "module_11"
    t.boolean  "module_12"
  end

  create_table "clients", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "affiliation"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "province_state"
    t.string   "country"
    t.string   "postal_zip_code"
    t.text     "notes"
    t.string   "primary_name"
    t.string   "primary_email"
    t.string   "primary_phone"
    t.string   "secondary_name"
    t.string   "secondary_email"
    t.string   "secondary_phone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "clients", ["email"], :name => "index_clients_on_email", :unique => true
  add_index "clients", ["reset_password_token"], :name => "index_clients_on_reset_password_token", :unique => true

  create_table "cohorts", :force => true do |t|
    t.integer  "study_id"
    t.string   "label"
    t.string   "control"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cohorts", ["study_id"], :name => "index_cohorts_on_study_id"

  create_table "cohorts_test_subjects", :force => true do |t|
    t.integer  "cohort_id"
    t.integer  "test_subject_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "cohorts_test_subjects", ["cohort_id", "test_subject_id"], :name => "index_cohorts_test_subjects_on_cohort_id_and_test_subject_id", :unique => true

  create_table "compositions", :force => true do |t|
    t.integer  "diet_id"
    t.integer  "nutrient_id"
    t.float    "amount"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "concentrations", :force => true do |t|
    t.string   "identified_as"
    t.float    "concentration_value"
    t.string   "concentration_units"
    t.boolean  "is_experimental",     :default => true
    t.integer  "data_file_id"
    t.integer  "metabolite_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "data_file_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "data_files", :force => true do |t|
    t.integer  "experiment_id"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.text     "description"
    t.boolean  "has_concentrations"
    t.string   "has_concentration_units"
    t.string   "mapping_errors"
    t.integer  "data_file_type_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "diet_ingredients", :force => true do |t|
    t.integer  "diet_id"
    t.integer  "ingredient_id"
    t.float    "amount"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "diets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "experiment_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "experiments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "perform_on"
    t.integer  "assigned_to_id"
    t.date     "performed_on"
    t.integer  "performed_by_id"
    t.float    "amount_used"
    t.string   "amount_used_unit"
    t.integer  "sample_id"
    t.integer  "protocol_id"
    t.integer  "experiment_type_id"
    t.text     "comments"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "grouping_assignments", :force => true do |t|
    t.string   "type"
    t.string   "label"
    t.integer  "grouping_id"
    t.integer  "assignable_id"
    t.string   "assignable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "groupings", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lab_tests", :force => true do |t|
    t.float    "cholesterol_value"
    t.string   "cholesterol_unit"
    t.datetime "cholesterol_tested_at"
    t.float    "creatinine_value"
    t.string   "creatinine_unit"
    t.datetime "creatinine_tested_at"
    t.float    "urea_value"
    t.string   "urea_unit"
    t.datetime "urea_tested_at"
    t.float    "sodium_value"
    t.string   "sodium_unit"
    t.datetime "sodium_tested_at"
    t.float    "potassium_value"
    t.string   "potassium_unit"
    t.datetime "potassium_tested_at"
    t.float    "hemoglobin_value"
    t.string   "hemoglobin_unit"
    t.datetime "hemoglobin_tested_at"
    t.float    "white_cell_count_value"
    t.string   "white_cell_count_unit"
    t.datetime "white_cell_count_tested_at"
    t.float    "glucose_value"
    t.string   "glucose_unit"
    t.datetime "glucose_tested_at"
    t.float    "protein_value"
    t.string   "protein_unit"
    t.datetime "protein_tested_at"
    t.float    "c_reactive_protein_value"
    t.string   "c_reactive_protein_unit"
    t.datetime "c_reactive_protein_tested_at"
    t.integer  "test_subject_id"
    t.datetime "collected_at"
    t.text     "notes"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "meals", :force => true do |t|
    t.float    "amount"
    t.integer  "test_subject_id"
    t.integer  "diet_id"
    t.integer  "consumed_during_period"
    t.integer  "consumed_on_day"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "medications", :force => true do |t|
    t.integer  "test_subject_id"
    t.string   "drug"
    t.date     "started_on"
    t.date     "stopped_on"
    t.boolean  "currently_taking"
    t.string   "drugbank_reference"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "metabolites", :force => true do |t|
    t.string   "name"
    t.text     "synonyms"
    t.string   "hmdb_id"
    t.text     "description"
    t.text     "iupac_name"
    t.string   "formula"
    t.float    "mono_mass"
    t.float    "average_mass"
    t.text     "smiles"
    t.string   "cas"
    t.text     "inchi_identifier"
    t.string   "melting_point"
    t.string   "state"
    t.string   "kegg_compound_id"
    t.string   "pubchem_compound_id"
    t.string   "chebi_id"
    t.string   "wikipedia_name"
    t.string   "pathways"
    t.text     "comments"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "nutrients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "protocols", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.string   "comments"
    t.string   "storage_file_name"
    t.string   "storage_content_type"
    t.integer  "storage_file_size"
    t.datetime "data_updated_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "sample_manifests", :force => true do |t|
    t.integer  "client_id"
    t.string   "title"
    t.boolean  "verified",           :default => false
    t.boolean  "shipped",            :default => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "client_institution"
    t.string   "submitter_email"
    t.string   "pi_email"
  end

  create_table "samples", :force => true do |t|
    t.integer  "test_subject_id"
    t.integer  "sample_id"
    t.integer  "site_id"
    t.string   "sample_type"
    t.float    "original_amount"
    t.string   "original_unit"
    t.float    "actual_amount"
    t.string   "actual_unit"
    t.string   "barcode"
    t.string   "building"
    t.string   "room"
    t.string   "freezer"
    t.string   "shelf"
    t.string   "box"
    t.string   "box_position"
    t.date     "collected_on"
    t.integer  "collected_by_id"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "client_id"
    t.string   "status"
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "map_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stored_files", :force => true do |t|
    t.string   "type"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "studies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "task_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "task_priorities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "task_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.string   "subject"
    t.string   "description"
    t.integer  "status_id"
    t.integer  "priority_id"
    t.integer  "assigned_to_id"
    t.integer  "category_id"
    t.date     "start_date"
    t.date     "due_date"
    t.float    "estimated_hours"
    t.integer  "done_ratio"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "test_subject_evaluations", :force => true do |t|
    t.integer  "test_subject_id"
    t.text     "diagnosis"
    t.float    "height"
    t.float    "weight"
    t.string   "education"
    t.string   "marital_status"
    t.string   "address"
    t.string   "address_2"
    t.string   "city"
    t.string   "province_state"
    t.string   "country"
    t.string   "postal_zip_code"
    t.boolean  "current_smoker"
    t.float    "past_smoker"
    t.float    "drinking_weekly"
    t.float    "exercise_weekly"
    t.float    "hours_sleep"
    t.boolean  "enough_sleep"
    t.integer  "father_age"
    t.string   "father_health"
    t.integer  "father_death_age"
    t.string   "father_death_cause"
    t.integer  "mother_age"
    t.string   "mother_health"
    t.integer  "mother_death_age"
    t.string   "mother_death_cause"
    t.integer  "num_children"
    t.string   "relative_condition"
    t.string   "relative_relationship"
    t.string   "past_medical",          :default => "--- []"
    t.string   "symptoms",              :default => "--- []"
    t.date     "evaluated_on"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "test_subjects", :force => true do |t|
    t.text     "subspecies"
    t.date     "calving_date"
    t.integer  "lactation_number"
    t.date     "experiment_start_date"
    t.integer  "days_in_milk_at_start"
    t.date     "experiment_end_date"
    t.integer  "days_in_milk_at_end"
    t.string   "first_initial"
    t.string   "middle_initial"
    t.string   "last_initial"
    t.string   "blood_type"
    t.string   "gender"
    t.string   "race"
    t.string   "practitioner"
    t.string   "code"
    t.date     "birthdate"
    t.integer  "site_id"
    t.text     "notes"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "tissue_sample_manifests", :force => true do |t|
    t.integer  "sample_manifest_id"
    t.string   "tube_id"
    t.string   "barcode"
    t.string   "species"
    t.string   "matrix"
    t.string   "group_id"
    t.boolean  "module_1"
    t.boolean  "module_2"
    t.boolean  "module_3"
    t.boolean  "module_4"
    t.boolean  "module_5"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.boolean  "module_6"
    t.boolean  "module_7"
    t.boolean  "module_8"
    t.boolean  "module_9"
    t.boolean  "module_10"
    t.boolean  "module_11"
    t.boolean  "module_12"
    t.decimal  "tissue_weight"
    t.string   "weight_units"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.integer  "site_id"
    t.string   "rank"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
