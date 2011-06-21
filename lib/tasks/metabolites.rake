require "rubygems"

namespace :metabolites do
  desc "Read metabolites from HMDB database and export to import fixtures"
  task :import => [ :environment ] do

    #dbh = Mysql.new('129.128.246.14', 'readonly', 'tardis', 'labm')
    dbh = Mysql2::Client.new(:host => "hmp.biology.ualberta.ca", :username => "readonly", :password => 'tardis', :database => 'labm')
    # dbh = Mysql.new('hmp.biology.ualberta.ca', 'readonly', 'tardis', 'labm')
    rs = dbh.query('SELECT * FROM tbl_chemical INNER JOIN tbl_link ON tbl_chemical.id=tbl_link.id WHERE tbl_chemical.export_hmdb="Yes" AND tbl_chemical.trash="No"')
    #'export_hmdb' can be 'Fozia'

    Metabolite.delete_all

    # TODO: Replace the code below with a more robust solution
    rs.each do |row|
      begin
        metabolite = Metabolite.new

        id = row['id']

        if id =~ /[^\d]+(\d+)/
          idnum = $1.to_i
        else
          $stderr.write("Error! Invalid ID: #{id}\n")
          exit(1)
        end

        metabolite.id                  = idnum
        metabolite.name                = row['common_name']
        metabolite.hmdb_id             = id     
        metabolite.description         = row['description'] 
        metabolite.synonyms            = row['synonyms']    
        metabolite.iupac_name          = row['iupac']      
        metabolite.formula             = row['chemical_formula']      
        metabolite.mono_mass           = row['molecular_weight']      
        metabolite.average_mass        = row['avg_molecular_weight']      
        metabolite.smiles              = row['smiles_isomeric']      
        metabolite.cas                 = row['cas']      
        metabolite.inchi_identifier    = row['InChi']      
        metabolite.melting_point       = row['melting_point']      
        metabolite.state               = row['state']      
        metabolite.kegg_compound_id    = row['kegg_id']      
        metabolite.pubchem_compound_id = row['pubchem_cid']      
        metabolite.chebi_id            = row['chebi_id']      
        metabolite.wikipedia_name      = row['wiki_id'] 
        
        pathways_rs = dbh.query("SELECT * FROM tbl_smppathway INNER JOIN mmt_join_smppathway ON tbl_smppathway.id=mmt_join_smppathway.smppathway_id WHERE mmt_join_smppathway.type_id='#{metabolite.hmdb_id}'")
        metabolite.pathways = pathways_rs.each.collect { |pathway_row| "#{pathway_row['smp_id']}:#{pathway_row['name']}" }.join("|")
          
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