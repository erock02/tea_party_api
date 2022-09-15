class Tea < ApplicationRecord
  has_many :subscriptions
  validates_presence_of :title, :description, :temperature, :brew_time
end
