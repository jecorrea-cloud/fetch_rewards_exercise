require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'has an existing username' do
    expect(Transaction.create(payer: "eric", points: 7000, timestamp: "2020-11-02T14:00:00Z")).to be_valid
    expect(Transaction.create(payer: nil, points: 7000, timestamp: "2021-12-02T14:00:00Z")).to_not be_valid
    expect(Transaction.create(points: 7000, timestamp: "2022-01-02T14:00:00Z")).to_not be_valid
  end

  it 'has an existing timestamp' do
    expect(Transaction.create(payer: "eric", points: 7000, timestamp: "2020-11-02T14:00:00Z")).to be_valid
    expect(Transaction.create(payer: "cindy", points: 7000, timestamp: nil)).to_not be_valid
    expect(Transaction.create(payer: "jason", points: 7000)).to_not be_valid
  end

  it 'has existing points' do
    expect(Transaction.create(payer: "eric", points: 7000, timestamp: "2020-11-02T14:00:00Z").points).to be_a(Integer)
    expect(Transaction.create(payer: "eric", points: 7000, timestamp: "2020-11-02T14:00:00Z")).to be_valid
    expect(Transaction.create(payer: "cindy", points: nil, timestamp: "2021-12-02T14:00:00Z")).to_not be_valid
    expect(Transaction.create(payer: "jason", timestamp: "2022-01-02T14:00:00Z")).to_not be_valid
  end

  it 'has positive points' do
    expect(Transaction.create(payer: "eric", points: 7000, timestamp: "2020-11-02T14:00:00Z")).to be_valid
    expect(Transaction.create(payer: "dannon", points: -200, timestamp: "2021-12-02T14:00:00Z")).to_not be_valid
  end
end
