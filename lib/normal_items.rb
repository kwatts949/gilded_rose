class Normal_items
  def initialize(item)
    @item = item
  end

  def update_quality
  @item.sell_in -= 1
    if @item.sell_in <= 0
      unless @item.quality <= 1
        @item.quality -= 2
      end
    else
      @item.quality -= 1
    end
  end
end