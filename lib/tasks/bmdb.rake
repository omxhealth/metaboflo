require "rubygems"
require "mysql"

namespace :bmdb do
  desc "Read metabolites from BMDB database and export to import fixtures"
  task :import => [ :environment ] do

    dbh = Mysql.new('129.128.246.14', 'readonly', 'tardis', 'labm')
    rs = dbh.query('SELECT * FROM tbl_chemical INNER JOIN tbl_link ON tbl_chemical.id=tbl_link.id WHERE (tbl_chemical.export_hmdb="Yes" OR tbl_chemical.export_hmdb="Fozia") AND tbl_chemical.trash="No"')
    #'export_hmdb' can be 'Fozia'

    Metabolite.destroy_all

    # TODO: Replace the code below with a more robust solution
    rs.each_hash do |row|
      begin
        metabolite = Metabolite.new

        id = row['id']

        if id =~ /[^\d]+(\d+)/
          idnum = $1.to_i
        else
          $stderr.write("Error! Invalid ID: #{id}\n")
          exit(1)
        end

        metabolite.id = idnum
        metabolite.name = row['common_name']
        metabolite.bmdb_id = id     
        metabolite.description = row['description'] 
        metabolite.synonyms = row['synonyms']    
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