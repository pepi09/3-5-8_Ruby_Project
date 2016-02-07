require_relative 'spec_helper.rb'

describe Card do
  it "returns the color of the card" do
    expect(Card.new("heart", "Q").color).to eq 'heart'
  end

  it "returns the value of the card" do
    expect(Card.new("heart", "Q").value).to eq 'Q'
  end

  it "returns the card" do
    card =  {:heart => 'Q'}
    expect(Card.new("heart", "Q").card).to eq card
  end

  it 'prints the card humanized' do
    card = Card.new("heart", "Q")

    expect(card.humanize).to eq "Q of hearts"
  end
end