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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140205181316) do

  create_table "batches", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "prep_done",              default: false
    t.boolean  "ph_done",                default: false
    t.boolean  "run_done",               default: false
  end

  create_table "biofluid_sample_manifests", force: :cascade do |t|
    t.integer  "sample_manifest_id", limit: 4
    t.string   "tube_id",            limit: 255
    t.string   "barcode",            limit: 255
    t.string   "species",            limit: 255
    t.string   "matrix",             limit: 255
    t.string   "group_id",           limit: 255
    t.string   "sample_volume",      limit: 255
    t.boolean  "module_1"
    t.boolean  "module_2"
    t.boolean  "module_3"
    t.boolean  "module_4"
    t.boolean  "module_5"
    t.boolean  "gc_fap"
    t.boolean  "ss_1"
    t.boolean  "ss_2"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "cell_sample_manifests", force: :cascade do |t|
    t.integer  "sample_manifest_id", limit: 4
    t.string   "tube_id",            limit: 255
    t.string   "barcode",            limit: 255
    t.string   "cell_line",          limit: 255
    t.string   "group_id",           limit: 255
    t.integer  "viable_cells",       limit: 4
    t.boolean  "module_1"
    t.boolean  "module_2"
    t.boolean  "module_3"
    t.boolean  "module_4"
    t.boolean  "module_5"
    t.boolean  "gc_fap"
    t.boolean  "ss_1"
    t.boolean  "ss_2"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "password_salt",          limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "failed_attempts",        limit: 4,     default: 0
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "invitation_token",       limit: 255
    t.integer  "sign_in_count",          limit: 4,     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "name",                   limit: 255
    t.string   "affiliation",            limit: 255
    t.string   "phone",                  limit: 255
    t.string   "address",                limit: 255
    t.string   "city",                   limit: 255
    t.string   "province_state",         limit: 255
    t.string   "country",                limit: 255
    t.string   "postal_zip_code",        limit: 255
    t.text     "notes",                  limit: 65535
    t.string   "primary_name",           limit: 255
    t.string   "primary_email",          limit: 255
    t.string   "primary_phone",          limit: 255
    t.string   "secondary_name",         limit: 255
    t.string   "secondary_email",        limit: 255
    t.string   "secondary_phone",        limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "clients", ["email"], name: "index_clients_on_email", unique: true, using: :btree
  add_index "clients", ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true, using: :btree

  create_table "cohorts", force: :cascade do |t|
    t.integer  "study_id",   limit: 4
    t.string   "label",      limit: 255
    t.string   "control",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cohorts", ["study_id"], name: "index_cohorts_on_study_id", using: :btree

  create_table "cohorts_test_subjects", force: :cascade do |t|
    t.integer  "cohort_id",       limit: 4
    t.integer  "test_subject_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "cohorts_test_subjects", ["cohort_id", "test_subject_id"], name: "index_cohorts_test_subjects_on_cohort_id_and_test_subject_id", unique: true, using: :btree

  create_table "compositions", force: :cascade do |t|
    t.integer  "diet_id",     limit: 4
    t.integer  "nutrient_id", limit: 4
    t.float    "amount",      limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "concentrations", force: :cascade do |t|
    t.string   "identified_as",       limit: 255
    t.float    "concentration_value", limit: 24
    t.string   "concentration_units", limit: 255
    t.boolean  "is_experimental",                 default: true
    t.integer  "data_file_id",        limit: 4
    t.integer  "metabolite_id",       limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "corrections", force: :cascade do |t|
    t.integer  "sample_id",     limit: 4
    t.float    "initial_ph",    limit: 24
    t.float    "final_ph",      limit: 24
    t.float    "buffer_amount", limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_file_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "data_files", force: :cascade do |t|
    t.integer  "experiment_id",           limit: 4
    t.string   "data_file_name",          limit: 255
    t.string   "data_content_type",       limit: 255
    t.integer  "data_file_size",          limit: 4
    t.datetime "data_updated_at"
    t.text     "description",             limit: 65535
    t.boolean  "has_concentrations"
    t.string   "has_concentration_units", limit: 255
    t.string   "mapping_errors",          limit: 255
    t.integer  "data_file_type_id",       limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "diet_ingredients", force: :cascade do |t|
    t.integer  "diet_id",       limit: 4
    t.integer  "ingredient_id", limit: 4
    t.float    "amount",        limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "diets", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "experiment_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "experiments", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.text     "description",        limit: 65535
    t.date     "perform_on"
    t.integer  "assigned_to_id",     limit: 4
    t.date     "performed_on"
    t.integer  "performed_by_id",    limit: 4
    t.float    "amount_used",        limit: 24
    t.string   "amount_used_unit",   limit: 255
    t.integer  "sample_id",          limit: 4
    t.integer  "protocol_id",        limit: 4
    t.integer  "experiment_type_id", limit: 4
    t.text     "comments",           limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "grouping_assignments", force: :cascade do |t|
    t.string   "type",            limit: 255
    t.string   "label",           limit: 255
    t.integer  "grouping_id",     limit: 4
    t.integer  "assignable_id",   limit: 4
    t.string   "assignable_type", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "groupings", force: :cascade do |t|
    t.string   "type",        limit: 255
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lab_tests", force: :cascade do |t|
    t.float    "cholesterol_value",            limit: 24
    t.string   "cholesterol_unit",             limit: 255
    t.datetime "cholesterol_tested_at"
    t.float    "creatinine_value",             limit: 24
    t.string   "creatinine_unit",              limit: 255
    t.datetime "creatinine_tested_at"
    t.float    "urea_value",                   limit: 24
    t.string   "urea_unit",                    limit: 255
    t.datetime "urea_tested_at"
    t.float    "sodium_value",                 limit: 24
    t.string   "sodium_unit",                  limit: 255
    t.datetime "sodium_tested_at"
    t.float    "potassium_value",              limit: 24
    t.string   "potassium_unit",               limit: 255
    t.datetime "potassium_tested_at"
    t.float    "hemoglobin_value",             limit: 24
    t.string   "hemoglobin_unit",              limit: 255
    t.datetime "hemoglobin_tested_at"
    t.float    "white_cell_count_value",       limit: 24
    t.string   "white_cell_count_unit",        limit: 255
    t.datetime "white_cell_count_tested_at"
    t.float    "glucose_value",                limit: 24
    t.string   "glucose_unit",                 limit: 255
    t.datetime "glucose_tested_at"
    t.float    "protein_value",                limit: 24
    t.string   "protein_unit",                 limit: 255
    t.datetime "protein_tested_at"
    t.float    "c_reactive_protein_value",     limit: 24
    t.string   "c_reactive_protein_unit",      limit: 255
    t.datetime "c_reactive_protein_tested_at"
    t.integer  "test_subject_id",              limit: 4
    t.datetime "collected_at"
    t.text     "notes",                        limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "meals", force: :cascade do |t|
    t.float    "amount",                 limit: 24
    t.integer  "test_subject_id",        limit: 4
    t.integer  "diet_id",                limit: 4
    t.integer  "consumed_during_period", limit: 4
    t.integer  "consumed_on_day",        limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "medications", force: :cascade do |t|
    t.integer  "test_subject_id",    limit: 4
    t.string   "drug",               limit: 255
    t.date     "started_on"
    t.date     "stopped_on"
    t.boolean  "currently_taking"
    t.string   "drugbank_reference", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "metabolites", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.text     "synonyms",            limit: 65535
    t.string   "hmdb_id",             limit: 255
    t.text     "description",         limit: 65535
    t.text     "iupac_name",          limit: 65535
    t.string   "formula",             limit: 255
    t.float    "mono_mass",           limit: 24
    t.float    "average_mass",        limit: 24
    t.text     "smiles",              limit: 65535
    t.string   "cas",                 limit: 255
    t.text     "inchi_identifier",    limit: 65535
    t.string   "melting_point",       limit: 255
    t.string   "state",               limit: 255
    t.string   "kegg_compound_id",    limit: 255
    t.string   "pubchem_compound_id", limit: 255
    t.string   "chebi_id",            limit: 255
    t.string   "wikipedia_name",      limit: 255
    t.string   "pathways",            limit: 255
    t.text     "comments",            limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "nutrients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "protocols", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.string   "version",              limit: 255
    t.string   "comments",             limit: 255
    t.string   "storage_file_name",    limit: 255
    t.string   "storage_content_type", limit: 255
    t.integer  "storage_file_size",    limit: 4
    t.datetime "data_updated_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "sample_manifests", force: :cascade do |t|
    t.integer  "client_id",         limit: 4
    t.string   "title",             limit: 255
    t.boolean  "verified",                      default: false
    t.boolean  "shipped",                       default: false
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
  end

  create_table "samples", force: :cascade do |t|
    t.integer  "test_subject_id",     limit: 4
    t.integer  "sample_id",           limit: 4
    t.integer  "site_id",             limit: 4
    t.string   "sample_type",         limit: 255
    t.float    "original_amount",     limit: 24
    t.string   "original_unit",       limit: 255
    t.float    "actual_amount",       limit: 24
    t.string   "actual_unit",         limit: 255
    t.string   "barcode",             limit: 255
    t.string   "building",            limit: 255
    t.string   "room",                limit: 255
    t.string   "freezer",             limit: 255
    t.string   "shelf",               limit: 255
    t.string   "box",                 limit: 255
    t.string   "box_position",        limit: 255
    t.date     "collected_on"
    t.integer  "collected_by_id",     limit: 4
    t.text     "description",         limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "client_id",           limit: 4
    t.string   "status",              limit: 255
    t.integer  "batch_id",            limit: 4
    t.string   "collection_location", limit: 255
    t.integer  "prepped_by_id",       limit: 4
    t.float    "dss_concentration",   limit: 24
    t.string   "dss_lot",             limit: 255
    t.integer  "protocol_id",         limit: 4
    t.integer  "corrected_by_id",     limit: 4
  end

  create_table "sites", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "website",    limit: 255
    t.string   "map_url",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "stored_files", force: :cascade do |t|
    t.string   "type",                    limit: 255
    t.integer  "attachable_id",           limit: 4
    t.string   "attachable_type",         limit: 255
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 4
    t.datetime "attachment_updated_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "studies", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "task_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "task_priorities", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "task_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "subject",         limit: 255
    t.string   "description",     limit: 255
    t.integer  "status_id",       limit: 4
    t.integer  "priority_id",     limit: 4
    t.integer  "assigned_to_id",  limit: 4
    t.integer  "category_id",     limit: 4
    t.date     "start_date"
    t.date     "due_date"
    t.float    "estimated_hours", limit: 24
    t.integer  "done_ratio",      limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "test_subject_evaluations", force: :cascade do |t|
    t.integer  "test_subject_id",       limit: 4
    t.text     "diagnosis",             limit: 65535
    t.float    "height",                limit: 24
    t.float    "weight",                limit: 24
    t.string   "education",             limit: 255
    t.string   "marital_status",        limit: 255
    t.string   "address",               limit: 255
    t.string   "address_2",             limit: 255
    t.string   "city",                  limit: 255
    t.string   "province_state",        limit: 255
    t.string   "country",               limit: 255
    t.string   "postal_zip_code",       limit: 255
    t.boolean  "current_smoker"
    t.float    "past_smoker",           limit: 24
    t.float    "drinking_weekly",       limit: 24
    t.float    "exercise_weekly",       limit: 24
    t.float    "hours_sleep",           limit: 24
    t.boolean  "enough_sleep"
    t.integer  "father_age",            limit: 4
    t.string   "father_health",         limit: 255
    t.integer  "father_death_age",      limit: 4
    t.string   "father_death_cause",    limit: 255
    t.integer  "mother_age",            limit: 4
    t.string   "mother_health",         limit: 255
    t.integer  "mother_death_age",      limit: 4
    t.string   "mother_death_cause",    limit: 255
    t.integer  "num_children",          limit: 4
    t.string   "relative_condition",    limit: 255
    t.string   "relative_relationship", limit: 255
    t.string   "past_medical",          limit: 255,   default: "--- []"
    t.string   "symptoms",              limit: 255,   default: "--- []"
    t.date     "evaluated_on"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  create_table "test_subjects", force: :cascade do |t|
    t.text     "subspecies",            limit: 65535
    t.date     "calving_date"
    t.integer  "lactation_number",      limit: 4
    t.date     "experiment_start_date"
    t.integer  "days_in_milk_at_start", limit: 4
    t.date     "experiment_end_date"
    t.integer  "days_in_milk_at_end",   limit: 4
    t.string   "first_initial",         limit: 255
    t.string   "middle_initial",        limit: 255
    t.string   "last_initial",          limit: 255
    t.string   "blood_type",            limit: 255
    t.string   "gender",                limit: 255
    t.string   "race",                  limit: 255
    t.string   "practitioner",          limit: 255
    t.string   "code",                  limit: 255
    t.date     "birthdate"
    t.integer  "site_id",               limit: 4
    t.text     "notes",                 limit: 65535
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "tissue_sample_manifests", force: :cascade do |t|
    t.integer  "sample_manifest_id", limit: 4
    t.string   "tube_id",            limit: 255
    t.string   "barcode",            limit: 255
    t.string   "species",            limit: 255
    t.string   "matrix",             limit: 255
    t.string   "group_id",           limit: 255
    t.string   "tissue_weight",      limit: 255
    t.boolean  "module_1"
    t.boolean  "module_2"
    t.boolean  "module_3"
    t.boolean  "module_4"
    t.boolean  "module_5"
    t.boolean  "gc_fap"
    t.boolean  "ss_1"
    t.boolean  "ss_2"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "password_salt",          limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "failed_attempts",        limit: 4,   default: 0
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "name",                   limit: 255
    t.integer  "site_id",                limit: 4
    t.string   "rank",                   limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
