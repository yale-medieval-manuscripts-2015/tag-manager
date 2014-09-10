class ServicesController < ApplicationController
  # respond_to :json
  def autocomplete

    tagName = params['term'].gsub(/\#/,"")
    # p tagName
    @tagsMatched=Tag.where("tag like ?", "%#{tagName}%")


    @tagArray = Array.new

    @tagsMatched.each do | val|
      @tagArray.push(val.tag )
    end

    # respond_with(@tagsMatched.to_json)
    respond_to do |format|
      format.json { render json: @tagArray }
    end

  end
end