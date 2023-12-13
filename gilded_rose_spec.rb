require File.join(File.dirname(__FILE__), 'gilded_rose')
require File.join(File.dirname(__FILE__), 'item')

describe GildedRose do
  let(:normal_item) { [Item.new('Normal Item', 5, 10)] }
  let(:aged_brie) { Item.new('Aged Brie', 5, 10) }
  let(:backstage_passes) { Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 10) }
  let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 5, 80) }

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to_not eq "fixme"
    end

    context 'Normal Item' do
      it 'decreases quality by 1 before sell-in date' do
        GildedRose.new(normal_item).update_quality
        expect(normal_item.quality).to eq(9)
      end

      it 'decreases quality by 2 after sell-in date' do
        items = [Item.new('Normal Item', -1, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(8)
      end

      it 'quality is never negative' do
        items = [Item.new('Normal Item', 5, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(0)
      end
    end

    context 'Aged Brie' do
      it 'increases quality by 1' do
        GildedRose.new(aged_brie).update_quality
        expect(aged_brie.quality).to eq(11)
      end

      it 'quality is never more than 50' do
        items = [Item.new('Aged Brie', 5, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(50)
      end
    end

    context 'Backstage passes' do
      it 'increases quality by 1 when more than 10 days left' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 10)]
        GildedRose.new(items).update_quality
        expect(backstage_passes.quality).to eq(11)
      end

      it 'increases quality by 2 when 10 days or less left' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(12)
      end

      it 'increases quality by 3 when 5 days or less left' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(13)
      end

      it 'quality drops to 0 after the concert' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(0)
      end
    end

    context 'Sulfuras' do
      it 'does not decrease in quality' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 5, 80)]
        GildedRose.new(items).update_quality
        expect(sulfuras.quality).to eq(80)
      end
    end
  end
end
