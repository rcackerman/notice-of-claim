module NoticesHelper

  def filter_trues object
    booleans = get_booleans(object.class)
    trues = booleans.select do |k,v|
      object.send(k) == true
    end

    trues
  end

  def human_boolean label, boolean_value
    render "shared/human_boolean", locals: {item_label: label, boolean_value: boolean_value}
  end
 
  private
  def get_booleans model
    booleans = Hash[model.columns.select do |c|
      c.type == :boolean
    end.map{ |c| [c.name.to_sym, c.human_name] }]
  end

end
