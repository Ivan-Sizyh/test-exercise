require_relative 'gilded_rose'

class GildedRose
  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros"
  CONJURED = "Conjured"

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      update_item_quality(item)
    end
  end

  def run_continuously
    loop do
      update_quality

      @items.each do |item|
        puts item.to_s
      end

      puts "Хотите выполнить еще одну итерацию? (yes/no)"
      input = gets.chomp.downcase

      break unless input == "yes"
    end
  end

  private

  def update_item_quality(item)
    case item.name
    when AGED_BRIE then update_aged_brie(item)
    when BACKSTAGE_PASSES then update_backstage_passes(item)
    when SULFURAS then nil # Не нужно обновлять качество
    when CONJURED then update_conjured(item)
    else update_normal_item(item)
    end

    update_sell_in(item)
    ensure_quality_bounds(item)
  end

  def update_aged_brie(item)
    item.quality = [item.quality + (item.sell_in > 0 ? 1 : 2), 50].min
  end

  def update_backstage_passes(item)
    item.quality = (item.sell_in > 0 ? [item.quality + (item.sell_in > 10 ? 1 : item.sell_in > 5 ? 2 : 3), 50].min : 0)
  end


  def update_conjured(item)
    item.quality = [item.quality - 2, 0].max
  end

  def update_normal_item(item)
    item.quality = [item.quality - (item.sell_in > 0 ? 1 : 2), 0].max
  end

  def update_sell_in(item)
    item.days_expired += 1 if item.sell_in.zero?
    item.sell_in -= 1 if !(item.name == SULFURAS) && !(item.sell_in.zero?)
  end

  def ensure_quality_bounds(item)
    item.quality = [item.quality, 0].max
    item.quality = [item.quality, 50].min unless item.name == SULFURAS
  end
end
