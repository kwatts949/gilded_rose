class Agedbrie

  def initialize(item)
    @item = item
  end
  
  def update_quality()
    @item.sell_in -= 1
    if @item.sell_in <= 0 && @item.quality <= 48
      @item.quality += 2
    else
      @item.quality += 1 unless @item.quality >= 50
    end
  end
end