module ControlsHelper
  def parameter_table(parameters)
    render("controls/shared/parameter_table", parameters: parameters)
  end

  def render_prose(part)
    rendered_prose = "#{part.prepend} "
    
    rendered_prose += part.prose.gsub(/{{ ([a-z0-9\_\-\.]*) }}/, '<span class="bg-warning"><strong><em>\1</em></strong></span>' ).html_safe

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
      part.children.each do |child|
        s += statement([child], level + 1)
      end

      unless part.prose.nil?
        s = render("controls/shared/statement", prose: render_prose(part), level: level) + s
      end

      return s
    end
  end

  def references(links)
    references = []
    reference_links = links.where(link_type: 'reference')
    reference_links.each do |r|
      references += Reference.where(number: r.link_text)
    end

    render("controls/shared/references", references: references)
  end

  def relateds(links)
    relateds = []
    related_links = links.where(link_type: 'related')
    related_links.each do |r|
      relateds += Control.where(number: r.link_text.downcase)
    end

    render("controls/shared/relateds", relateds: relateds)
  end
end
