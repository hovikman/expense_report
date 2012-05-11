class Currency < ActiveRecord::Base
  default_scope :order => 'code'
  validates :name, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true
  attr_accessible :code, :name
end
