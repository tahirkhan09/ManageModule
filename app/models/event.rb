class Event < ActiveRecord::Base
  belongs_to :user
  has_many :expenses
  accepts_nested_attributes_for :expenses, :allow_destroy => true
  has_one :sign_in_sheet
end
