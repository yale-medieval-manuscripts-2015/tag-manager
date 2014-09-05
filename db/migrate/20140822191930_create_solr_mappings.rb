class CreateSolrMappings < ActiveRecord::Migration
  def change
    create_table :solr_mappings do |t|
      t.string :solrfield
      t.string :solrvalue
      t.integer :tag_id

      t.timestamps
    end
  end
end
