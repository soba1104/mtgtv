require 'open-uri'
require 'fileutils'

BASE_URL = 'http://mtg-jp.com'
CARD_LIST_BASE_URL = "#{BASE_URL}/cardlist"

def detect_colors(mana)
  colors = mana.scan(/{([[:upper:]])}/).uniq.flatten
  colors.empty? ? ['O'] : colors
end

def parse_cardlist(html)
  doc = Nokogiri::HTML.parse(html)
  doc.xpath('//div[@id="main"]/div').map do |card|
    jp_name = card['id']
    en_name = card.at('a')['name'].gsub('+', ' ')
    image = BASE_URL + card.at('img')['src']
    mana = card.at('.mana').text
    colors = detect_colors(mana)
    type = card.at('.type').text
    poto = card.at('.poto').text
    power, toughness = poto.split('/').map{|v| v.to_i }
    pt = (power && toughness) ? "#{power}/#{toughness}" : nil
    text = card.at('.text').text
    rarity = card.at('.sets').text
    Card.new(jp_name, en_name, image, colors, mana, type, power, toughness, text, rarity)
  end
end

def parse_expansions(html)
  doc = Nokogiri::HTML.parse(html)
  doc.xpath('//ul[@class="entries"]/li').map do |expansion|
    a = expansion.at('a')
    name = File.basename(a['href'], '.html')
    desc = a.text
    {
      :name => name,
      :description => desc,
    }
  end
end

DSTDIR = File.expand_path(File.join(File.dirname(__FILE__), '../data'))
EXPANSIONS = "#{DSTDIR}/expansions.json"
directory DSTDIR

namespace :expansion do
  file EXPANSIONS => DSTDIR do
    url = CARD_LIST_BASE_URL
    html = open(url).read
    expansions = parse_expansions(html)
    json = expansions.to_json
    File.open(EXPANSIONS, 'w'){|f| f.write(json)}
  end

  task :load => [:environment, EXPANSIONS] do
    expansions = JSON.parse(File.read(EXPANSIONS))
    deps = []
    expansions.each do |e|
      name = e['name'].upcase
      path = File.join(DSTDIR, "#{name}.json")
      file path => DSTDIR do
        puts "loading #{name} ..."
        url = "#{CARD_LIST_BASE_URL}/list/#{name}.html"
        html = open(url).read
        cards = parse_cardlist(html)
        expansion = Expansion.from_cards(name, cards)
        json = expansion.to_json
        dst = File.join(DSTDIR, "#{name}.json")
        File.open(dst, 'w'){|f| f.write(json)}
      end
      deps << path
    end
    task(:run => deps).invoke()
  end
end
