class Event < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :event_datetimes
  has_one :event_category

  validates :title, presence: true

  aasm(column: 'status', no_direct_assignment: true) do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end
end
