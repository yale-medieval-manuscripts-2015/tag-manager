namespace :import do
  desc "imports user data from a csv file"
  task :users => :environment do
    require 'csv'
    CSV.foreach('importData/users.csv') do |row|
      provider = row[0]
      uid = row[1]
      name = row[2]
      email = uid
      password = "password"
      puts row.inspect
      puts "Provider: ", provider,"uid: ",uid,"Name: ",name, "email", email
      @user = User.create(provider: provider, uid: uid, name: name, encrypted_password: password, email: email)
      @user.save!(options={validate: false})
      puts "user.provider = ", @user.provider
    end
  end

  desc "prepare csv tag-mapping file for import"
  task :prepareTags => :environment do
    require 'csv'
    thisCat = ''
    thisCat1 = ''
    thisCat2 = ''
    thisCat3 = ''
    begin
      filePrepped = File.open("importData/DesmmHashTagsPrepped.csv", "w")
      CSV.foreach("importData/MellonHashTags.csv") do |row|
          unless row[0].nil?
            thisCat =  %Q["#{row[0].to_s}"]
            thisCat1 = ''
            thisCat2 = ''
            thisCat3 = ''
          end
          unless row[1].nil?
            thisCat1 =  %Q["#{row[1].to_s}"]
            thisCat2 = ''
            thisCat3 = ''
          end
          unless row[2].nil?
            thisCat2 =  %Q["#{row[2].to_s}"]
            thisCat3 = ''
          end
          unless row[3].nil?
            thisCat3 =  %Q["#{row[3].to_s}"]
          end

          unless row[4].nil?
            tag = %Q["#{row[4]}"]
            #puts ' ===> ' + thisCat1 + ',' + thisCat1+ ',' + thisCat2 + ',' + thisCat3 + "," + tag
            filePrepped.puts(thisCat + ',' + thisCat1+ ',' + thisCat2 + ',' + thisCat3 + ',' + tag) unless tag.empty?
          end
      end
    rescue IOError => e
      #some error occur, dir not writable etc.
        puts "error"
    ensure
      filePrepped.close unless file == nil
    end
  end

  desc "imports hierarchical tag-mappings from a csv file"
  task :loadHierTags => :environment do
    require 'csv'
    label = ''

    CSV.foreach('importData/DesmmHashTagsPrepped.csv') do |row|
      # for facet hierarchy, solrfield becomes colon-delimited sequence from input tags spreadsheet
      term = ''
      category = row[0].gsub(/' '/, '_').downcase + '_t'
      solrfield = category
      solrvalue = ''
      tag = row[4]
      i = 1
      while i < 4 do
        unless row[i].nil?
          #term = row[i]#.gsub(/' '/, '_').downcase + '_t'
          #solrfield = solrfield + ":"+ term
          #solrvalue = row[i]
          #solrvalue =  %Q["#{row[i]}"]
          if solrvalue.empty?
            solrvalue += row[i]
            #solrvalue += row[i]
          else
            #solrvalue = solrvalue + ":" +  %Q["#{row[i]}"]
            solrvalue = solrvalue + ":" +  row[i]
          end
        end
        i += 1
      end

      p tag + " ==>SolrField =    " + solrfield
      #puts ""

      #first check to see if this tag already exists: if it does then find it, get the tag's id (id) and skip the tag create and just use that tag id for the solr mappings below
      existingTag = Tag.find_by(tag: tag)
      if !existingTag.nil?
        tagId = existingTag.id
      else
        @tag = Tag.create(category: category, tag: tag, label: label)
        @tag.save!(options={validate: false})
        tagId = @tag.id
      end

      # then use this existingTagId instead of tag_id below when writing the solrmapping
      #@tag does this have theid in the @tag object ?
      print "tag_id = ", tagId
      puts

      #use tagId from either the new tag or the pre-existing one
      #@solr = SolrMapping.create(solrfield: category, solrvalue: solrfield, tag_id: tag.id)
      @solr = SolrMapping.create(solrfield: solrfield, solrvalue: solrvalue, tag_id: tagId)

      @solr.save!(options={validate: false})

      print "solr.id = ", @solr.id
      puts

    end
  end

  desc "imports tag-mappings from a csv file"
  task :loadTags => :environment do
    require 'csv'
    lastTag = ''
    CSV.foreach('importData/DesmmHashTags2014_10_16.csv') do |row|

      tag = row[0]

      label = row[1]

      solrfield = row[2]
      solrfield = "Unclassified" if solrfield.nil?

      index_value = row[3]

      print "Category: ", solrfield,"  tag: ",tag, "  label: ", label, "  value: ", index_value
      puts ""
      if tag != lastTag
        @tag = Tag.create(category: solrfield, tag: tag, label: label)
        @tag.save!(options={validate: false})
      end
      #@tag does this have theid in the @tag object ?
      print "tag_id = ", @tag.id
      puts
      @solr = SolrMapping.create(solrfield: solrfield, solrvalue: index_value, tag_id: @tag.id)
      @solr.save!(options={validate: false})
      print "solr.id = ", @solr.id
      puts
      lastTag = tag
    end
  end

  desc "create tag-mappings for up and lowcase letters a..z for facet Decoration==>Initial"
  task :createInitialLetterTags => :environment do
    ("a".."z").each { |letter|
      tag = '#' + letter
      label = ''
      solrfield = 'decoration_t'
      index_value = 'Initials:Letter of Initial:' + letter
     # @tag = Tag.create(category: solrfield, tag: tag, label: label)
     # @tag.save!(options={validate: false})
     # @solr = SolrMapping.create(solrfield: solrfield, solrvalue: index_value, tag_id: @tag.id)
     # @solr.save!(options={validate: false})

      letterUpper = letter.upcase
      tag = '#' + letterUpper
      # same label, solrfield and index value (both #a and #A should say 'Initials:Letter of Initial:a')
      @tag = Tag.create(category: solrfield, tag: tag, label: label)
      @tag.save!(options={validate: false})
      @solr = SolrMapping.create(solrfield: solrfield, solrvalue: index_value, tag_id: @tag.id)
      @solr.save!(options={validate: false})
    }
  end
end