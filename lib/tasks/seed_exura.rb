require 'faker'

namespace :exura do

  desc "Seed data for Exura."
  task :seed => :environment do 
    
    t = Taxonomies.create :name => "Activities"
    pictograms_dir = Rails.root
    puts pictograms_dir
    30.times do
      
    end
    
  end


  task :create_activities => :environment do
    

  end

end
