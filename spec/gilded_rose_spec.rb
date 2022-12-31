require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context 'Sulfuras' do
      it "does not change the quality or sell-in date after 1 day" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
        expect(items[0].quality).to eq 80
      end

      it "does not change the quality or sell-in date after 2 days" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
        expect(items[0].quality).to eq 80
      end

      it "does not change increases the quality past 50" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
        expect(items[0].quality).to eq 50
      end

      it "does not change decreases the quality past 0" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
        expect(items[0].quality).to eq 0
      end
    end

    context 'Aged Brie' do
      it "updates the sell-in and quality after 1 day" do
        items = [Item.new("Aged Brie", 2, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 1
        expect(items[0].quality).to eq 1
      end

      it "updates the sell-in and quality after 2 days" do
        items = [Item.new("Aged Brie", 2, 0)]
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
        expect(items[0].quality).to eq 3
      end

      it "updates the sell-in and quality after 3 days and the sell-in date has passed" do
        items = [Item.new("Aged Brie", 2, 0)]
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 5
      end

      it "does not increase quality past 50" do
        items = [Item.new("Aged Brie", 0, 49)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 50
      end
    end

    context 'Normal items' do
      it "updates the sell-in and quality after 1 day" do
        items = [Item.new("Elixir of the Mongoose", 5, 7)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 6
      end

      it "updates the sell-in and quality after 2 days" do
        items = [Item.new("Elixir of the Mongoose", 5, 7)]
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 3
        expect(items[0].quality).to eq 5
      end

      it "updates the sell-in and quality when the sell-in date has passed" do
        items = [Item.new("Elixir of the Mongoose", 0, 3)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 1
      end

      it "updates the sell-in and quality when the sell-in date has passed" do
        items = [Item.new("Elixir of the Mongoose", 0, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 1
      end

      it "does not decrease the quality past 0" do
        items = [Item.new("Elixir of the Mongoose", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 0
      end
    end

    context 'Backstage passes' do
      it "updates the sell-in and quality after 1 day" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 14
        expect(items[0].quality).to eq 21
      end

      it "updates the sell-in and quality when there are 10 days left on the sell-in" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 28)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 8
        expect(items[0].quality).to eq 30
      end

      it "updates the sell-in and quality when there are 5 days left on the sell-in" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 23
      end

      it "updates the sell-in and quality when there are 5 days left on the sell-in" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 23
      end

      it "does not increase quality past 50 with less than 5 days left" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 49)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 50
      end

      it "does not increase quality past 50 with less than 5 days left and a quality of 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 50
      end

      it "does not increase quality past 50 with less than 10 days left" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 49)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 8
        expect(items[0].quality).to eq 50
      end

      it "does not increase quality past 50 with less than 10 days left and a quality of 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 8
        expect(items[0].quality).to eq 50
      end

      it "does not decrease the quality past 0" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 0
      end
    end

    context 'multiple items' do
      it 'updates multiple items correctly' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0), Item.new("Elixir of the Mongoose", 0, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 0
        expect(items[1].sell_in).to eq -1
        expect(items[1].quality).to eq 1
      end
    end

    context 'item class' do
      it 'converts to a string' do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)
        expect(item.to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 0, 0"
      end
    end
  end
end