class UserType < ActiveRecord::Base
  default_scope :order => 'name'
  validates :name, :presence => true, :uniqueness => true
  attr_accessible :name
end
