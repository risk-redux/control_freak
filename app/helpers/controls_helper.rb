module ControlsHelper
  def parameter_table(parameters)
    render("controls/shared/parameter_table", parameters: parameters.order("id ASC"))
  end

  def render_hyperlinks(prose)
    template = '<a href="\1">\1</a>'
    pattern = /\[([A-Z]{2}-[0-9]{1,2}(\([0-9]{1,2}\)){0,1})\]\(#([a-z]{2}-[0-9]{1,2}(\.[0-9]{1,2}){0,1})\)/

    return prose.gsub(pattern, template).html_safe
  end

  def render_parameters(prose)
    template = '<span class="parameter bg-warning">\1</span>'
    pattern = /{{ insert\: param\, ([a-z0-9\_\-\.\:\, ]*) }}/
    
    prose = prose.gsub(/\\n/, '')
    
    return prose.gsub(pattern, template).html_safe
  end

  def render_prose(part)
    rendered_prose = "#{part.prepend} "
    
    rendered_prose += render_parameters(part.prose)

    return rendered_prose.html_safe
  end

  def withdrawn_content(links)
    link_types = links.distinct.pluck(:link_type)

    if link_types.include?('incorporated-into')
      render("controls/shared/withdrawn_content", prefix: "Incorporated into", links: links)
    elsif link_types.include?('moved-to')
      render("controls/shared/withdrawn_content", prefix: "Moved to", links: links)
    else
      render("controls/shared/withdrawn_content", prefix: "Check out", links: links)
    end
  end

  def statement(statement, level)
    s = ActionView::OutputBuffer.new

    statement.each do |part|
      part.children.order("id ASC").each do |child|
        s << statement([child], level + 1)
      end

      unless part.prose.nil?
        s = render("controls/shared/statement", prose: render_prose(part), level: level) << s
      end

      return s
    end
  end

  def references(links)
    references = []
    reference_links = links.where(link_type: 'reference')
    reference_links.each do |r|
      # Ugh! NIIIST! Moons of Nibia!
      references += Reference.where(uuid: r.href.gsub('#',''))
    end

    render("controls/shared/references", references: references)
  end

  def relateds(links)
    relateds = []
    related_links = links.where(link_type: 'related')
    related_links.each do |r|
      # Ugh! NIIIIIIST! Antares Malestrom!
      relateds += Control.where(number: r.href.gsub('#','')).order("sort_number ASC")
    end

    render("controls/shared/relateds", relateds: relateds)
  end

  def enhancements(enhancements)
    render("controls/shared/enhancements", enhancements: enhancements)
  end

  def baseline_pills(control)
    render("controls/shared/baseline_pills", control: control)
  end

  def baseline_badges(control)
    render("controls/shared/baseline_badges", control: control)
  end

  def selection(selection)
    # Ugh! NIIIIIIIIIST! Perdition's flames!
    return eval(selection)["how-many"]
  end
end
