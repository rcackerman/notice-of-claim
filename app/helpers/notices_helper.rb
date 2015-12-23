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
 
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render("notices/form_groups/" + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
