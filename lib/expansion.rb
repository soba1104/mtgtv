class Expansion
  attr_reader :name, :cards

  public

  def self.from_cards(name, cards)
    case cards[0]
    when Hash
      self.new(name, cards.map{|c| Card.from_hash(c)})
    when Card
      self.new(name, cards)
    else
      raise ArgumentError.new('card should be Card or Hash.')
    end
  end

  def self.from_json(json)
    hash = JSON.parse(json)
    from_cards(hash['name'], hash['cards'])
  end

  def to_json()
    {
      'name' => name,
      'cards' => @cards.map{|c| c.to_hash},
    }.to_json
  end

  def to_s()
    @cards.join("\n")
  end

  private

  def initialize(name, cards)
    @name = name
    @cards = cards
  end
end
