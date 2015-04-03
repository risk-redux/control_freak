module ControlsHelper
  def control_statement(statement)
    @number = statement.number
    @is_odv = statement.is_odv
    @parsed_number = @number[/([A-Z]{2}-[0-9]{1,2})(([a-z]\.|[0-9]\.)*|$)/, 3] # Ugh.
    @level = @number.scan(".").length # Double ugh.
    @description = statement.description
    @parsed_description = @is_odv ? parsed_description(@description) : @description

    render("controls/shared/statement", number: @parsed_number, level: @level, description: @description)
  end

  def parsed_description(description)
    @parsed_description = description.insert(description.index('['), "<mark>")
    @parsed_description = @parsed_description.insert(description.index(']')+1, "</mark>")
    @parsed_description
  end

  def baseline_panels(control)
    @checks = {
      "Low" => control.is_baseline_impact_low,
      "Moderate" => control.is_baseline_impact_moderate,
      "High" => control.is_baseline_impact_high
    }

    render("controls/shared/baseline_panels", checks: @checks)
  end

  def baseline_labels(control)
    @checks = {
      "Low" => control.is_baseline_impact_low,
      "Moderate" => control.is_baseline_impact_moderate,
      "High" => control.is_baseline_impact_high
    }

    render("controls/shared/baseline_labels", checks: @checks)
  end

  def control_supplement(supplement)
    if supplement.nil?
    else
      render("controls/shared/supplement", supplement: supplement)
    end
  end
  def related_controls(supplement)
    if supplement.nil?
    else
      render("controls/shared/related_controls", supplement: supplement)
    end
  end
end
