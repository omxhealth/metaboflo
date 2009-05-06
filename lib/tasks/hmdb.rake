require "rubygems"
require "mysql"

namespace :hmdb do
  desc "Read metabolites from HMDB database and export to import fixtures"
  task :import => [ :environment ] do

    dbh = Mysql.new('129.128.185.111', 'readonly', 'tardis', 'labm')
    rs = dbh.query('SELECT * FROM tbl_chemical INNER JOIN tbl_link ON tbl_chemical.id=tbl_link.id WHERE tbl_chemical.export_hmdb="Yes" AND tbl_chemical.trash="No"')

    # TODO: Replace the code below with a more robust solution
    rs.each_hash do |row|
      begin
        metabolite = Metabolite.new

        metabolite.name = row['common_name']
        metabolite.hmdb_id = row['id']      
        metabolite.description = row['description']      
        metabolite.iupac_name = row['iupac']      
        metabolite.formula = row['chemical_formula']      
        metabolite.mono_mass = row['molecular_weight']      
        metabolite.average_mass = row['avg_molecular_weight']      
        metabolite.smiles = row['smiles_isomeric']      
        metabolite.cas = row['cas']      
        metabolite.inchi_identifier = row['InChi']      
        metabolite.melting_point = row['melting_point']      
        metabolite.state = row['state']      
        metabolite.kegg_compound_id = row['kegg_id']      
        metabolite.pubchem_compound_id = row['pubchem_cid']      
        metabolite.chebi_id = row['chebi_id']      
        metabolite.wikipedia_name = row['wiki_id']      
        if !metabolite.save
          puts "Skipping invalid metabolite: #{metabolite.full_error_messages}"
        end
      rescue Exception => msg  
        puts "Skipping invalid metabolite: #{msg}"
        next
      end
    end

    dbh.close
  end
end