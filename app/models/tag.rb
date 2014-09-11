class Tag < ActiveRecord::Base
  has_many :solr_mappings, dependent: :destroy
  attr_accessible :tag, :label, :category
end
