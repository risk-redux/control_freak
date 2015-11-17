module FamiliesHelper
  def control_row(control)
    @row_type = row_type(control)
    @row_class = row_class(@row_type)

    render("families/shared/control_row", control: control, row_class: @row_class)
  end

  def row_class(row_type)
    if (row_type == "Withdrawn") || (row_type == "Not selected")
      return "ignore"
    end
  end

  def row_type(control)
    if control.is_withdrawn == true
      return "Withdrawn"
    elsif !(control.is_baseline_impact_low || control.is_baseline_impact_moderate || control.is_baseline_impact_high)
      return "Not selected"
    else
      return "Normal"
    end
  end
end
