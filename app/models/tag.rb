class Tag < ActiveRecord::Base
  has_many :solr_mappings, dependent: :destroy
end
