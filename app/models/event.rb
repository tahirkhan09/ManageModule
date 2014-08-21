class Event < ActiveRecord::Base
  belongs_to :user
  has_many :expenses,  -> { order 'created_at asc' } , :dependent => :destroy
  accepts_nested_attributes_for :expenses, :allow_destroy => true
  has_one :sign_in_sheet, :dependent => :destroy

  validates  :event_id_dlp, presence: true
  validates :event_id_smi, presence: true
  validates :event_type, presence: true
  validates :rep_name, presence: true
  validates :speaker_name, presence: true
  validates :event_date, presence: true
  validates :quarter, presence: true
  validates :event_city, presence: true
  validates :event_state, presence: true
  validates :speaker_city, presence: true
  validates :speaker_state, presence: true
  validates :speaker_travel_required, presence: true

end
