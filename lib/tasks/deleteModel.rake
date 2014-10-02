namespace :delModel do
  desc "delete all tags"
  task :delTags => :environment do
      Tag.delete_all
  end
  desc "delete all solrmappings"
  task :delSolr => :environment do
    SolrMapping.delete_all
  end
end