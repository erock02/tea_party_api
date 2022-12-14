require 'rails_helper'

describe Subscription, type: :model do
  describe "validations" do
    it {should belong_to :customer}
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:frequency) }
  end
end
