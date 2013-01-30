module ApplicationHelper

  def number_to_indian_currency(number, html=true)
    txt = html ? content_tag(:span, 'Rs.', :class => :WebRupee) : 'Rs.'
    amt = html ? content_tag(:span, number.to_s.gsub(/(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?/, "\\1,"), :class=> :amount) : number.to_s.gsub(/(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?/, "\\1,")
    "#{txt} #{amt}".html_safe
  end

  alias :number_to_currency :number_to_indian_currency



  def printable_prices(product)
    res = ""
    ['child', 'adult', 'both'].each do |p|
      if (v = product.send("variant_for_#{p.pluralize}".to_sym))
        res += "Rs. #{product.send(('price_per_' + p).to_sym)} per #{p}, "
      end
    end
    return res
  end



  def pretty_printable_prices(pr)
    res = ""
    unless pr.is_fixed_group_size_activity?
      ['child', 'adult', 'both'].each do |p|
        if (v = pr.send("variant_for_#{p.pluralize}".to_sym))
          res += "<span class='item'>"
          res += number_to_indian_currency(pr.send(('price_per_' + p).to_sym).to_i)
          res += "<span class='small'> / #{p} </span></span>"
        end
      end
    else
      res += number_to_indian_currency(pr.price).to_i
    end
    return res.html_safe
  end



  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def super_link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end
  





  def generate_filter_params_hash(params, val)
    params_arr = [:lvl, :loc, :act]
    link_to_params_hash = {}
    if !params[:lvl].present? && !params[:loc].present? && !params[:act].present?
      return
    end
    params_arr.each do |curr|
      others = params_arr - Array(curr)
      if params[curr].present? && !params[others[0]].present? && !params[others[1]].present?
        link_to_params_hash = {curr => val}
      else
        if params[curr].present? && !params[others[0]].present? && params[others[1]].present?
        else
          if params[curr].present? && !params[others[1]].present? && params[others[0]].present?
          else
            if params[curr].present? && params[others[0]].present? && params[others[1]].present?
            end
          end
        end
      end
    end
    return link_to_params_hash
  end



  def reset_filter_url(name, value)
    value = value.gsub(' ', '+')
    request.url.gsub(name, '').gsub(value, '')
  end

  def add_filter_url(key, value)
    url = request.url
    url += "?" if request.query_string.blank?
    k = key.to_s
    v = value.gsub(' ', '+')
    url += "&" + k + "=" + v
  end

end

