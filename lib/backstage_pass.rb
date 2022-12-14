class Backstagepass
  def initialize(item)
    @item = item
  end

  def update_quality
    @item.sell_in -= 1
    if @item.sell_in <= 0
      @item.quality = 0
    elsif @item.sell_in <= 5 && @item.quality <= 47
      @item.quality += 3
    elsif @item.sell_in <= 10 && @item.quality <= 48
      @item.quality += 2
    else
      unless @item.quality == 50
        @item.quality += 1
      end
    end
  end
end