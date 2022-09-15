require 'rails_helper'

describe "Customer API endpoint" do
  it "subscribes customer to tea subscription" do
    customer1 = create(:customer)
    subscription1 = create(:subscription)
    subscription_params = ({
            subscription_id: subscription1.id
          })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/customers/#{customer1.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

    expect(response).to be_successful

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to have_key(:id)
    expect(parsed_json[:id]).to eq(subscription1.id)
    expect(parsed_json).to have_key(:price)
    expect(parsed_json[:price]).to eq(subscription1.price.to_s)
    expect(parsed_json).to have_key(:title)
    expect(parsed_json[:title]).to eq(subscription1.title)
    expect(parsed_json).to have_key(:status)
    expect(parsed_json[:status]).to eq(subscription1.status)
    expect(parsed_json).to have_key(:frequency)
    expect(parsed_json[:frequency]).to eq(subscription1.frequency)
  end
end
