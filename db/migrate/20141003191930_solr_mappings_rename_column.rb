class ChangeSolrMappingsRenameColumn < ActiveRecord::Migration
  def change
    def change
      rename_column :solr_mappings, :solrfield, :index_category
    end
  end
end
