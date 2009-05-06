module DietsHelper
  def setup_diet(diet)
    2.times do 
      diet.diet_ingredients.build
    end
    
    2.times do
      diet.compositions.build
    end
    
    diet
  end
end
