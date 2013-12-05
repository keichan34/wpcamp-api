namespace :feed_pollers do

  desc "Imports data from WordCamp Central"
  task :wordcamp_central => :environment do
    Importer::WordcampCentral.run
  end

  namespace :wordcamp_central do

    desc "Imports all data from WordCamp Central"
    task :deep => :environment do
      Importer::WordcampCentral.run max_pages: 200
    end

  end

end
