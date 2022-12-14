require_relative './aged_brie'
require_relative './sulfuras'
require_relative './backstage_pass'
require_relative './normal_items'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
        if item.name == 'Aged Brie'
          brie = Agedbrie.new(item)
          brie.update_quality
        elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
          pass = Backstagepass.new(item)
          pass.update_quality
        elsif item.name == 'Sulfuras, Hand of Ragnaros'
          sulfuras = Sulfuras.new(item)
          sulfuras.update_quality
        else
          normal = Normal_items.new(item)
          normal.update_quality
        end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
