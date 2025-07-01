namespace :rev_content do
  desc 'Parse Rev content XML.'
  task :parse => :environment do
    def parse_catalog(json)
      puts "\n\n\nParsing Catalog"
      puts "********************************************************************************"
      begin
        Catalog.destroy_all

        catalog = Catalog.create

        catalog[:uuid] = json['catalog']['uuid']
        catalog[:title] = json['catalog']['metadata']['title']
        catalog[:version] = json['catalog']['metadata']['version']
        catalog[:oscal_version] = json['catalog']['metadata']['oscal-version']

        catalog.save
        puts "Created catalog: #{catalog[:uuid]}"
      rescue Exception => exception
        puts exception.message
      end
      puts "********************************************************************************"
      puts "\n\n\n"
    end

    def parse_families(json)
      puts "\n\n\nParsing Families"
      puts "********************************************************************************"
      begin
        Family.destroy_all
        
        json['catalog']['groups'].each do |group|
          if group['class'] == 'family'
            family = Family.create
            
            family[:acronym] = group['id']
            family[:title] = group['title']

            family.save
            
            puts "Created family: #{family[:acronym]}"
          else
            puts "Found non-family `group`: #{group['id']}"
          end
        end

        puts "Created #{Family.count} families..."
      rescue Exception => exception
        puts exception.message
      end
      puts "********************************************************************************"
      puts "\n\n\n"
    end

    def parse_references(json)
      puts "\n\n\nParsing References"
      puts "********************************************************************************"
      begin
        Reference.destroy_all
    
        json['catalog']['back-matter']['resources'].each do |reference|
          r = Reference.new
  
          unless reference['title'].nil?
            r[:number] = reference['title']
          else
            r[:number] = reference['id']
          end
          
          unless reference['uuid'].nil?
            r[:uuid] = reference['uuid']
          end

          unless reference['citation'].nil?
            r[:citation] = reference['citation']['text']
          end

          unless reference['rlinks'].nil?
            r[:href] = reference['rlinks'][0]['href']
          end

          r.save

          puts "Created reference: #{r[:number]}, #{r[:uuid]}"
        end
      rescue Exception => exception
        puts exception.message
      end
      puts "********************************************************************************"
      puts "\n\n\n"
    end

    def parse_parameters(ctrl, parameters)
      puts "\n\n\n\t\t\tParsing Parameters"
      puts "\t\t\t********************************************************************************"
      begin
        parameters.each do |parameter|
          p = Parameter.new

          p[:control_id] = ctrl[:id]
          p[:number] = parameter['id']
          p[:label] = parameter['label']
          p[:selection] = parameter['select']
          unless parameter['select'].nil?
            p[:how_many] = parameter['select']['how-many'] || 'one'
            p[:choices] = parameter['select']['choice']
          end
          unless parameter['usage'].nil?
            p[:usage] = parameter['usage']
          end

          p.save

          puts "\t\t\tCreated parameter: #{p[:number]}"
        end
      rescue Exception => exception
        puts exception.message
      end
      puts "\t\t\t********************************************************************************"
      puts "\n\n\n"
    end
    
    def parse_links(ctrl, links)
      puts "\n\n\n\t\t\tParsing Links"
      puts "\t\t\t********************************************************************************"
      begin
        links.each do |link|
          l = Link.new

          l[:control_id] = ctrl[:id]
          l[:link_type] = link['rel'] # ["reference", "related", "incorporated-into", "moved-to"]

          l[:href] = link['href']
          l[:link_text] = link['href']

          l.save

          puts "\t\t\tCreated link: #{l[:link_text]}"
        end
      rescue Exception => exception
        puts exception.message
      end
      puts "\t\t\t********************************************************************************"
      puts "\n\n\n"
    end

    def parse_part(control_id, parent_id, part)
      puts "\n\n\n\t\t\tParsing Parts"
      puts "\t\t\t********************************************************************************"
      begin
        p = Part.create

        p[:control_id] = control_id
        p[:parent_id] = parent_id
        p[:number] = part["id"]
        p[:label] = part["name"]
        p[:prepend] = part["props"].nil? ? nil : part["props"][0]["value"]
        p[:prose] = part["prose"]

        p.save
        
        puts "\t\t\tCreated part: #{p[:number]}"

        unless part["parts"].nil?
          part["parts"].each do |sub_part|
            parse_part(control_id, p[:id], sub_part)
          end
        end
      rescue Exception => exception
        puts exception.message
      end
      puts "\t\t\t********************************************************************************"
      puts "\n\n\n"
    end
    
    def parse_control(family_id, parent_id, control)
      puts "\n\n\nParsing Control"
      puts "********************************************************************************"
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

        unless control['props'].nil?
          control['props'].each do |property|
            case property['name']
            when 'label'
              c[:label] = property['value']
            when 'status'
              c[:status] = property['value']
            when 'sort-id'
              c[:sort_number] = property['value']
            when 'implementation-level'
              c[:implementation_level] = property['value']
            when 'contributes-to-assurance'
              c[:contributes_to_assurance] = ( property['value'] == 'true' )
            else
              raise "Unknown property: #{property['name']}: #{property['value']}"
            end
          end
        end

        c.save

        unless control['params'].nil?
          parse_parameters(c, control['params'])
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
        puts "********************************************************************************"
        puts "\n\n\n"
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
      puts "\n\n\nParsing baseline"
      puts "********************************************************************************"
      begin
        # Blech! NIIIST!
        baseline['profile']['imports'][0]['include-controls'][0]['with-ids'].each do |control|
          begin
            puts "#{control} #{is_type}"
            Control.find_by(number: control).update(is_type => true)
          rescue Exception => exception
            puts "#{control} not found!"
          end
        end

        puts "#{is_type} baseline loaded!"
      rescue Exception => exception
        puts exception.message
      end
      puts "********************************************************************************"
      puts "\n\n\n"
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
    catalog_location = URI('https://raw.githubusercontent.com/usnistgov/oscal-content/master/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5_catalog.json')
    catalog = Net::HTTP.get_response(catalog_location)
    json = JSON.parse catalog.body
    parse_catalog(json)
    parse_families(json)
    parse_references(json)
    parse_controls(json)

    low_location = URI.parse('https://raw.githubusercontent.com/usnistgov/oscal-content/master/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5_LOW-baseline_profile.json')
    low = Net::HTTP.get_response(low_location)
    low_baseline = JSON.parse low.body
    parse_baseline(low_baseline, :is_low)

    moderate_location = URI.parse('https://raw.githubusercontent.com/usnistgov/oscal-content/master/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5_MODERATE-baseline_profile.json')
    moderate = Net::HTTP.get_response(moderate_location)
    moderate_baseline = JSON.parse moderate.body
    parse_baseline(moderate_baseline, :is_moderate)

    high_location = URI.parse('https://raw.githubusercontent.com/usnistgov/oscal-content/master/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5_HIGH-baseline_profile.json')
    high = Net::HTTP.get_response(high_location)
    high_baseline = JSON.parse high.body
    parse_baseline(high_baseline, :is_high)

    privacy_location = URI.parse('https://raw.githubusercontent.com/usnistgov/oscal-content/master/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5_PRIVACY-baseline_profile.json')
    privacy = Net::HTTP.get_response(privacy_location)
    privacy_baseline = JSON.parse privacy.body
    parse_baseline(privacy_baseline, :is_privacy)

    # control_seeds()
  end
end