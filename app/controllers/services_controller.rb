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
    @tags = Tag.all

    @tagArray = Array.new

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