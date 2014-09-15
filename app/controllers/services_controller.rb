class ServicesController < ApplicationController
  respond_to :json
  def autocomplete

    tagName = params['term'].gsub(/\#/,"")

    @tagsMatched=Tag.where("tag like ?", "%#{tagName}%")


    @tagArray = Array.new

    @tagsMatched.each do | val|
      @tagArray.push(val.tag )
    end

    # respond_with(@tagsMatched.to_json)
    respond_to do | format |
      format.json { render json: @tagArray }
    end

  end


  def getTagsSolrMappings

    @tagArray = Array.new
    @tagHash = Hash.new

    @tags = Tag.all

    @tags.each do | val |
      @tagName = val.tag

      @tagArray.push(@tagName )
      # @tagHash.store("tag", tagName)

      @mappings = val.solr_mappings
      @solrHash= Hash.new
      @solrArray = Array.new

      @mappings.each do |val|
        @solrHash["solrfield"] = val.solrfield
        @solrHash["solrvalue"] = val.solrvalue
        @solrArray.push(@solrHash)
      end

      @tagArray.push(@solrArray)
      @tagHash.store(@tagName, @solrArray)
      #@tagHash[tagname] = @tagName
      #@tagHash["solr"] = @solrArray

    end
    # respond_with(@tgetTagsSolrMappings.to_json)
    respond_to do | format |
      # format.json { render json: @tagArray }
      format.json { render json: @tagHash }
    end

  end



  def getTagsSolrMappingsOrig
    @tags = Tag.all

    @tagArray = Array.new

    # @tagArray = Hash.new

    @tags.each do | val |
      tag = val.tag
      @tagArray.push(tag )

      @solrArray = Array.new
      @solr= Hash.new

      @mappings = val.solr_mappings

      @mappings.each do |val|
        @solr["solrfield"] = val.solrfield
        @solr["solrvalue"] = val.solrvalue
        @solrArray.push(@solr)
      end
      @tagArray.push(@solrArray)
    end
    # respond_with(@tgetTagsSolrMappings.to_json)
    respond_to do | format |
      format.json { render json: @tagArray }
    end

  end


end