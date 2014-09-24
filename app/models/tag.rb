class Tag < ActiveRecord::Base
  has_many :solr_mappings, dependent: :destroy
  attr_accessible  :category, :tag, :label, :description
  validates :category, length: { minimum: 2 }
  validates :tag, length: { minimum: 2 }, format: { :with => /\A\#/, message: "must start with '#''"}
  validates :label, length: { minimum: 1 }
  validates :label, length: { minimum: 2 }
end
