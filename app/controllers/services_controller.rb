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
    @tagHash = Hash.new
    @tags = Tag.all

    @tags.each do | val |
      @tagName = val.tag

      @mappings = val.solr_mappings
      @solrHash= Hash.new
      @solrArray = Array.new

      @mappings.each do |val|
        @solrHash["solrfield"] = val.solrfield
        @solrHash["solrvalue"] = val.solrvalue
        @solrArray.push(@solrHash)
      end

      @tagHash.store(@tagName, @solrArray)

    end
    respond_to do | format |
      format.json { render json: @tagHash }
    end

  end

end