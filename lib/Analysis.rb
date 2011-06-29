module Analysis  

  def pca(csv_string)
    image_path = "pca.png"
    temp_file = "#{Rails.root}/temppca.csv"
    pca_path = "#{Rails.root}/lib/R/pca.R"
    
    File.open(temp_file, 'w') do |f|
      f.puts(csv_string)
    end

    command = "Rscript #{pca_path} #{temp_file} #{Rails.root}/public/images/#{image_path}"
    system(command)
    
    return(image_path)
  end
  
  def corr(csv_string)
    image_path = "corr"
    temp_file = "#{Rails.root}/tempcorr.csv"
    corr_path = "#{Rails.root}/lib/R/corr.R"
    
    File.open(temp_file, 'w') do |f|
      f.puts(csv_string)
    end

    command = "Rscript #{corr_path} #{temp_file} #{Rails.root}/public/images/#{image_path}"
    system(command)
    
    return("#{image_path}.png")
  end
  
end