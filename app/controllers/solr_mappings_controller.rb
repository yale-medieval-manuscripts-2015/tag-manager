class SolrMappingsController < ApplicationController
  before_action :set_solr_mapping, only: [:show, :edit, :update, :destroy, :edit_from_tag]
  # before_action redirect_to @tags, only: [:index, :show, :new, :edit, :update]


  # GET /solr_mappings
  # GET /solr_mappings.json
  def index
    @solr_mappings = SolrMapping.all
  end

  # GET /solr_mappings/1
  # GET /solr_mappings/1.json
  def show
  end

  # GET /solr_mappings/new
  def new
    @solr_mapping = SolrMapping.new
  end

  # GET /solr_mappings/1/edit
  def edit
  end

  def edit_from_tag
  end

  def new_from_tag
    @solr_mapping = SolrMapping.new
    @solr_mapping.tag_id =params[:id]
  end

  # POST /solr_mappings
  # POST /solr_mappings.json
  def create
    @solr_mapping = SolrMapping.new(solr_mapping_params)

    respond_to do |format|
      if @solr_mapping.save
        # format.html { redirect_to @solr_mapping, notice: 'Solr mapping was successfully created.' }
        format.html { redirect_to :controller =>'tags', :action => 'edit', :id => @solr_mapping.tag_id, notice: 'Solr mapping was successfully created.' }
        format.json { render action: 'show', status: :created, location: @solr_mapping }
      else
        format.html { render action: 'new' }
        format.json { render json: @solr_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /solr_mappings/1
  # PATCH/PUT /solr_mappings/1.json
  def update
    respond_to do |format|
      if @solr_mapping.update(solr_mapping_params)
        flash[:success] = "Solr mapping created!"
        # format.html { redirect_to @solr_mapping, notice: 'Solr mapping was successfully updated.' }
        format.html { redirect_to :controller =>'tags', :action => 'edit', :id => @solr_mapping.tag_id, notice: 'Solr mapping was successfully updated.' }

        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @solr_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solr_mappings/1
  # DELETE /solr_mappings/1.json
  def destroy
    @solr_mapping.destroy
    respond_to do |format|
      format.html { redirect_to solr_mappings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solr_mapping
      @solr_mapping = SolrMapping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solr_mapping_params
      params.require(:solr_mapping).permit(:index_category, :solrvalue, :tag_id)
    end
end
