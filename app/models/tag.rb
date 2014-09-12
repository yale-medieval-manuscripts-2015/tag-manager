class Tag < ActiveRecord::Base
  has_many :solr_mappings, dependent: :destroy
  attr_accessible  :category, :tag, :label
end
