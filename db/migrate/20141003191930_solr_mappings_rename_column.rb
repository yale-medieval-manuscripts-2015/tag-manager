class SolrMappingsRenameColumn < ActiveRecord::Migration
  def change
    def change
      rename_column :solr_mappings, :solrfield, :solrfield
    end
  end
end
