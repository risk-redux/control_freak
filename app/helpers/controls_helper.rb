module ControlsHelper
  def control_statement(statement)
    @number = statement.number
    @is_odv = statement.is_odv
    @parsed_number = @number[/([A-Z]{2}-[0-9]{1,2})(([a-z]\.|[0-9]\.)*|$)/, 3] # Ugh.
    @level = @number.scan(".").length # Double ugh.
    @description = statement.description

    render("controls/shared/control_statement", number: @parsed_number, level: @level, description: @description)
  end

  def baseline_panel(control, level)
    @check = check_baseline(control, level)

    render("controls/shared/control_baseline_panel", level: level, check: @check)
  end

  def check_baseline(control, level)
    case level
    when "Low"
      return @control.is_baseline_impact_low
    when "Moderate"
      return @control.is_baseline_impact_moderate
    when "High"
      return @control.is_baseline_impact_high
    else
    end
  end
end
