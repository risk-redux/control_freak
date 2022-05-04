module ApplicationHelper
  # Quick way to automate pretty page titles.
  def view_title(page_title)
    content_for(:title) { page_title }
  end

  # Quick way to highlight active navigation bar areas.
  def is_active(controller)
    params[:controller] == controller ? "active" : nil
  end

  def control_row(control)
    @row_class = row_class(control)

    render("shared/control_row", control: control, row_class: @row_class)
  end

  def row_class(control)
    link_types = control.links.distinct.pluck(:link_type)

    if link_types.include?('incorporated-into')
      return "incorporated-into"
    elsif link_types.include?('moved-to')
      return "moved-to"
    else
      unless control[:parent_id].nil?
        return "enhancement"
      else
        return "control"
      end
    end
  end
end
