class Event < ActiveRecord::Base
  belongs_to :user
  has_many :expenses
  has_one :sign_in_sheet
end
