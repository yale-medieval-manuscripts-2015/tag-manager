json.array!(@solr_mappings) do |solr_mapping|
  json.extract! solr_mapping, :id, :index_category, :solrvalue, :tag_id
  json.url solr_mapping_url(solr_mapping, format: :json)
end
