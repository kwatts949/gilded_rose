require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 40
      expect(items[0].sell_in).to eq 0
    end
  end
end