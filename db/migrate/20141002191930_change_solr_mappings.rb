class ChangeSolrMappings < ActiveRecord::Migration
  def change
    def change
      remove_column :solr_mappings, :solrfield
      add_column :solr_mappings, :index_category, :string
    end
  end
end
