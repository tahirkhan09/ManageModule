class Expense < ActiveRecord::Base
  belongs_to :events
end
