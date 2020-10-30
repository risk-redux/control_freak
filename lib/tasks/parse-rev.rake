namespace :rev_content do
  desc 'Parse Rev content XML.'
  task :parse => :environment do
    def parse_families(json)
      begin
        Family.destroy_all
        
        json['catalog']['groups'].each do |group|
          family = Family.create
          
          family[:acronym] = group['id']
          family[:title] = group['title']

          family.save
          
          puts "Created family: #{family[:acronym]}"
        end

        puts "Created #{Family.count} families..."
      rescue Exception => exception
        puts exception.message
      end
    end

    def parse_references(json)
      begin
        Reference.destroy_all
    
        json['catalog']['back-matter']['resources'].each do |reference|
          r = Reference.new
  
          unless reference['title'].nil?
            r[:number] = reference['title']
          else
            r[:number] = reference['id']
          end

          unless reference['citation'].nil?
            r[:citation] = reference['citation']['text']
          end

          unless reference['rlinks'].nil?
            r[:href] = reference['rlinks'][0]['href']
          end

          r.save

          puts "Created reference: #{r[:number]}"
        end
      rescue Exception => exception
        puts exception.message
      end
    end

    def parse_parameters(ctrl, parameters)
      begin
        parameters.each do |parameter|
          p = Parameter.new

          p[:control_id] = ctrl[:id]
          p[:number] = parameter['id']
          p[:label] = parameter['label']
          p[:selection] = parameter['select']
          p[:depends_on] = parameter['depends-on']
          unless parameter['select'].nil?
            p[:alternatives] = parameter['select']['alternatives']
          end

          p.save

          puts "Created parameter: #{p[:number]}"
        end
      rescue Exception => exception
        puts exception.message
      end
    end
    
    def parse_links(ctrl, links)
      begin
        links.each do |link|
          l = Link.new

          l[:control_id] = ctrl[:id]
          l[:href] = link['href']
          l[:link_type] = link['rel'] # ["reference", "related", "incorporated-into", "moved-to"]
          l[:link_text] = link['text']

          l.save

          puts "Created link: #{l[:link_text]}"
        end
      rescue Exception => exception
        puts exception.message
      end
    end

    def parse_part(control_id, parent_id, part)
      begin
        p = Part.create

        p[:control_id] = control_id
        p[:parent_id] = parent_id
        p[:number] = part["id"]
        p[:label] = part["name"]
        p[:prepend] = part["properties"].nil? ? nil : part["properties"][0]["value"]
        p[:prose] = part["prose"]

        p.save
        
        puts "Created part: #{p[:number]}"

        unless part["parts"].nil?
          part["parts"].each do |sub_part|
            parse_part(control_id, p[:id], sub_part)
          end
        end
      rescue Exception => exception
        puts exception.message
      end
    end

    def parse_control(family_id, parent_id, control)
      begin
        c = Control.create
    
        c[:family_id] = family_id
        c[:parent_id] = parent_id
        c[:number] = control['id']
        c[:title] = control['title']
        c[:is_low] = false
        c[:is_moderate] = false
        c[:is_high] = false
        c[:is_privacy] = false

        unless control['properties'].nil?
          control['properties'].each do |property|
            case property['name']
            when 'label'
              c[:label] = property['value']
            when 'status'
              c[:status] = property['value']
            when 'sort-id'
              c[:sort_number] = property['value']
            else
              raise "Unknown property: #{property['name']}: #{property['value']}"
            end
          end
        end

        c.save

        unless control['parameters'].nil?
          parse_parameters(c, control['parameters'])
        end

        unless control['links'].nil?
          parse_links(c, control['links'])
        end

        unless control['parts'].nil?
          control['parts'].each do |part|
            parse_part(c[:id], nil, part)
          end
        end

        puts "Created control: #{c[:number]}"
        return c[:id]
      rescue Exception => exception
        puts exception.message
      end
    end

    def parse_controls(json)
      begin
        Control.destroy_all
        Parameter.destroy_all
        Part.destroy_all
        Link.destroy_all
  
        json['catalog']['groups'].each do |group|
          family = Family.find_by(acronym: group['id'])
  
          group['controls'].each do |control|
            parent = parse_control(family['id'], nil, control)

            unless control['controls'].nil?
              control['controls'].each do |child|
                parse_control(family['id'], parent, child)
              end
            end
          end
  
          puts "Created #{Control.count} controls..."
        end
      rescue Exception => exception
        puts exception.message
      end
    end

    def parse_baseline(baseline, is_type)
      begin
        # Blech! NIIIST!
        baseline['profile']['imports'][0]['include']['id-selectors'].each do |control|
          puts "#{control['control-id']} #{is_type}"
          Control.find_by(number: control['control-id']).update(is_type => true)
        end

        puts "#{is_type} baseline loaded!"
      rescue Exception => exception
        puts exception.message
      end
    end

    def control_seeds()
      Control.all.each do |control|
        excluded_keys = ['created_at', 'updated_at', 'id'] 
        serialized = control
          .serializable_hash
          .delete_if{|key,value| excluded_keys.include?(key)} 
        puts "Control.create(#{serialized})\n\n"
      end
    end

    # Driver
    json = JSON.parse URI.open('https://raw.githubusercontent.com/usnistgov/oscal-content/master/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5-FINAL_catalog.json').read
    parse_families(json)
    parse_references(json)
    parse_controls(json)

    low_baseline = JSON.parse URI.open('https://raw.githubusercontent.com/usnistgov/OSCAL/master/content/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5-FPD_LOW-baseline_profile.json').read
    parse_baseline(low_baseline, :is_low)

    moderate_baseline = JSON.parse URI.open('https://raw.githubusercontent.com/usnistgov/OSCAL/master/content/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5-FPD_MODERATE-baseline_profile.json').read
    parse_baseline(moderate_baseline, :is_moderate)

    high_baseline = JSON.parse URI.open('https://raw.githubusercontent.com/usnistgov/OSCAL/master/content/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5-FPD_HIGH-baseline_profile.json').read
    parse_baseline(high_baseline, :is_high)

    privacy_baseline = JSON.parse URI.open('https://raw.githubusercontent.com/usnistgov/OSCAL/master/content/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5-FPD_PRIVACY-baseline_profile.json').read
    parse_baseline(privacy_baseline, :is_privacy)

    # control_seeds()
  end
end