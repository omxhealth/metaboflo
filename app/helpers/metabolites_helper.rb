module MetabolitesHelper
  MOLDB_BASE = 'http://structures.wishartlab.com/molecules'
  
  def structure_thumb(id)
    image_tag("#{MOLDB_BASE}/#{id}/structure", :class => 'structure')
  end
  
  def html_formula(formula)
    formula.to_s.gsub(/(\d+)/, '<sub>\1</sub>').html_safe
  end
end
