class Company < ActiveRecord::Base
  default_scope :order => 'name'

  validates :name, :presence => true, :uniqueness => true
  validates :tag, :presence => true, :uniqueness => true
  validates :currency_id, :presence => true
  validates :contact_person, :presence => true
  validates :contact_title, :presence => true
  validates :contact_phone, :presence => true
  validates :contact_email, :presence => true

  belongs_to :currency

  attr_accessible :contact_email, :contact_person, :contact_phone, :contact_title, :currency_id, :name, :tag
end
