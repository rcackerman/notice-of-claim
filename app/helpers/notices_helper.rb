module NoticesHelper

  INJURY_DETAILS = {
    "beaten_with_object" => "Beaten with an object",
    "choked" => "Choked",
    "pepper_sprayed" => "Pepper sprayed",
    "tasered" => "Tasered",
    "attacked_by_police_animal" => "Attacked by a police animal",
    "hit_by_police_vehicle" => "Hit by a police vehicle",
    "handcuffs_too_tight" => "Handcuffed too tightly",
    "physical_force" => "Physical force",
    "other" => "Other injury"
  }

  SEARCHED_OBJECTS_DETAILS = {
    "vehicle" => "Vehicle",
    "bag" => "Bag",
    "pockets" => "Pockets",
    "home" => "Home",
    "other" => "Other object"
  }


  def map_items detail_array, type
    if type == 'injury'
      detail_array.map! { |i| INJURY_DETAILS[i] }
    elsif type == 'searched objects'
      detail_array.map! { |i| SEARCHED_OBJECTS_DETAILS[i] }
    end
      detail_array
  end
  
end
