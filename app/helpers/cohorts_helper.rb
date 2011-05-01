module CohortsHelper

  def humanized_type(type)
    case type.to_s
      when 'TestSubject' then TestSubject.title
      else type.to_s.tableize.singularize.gsub(/_/, " ").humanize
    end
  end
end
