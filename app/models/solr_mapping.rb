class SolrMapping < ActiveRecord::Base
  belongs_to :tag
  attr_accessible :solrfield, :solrvalue, :tag_id
  validates :solrvalue, length: { minimum: 2, message: "must be at least 2 characters" }
end
