class CreateMetabolites < ActiveRecord::Migration
  def self.up
    create_table :metabolites do |t|
      t.string :name
      t.text :synonyms
      t.string :bmdb_id
      t.text :description
      t.text :iupac_name
      t.string :formula
      t.float :mono_mass
      t.float :average_mass
      t.text :smiles
      t.string :cas
      t.text :inchi_identifier
      t.string :melting_point
      t.string :state
      t.string :kegg_compound_id
      t.string :pubchem_compound_id
      t.string :chebi_id
      t.string :wikipedia_name
      t.text :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :metabolites
  end
end
