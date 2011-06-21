module UrlHelper
  def link_out(site, id, name=nil, html_options={})
    if html_options[:class].present?
      html_options[:class] << ' link-out'
    else
      html_options[:class] = 'link-out'
    end
    name ||= "#{id}" # Use the ID as the name if no name is provided (force a copy to avoid changing the value of id)

    unless id.blank?
      name << " " << image_tag('link_out.png', :class => 'link').html_safe
      link_to(name.html_safe, url_out(site, id), html_options)
    end
	end
	
	def url_out(site, id)
	  case site.to_sym
      when :pubchem_compound          then "http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?cid=#{id}"
      when :pubchem_substance         then "http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=#{id}"
      when :kegg_compound             then "http://www.genome.jp/dbget-bin/www_bget?cpd:#{id}"
      when :kegg_drug                 then "http://www.genome.jp/dbget-bin/www_bget?drug:#{id}"
      when :kegg_pathway              then "http://www.genome.jp/kegg/pathway/map/#{id}.html"
      when :chebi                     then "http://www.ebi.ac.uk/chebi/searchId.do?chebiId=#{id}"
      when :chembl                    then "http://www.ebi.ac.uk/chembldb/index.php/compound/inspect/#{id}"
      when :kegg_map                  then "http://www.genome.jp/kegg/pathway/map/#{id}.html"
      when :wikipedia                 then "#{id}"
      when :uniprot                   then "http://www.uniprot.org/uniprot/#{id}"
      when :genbank                   then "http://www.ncbi.nlm.nih.gov/entrez/viewer.fcgi?val=#{id}"
      when :het                       then "http://www.ebi.ac.uk/msd-srv/chempdb/cgi-bin/cgi.pl?FUNCTION=getByCode&CODE=#{id}"
      when :pdb                       then "http://www.rcsb.org/pdb/explore/sequence.do?structureId=#{id}"
      when :genbank                   then "http://www.ncbi.nlm.nih.gov/entrez/viewer.fcgi?val=#{id}"          
      when :hgnc                      then "http://www.genenames.org/data/hgnc_data.php?hgnc_id=#{id}"
      when :genecard                  then "http://www.genecards.org/cgi-bin/carddisp.pl?gene=#{id}"         
      when :genatlas                  then "http://www.dsi.univ-paris5.fr/genatlas/fiche1.php?symbol=#{id}"
      when :pubmed                    then "http://www.ncbi.nlm.nih.gov/pubmed/#{id}"                    
      when :drugbank                  then "http://www.drugbank.ca/drugs/#{id}"
      when :hmdb                      then "http://www.hmdb.ca/metabolites/#{id}"
      when :chemspider                then "http://www.chemspider.com/Chemical-Structure.#{id}.html"
      when :bindingdb                 then "http://www.bindingdb.org/bind/chemsearch/marvin/MolStructure.jsp?monomerid=#{id}"
      when :smpdb                     then "http://smpdb.ca/pathways/#{id}"
      when :smpdb_thumb               then "http://pathman.smpdb.ca/images/thumb/#{id}"
      when :snpjam                    then "http://snpjam.wishartlab.com/genes/#{id}"
      when :dbsnp                     then "http://www.ncbi.nlm.nih.gov/SNP/snp_ref.cgi?rs=#{id}"
      else                            raise ArgumentError, "given site does not exist"
    end
  end
end