require 'open-uri'
require 'fileutils'

BASE_URL = 'http://mtg-jp.com'
CARD_LIST_BASE_URL = "#{BASE_URL}/cardlist"

def parse_cardlist(html)
  doc = Nokogiri::HTML.parse(html)
  doc.xpath('//div[@id="main"]/div').map do |card|
    jp_name = card['id']
    en_name = card.at('a')['name'].gsub('+', ' ')
    image = BASE_URL + card.at('img')['src']
    mana = card.at('.mana').text
    type = card.at('.type').text
    poto = card.at('.poto').text
    power, toughness = poto.split('/').map{|v| v.to_i }
    pt = (power && toughness) ? "#{power}/#{toughness}" : nil
    text = card.at('.text').text
    rarity = card.at('.sets').text
    Card.new(jp_name, en_name, image, mana, type, power, toughness, text, rarity)
  end
end

task :expansion, [:name] => :environment do |task, args|
  name = args[:name].upcase
  url = "#{CARD_LIST_BASE_URL}/list/#{name}.html"
  html = open(url).read
  cards = parse_cardlist(html)
  expansion = Expansion.from_cards(name, cards)
  json = expansion.to_json
  dst = File.join(Padrino.root, 'data', "#{name}.json")
  FileUtils.mkdir_p(File.dirname(dst))
  File.open(dst, 'w'){|f| f.write(json)}
end
