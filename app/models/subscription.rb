class Subscription < ApplicationRecord
  belongs_to :customer

  validates_presence_of :title, :price, :status, :frequency

  enum status: { active: 0, cancelled: 1 }
end
