class SolrMapping < ActiveRecord::Base
  belongs_to :tag
  attr_accessible :solrfield, :solrvalue, :tag_id
end
