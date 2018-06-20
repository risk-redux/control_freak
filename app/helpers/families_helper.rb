module FamiliesHelper
  def control_row(control)
    @row_class = row_class(control)

    render("families/shared/control_row", control: control, row_class: @row_class)
  end

  def row_class(control)
    if control.is_withdrawn
      return "withdrawn"
    elsif !(control.is_baseline_impact_low || control.is_baseline_impact_moderate || control.is_baseline_impact_high)
      return "not-selected"
    elsif control.is_enhancement
      return "enhancement"
    else
      return "control"
    end
  end
end
