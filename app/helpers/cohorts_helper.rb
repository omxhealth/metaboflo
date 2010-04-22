module CohortsHelper

  def humanized_type(type)
    type.to_s.tableize.singularize.gsub(/_/, " ").humanize
  end
end
