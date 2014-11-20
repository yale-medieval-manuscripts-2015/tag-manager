class ServicesController < ApplicationController
  respond_to :json
  def autocomplete

    @tagArray = Array.new
    if params['term'].start_with?("#")
      #tagName = params['term'].gsub(/\#/,"")
      tagName = params['term'].gsub(/#/,"")

      @tagsMatched=Tag.where("tag like ?", "%#{tagName}%")

      @tagsMatched.each do | val|
        @tagArray.push(val.tag )
      end
    end

    # respond_with(@tagsMatched.to_json)
    respond_to do | format |
      format.json { render json: @tagArray }
    end
end


  def getTagsSolrMappings
    tagHash = Hash.new
    tags = Tag.all

    tags.each do | val |
      tagName = val.tag

      mappings = val.solr_mappings
      solrArray = Array.new

      mappings.each do |val|
        #thisMap = Array.new
        solrHash= Hash.new
        solrHash["solrfield"] = val.solrfield
        solrHash["solrvalue"] = val.solrvalue
        solrArray.push(solrHash)
        #thisMap = solrHash.to_a
        #solrArray = solrArray + thisMap

        if tagName=="#adamandeve"
          p 'solrHash ===> ' + solrHash.to_s
          p 'solrArray ===> ' + solrArray.to_s
          p '--------------'
        end
      end

      tagHash.store(tagName, solrArray)

    end
    respond_to do | format |
      format.json { render json: tagHash }
    end

  end

end