require 'faker'

namespace :exura do

  desc "Seed data for Exura."
  task :seed => :environment do 
    
    t = Spree::Taxonomy.create :name => "Activities"
    pictograms_dir = Rails.root + "app/assets/images/pictograms/final/*.png"
    puts "Creating Activities Taxonomy"
    Dir.glob(pictograms_dir).entries.each do |file_path|
      name = file_path.gsub(pictograms_dir.to_s.gsub('*.png', ''), '').gsub('.png','').underscore.humanize.titleize
      puts ("Creating Activity Type - " + name)
      t.taxons.build(:name => name, :icon => File.open(file_path), :taxonomy_id => t.id, :parent_id => t.root.id)
      t.save
    end

    #Create requisite option type and option values
    puts "Creating option types now..."
    o = Spree::OptionType.create!(:name => "Child / Adult / Both", :presentation => "Who is this variant for?")
    ['child', 'adult', 'both'].each do |person|
      o.option_values.build({:name => "Variant for #{person.pluralize}", :presentation => person.titleize})
    end
    o.save!
  end

  task :seed_option_dates => :environment do
    o = Spree::OptionType.create!(:name => "Bookable on", :presentation => "When is this variant for")
    (Date.today..(Date.today+2.years)).each do |date|
      o.option_values.build({:name => "date", :presentation => date})
    end
    o.save!
  end


  task :create_activities => :environment do 
    t = Spree::Taxonomy.find_by_name "Activities"
    num_times = 100
    num_times.times do
      p = Spree::Product.new
      p.taxons << (y = t.taxons.sample)
      act_name = y.name
      p.city = Faker::Address.city
      p.state = Spree::Product::LIST_OF_STATES.sample
      p.price = 0
      p.street_address = Faker::Address.street_address
      p.duration = rand(60)
      p.latitude = Faker::Address.latitude
      p.longitude = Faker::Address.longitude
      p.zoom_level = rand(7) + 1
      if p.duration > 20
        p.name = "#{p.duration} min #{act_name} in #{p.city}"
      else
        p.name = "#{act_name} in #{p.city}"
      end
      p.level = Spree::Product::LEVELS.sample
      p.product_type = "Regular Activity"
      p.available_on = DateTime.now
      Date::DAYNAMES.each do |dow|
        p.send("on_hand_on_#{dow.downcase}=", rand(10)*rand(3))
      end
      puts p.save    
      
      ## Add Images
      images_dir = Rails.root + "app/assets/images/product_images/*.jpg"
      puts "Adding Images Now"
      path_arr = Dir.glob(images_dir).entries
      (rand(5) + 1).times do
        i = Spree::Image.create!( { :attachment => File.open(path_arr.sample), :viewable => p }, :without_protection => true )
        p.images << i
      end
      
      ## Add HTML Fields
      p.overview = Faker::Lorem.paragraphs(rand(5)+1).join("</p><p>")
      p.features = Faker::Lorem.paragraphs(rand(5)+1).join("</p><p>")
      p.exclusions = Faker::Lorem.paragraphs(rand(5)+1).join("</p><p>")
      k = "<ul>"
      rand(10).times do
        k += "<li> #{Faker::Lorem.sentences(rand(4) +1).join} </li>"
      end
      k += "</ul>"
      p.highlights = k
      p.save
      
      
      ## Randomly create some variants
      o = Spree::OptionType.find_by_name("Child / Adult / Both")
      p.option_types << o
      p.save
      puts "Creating variants"
      2.times do |i|
        v = Spree::Variant.new
        ot = o.option_values[i]
        v.option_values << ot
        v.price = rand(30)*100
        v.product = p
        dr = DateRange.new(:starts_at => Date.today, :ends_at => (Date.today + rand(100).days))
        v.available_dates << dr
        # Add prices on the variant for Dow
        Date::DAYNAMES.each do |dow|
          pr = rand(30)*100
          p.send("price_on_#{dow.downcase}=", pr)
        end
        v.save!
        p.variants << v
        p.save!
      end
    end
  end

end
