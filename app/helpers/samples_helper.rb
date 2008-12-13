module SamplesHelper
  VOLUME_UNITS = [ 'mL', 'L' ]
  WEIGHT_UNITS = [ 'g' ]
  CONCENTRATION_UNITS = [ 'mol/L' ]
  
  def unit_options
    VOLUME_UNITS.concat(WEIGHT_UNITS).concat(CONCENTRATION_UNITS).sort
  end

  def volume_unit_options
    VOLUME_UNITS.sort
  end

  def weight_unit_options
    WEIGHT_UNITS.sort
  end

  def concentration_unit_options
    CONCENTRATION_UNITS.sort
  end

end
