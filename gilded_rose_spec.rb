require File.join(File.dirname(__FILE__), 'gilded_rose')
require File.join(File.dirname(__FILE__), 'item')

describe GildedRose, "#update_quality" do
  let(:items) {[item]}
  let(:item) {Item.new("foo", 0, 0)}

  before do
    GildedRose.new(items).update_quality
  end

  it "does not change the name on fixme" do
    expect(item).to_not eq "fixme"
  end

  context 'then valid Item' do
    let(:item) {Item.new('Normal Item', 5, 10)}

    it 'decreases quality by 1 before sell-in date' do
      expect(items[0].quality).to eq(9)
    end

    # Какого хуя у тебя тут разные  параметры у Item.new, переделывай сам это говно
    # Если что нет смысла тестить одно и тоже несколько раз если просто чтобы убедиться что все работает, тести специфичные кейсы
    # it 'decreases quality by 2 after sell-in date' do
    #   items = [Item.new('Normal Item', -1, 10)]
    #   GildedRose.new(items).update_quality
    #   expect(items[0].quality).to eq(8)
    # end

    # it 'quality is never negative' do
    #   items = [Item.new('Normal Item', 5, 0)]
    #   GildedRose.new(items).update_quality
    #   expect(items[0].quality).to eq(0)
    # end
  end

  context 'than item is Aged Brie' do
    let(:item) {Item.new('Aged Brie', 5, 10)}

    it 'increases quality by 1' do
      expect(items[0].quality).to eq(11)
    end

    # та же хуйня

    # it 'quality is never more than 50' do
    #   items = [Item.new('Aged Brie', 5, 50)]
    #   GildedRose.new(items).update_quality
    #   expect(items[0].quality).to eq(50)
    # end
  end

  context 'than item is Backstage passes' do
    let(:item) {Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 10)}

    it 'increases quality by 1 when more than 10 days left' do
      expect(items[0].quality).to eq(11)
    end

    # та же хуйня

    # it 'increases quality by 2 when 10 days or less left' do
    #   items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)]
    #   GildedRose.new(items).update_quality
    #   expect(items[0].quality).to eq(12)
    # end

    # it 'increases quality by 3 when 5 days or less left' do
    #   items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 10)]
    #   GildedRose.new(items).update_quality
    #   expect(items[0].quality).to eq(13)
    # end

    # it 'quality drops to 0 after the concert' do
    #   items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)]
    #   GildedRose.new(items).update_quality
    #   expect(items[0].quality).to eq(0)
    # end
  end

  context 'than item is Sulfuras' do
    let(:item) {Item.new('Sulfuras, Hand of Ragnaros', 5, 80)}

    it 'does not decrease in quality' do
      expect(items[0].quality).to eq(80)
    end
  end
end
