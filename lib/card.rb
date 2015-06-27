class Card
  attr_reader :image, :jp_name, :en_name
  attr_reader :colors, :type, :mana
  attr_reader :power, :toughness, :pt
  attr_reader :text, :rarity

  public

  def self.from_hash(hash)
    Card.new(
      hash['jp_name'],
      hash['en_name'],
      hash['image'],
      hash['colors'],
      hash['mana'],
      hash['type'],
      hash['power'],
      hash['toughness'],
      hash['text'],
      hash['rarity']
    )
  end

  def initialize(jp_name, en_name, image, colors, mana, type, power, toughness, text, rarity)
    @jp_name = jp_name
    @en_name = en_name
    @image = image
    @colors = colors
    @mana = mana
    @type = type
    @power = power
    @toughness = toughness
    @pt = (@power && @toughness) ? "#{@power}/#{@toughness}" : nil
    @text = text
    @rarity = rarity
  end

  def to_hash()
    {
      'jp_name' => @jp_name,
      'en_name' => @en_name,
      'image' => @image,
      'colors' => @colors,
      'mana' => @mana,
      'type' => @type,
      'power' => @power,
      'toughness' => @toughness,
      'text' => @text,
      'rarity' => @rarity,
    }
  end

  def to_s()
    return <<-EOS
#{@image}
#{@en_name}(#{@jp_name}): #{@mana}#{@pt ? ' ' : ''}#{@pt}
#{@type}
#{@text}
#{@rarity}
    EOS
  end
end
