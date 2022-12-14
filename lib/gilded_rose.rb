class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if check_quality(item)
        if item.name == 'Aged Brie'
          aged_brie(item)
        else
          normal_item(item)
        end
      end
    end
  end

  def check_quality(item)
    if item.quality <= 50 && item.quality >= 0
      return true
    end
  end

  def sulfuras(item)
    if item.name == 'Sulfuras, Hand of Ragnaros'
      item
    end
  end

  def aged_brie(item)
    p item
    if item.sell_in <= 0 && item.quality <= 48
      item.sell_in -= 1
      item.quality += 2
    else
      item.sell_in -= 1
      item.quality += 1 unless item.quality >= 50
    end
  end

  def normal_item
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
