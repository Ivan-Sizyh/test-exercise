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
    continue = 'yes'

    while continue == "yes"
      @items.each do |item|
        item.quality = 0 if item.quality.negative?
        puts item.to_s
      end

      update_quality

      puts "Хотите выполнить еще одну итерацию? (yes/любое другое слово)"
      continue = gets.chomp.downcase
    end
  end

  private

  def update_item_quality(item)
    case
    when item.name.include?(AGED_BRIE)
      update_aged_brie(item)
    when item.name.include?(BACKSTAGE_PASSES)
      update_backstage_passes(item)
    when item.name.include?(SULFURAS)
      nil # Не нужно обновлять качество
    when item.name.include?(CONJURED)
      update_conjured(item)
    else
      update_normal_item(item)
    end

    update_sell_in(item)
    ensure_quality_bounds(item)
  end

  def update_aged_brie(item)
    quality_increase = (item.sell_in > 0 ? 1 : 2)
    item.quality = [item.quality + quality_increase, 50].min
  end

  def update_backstage_passes(item)
    quality_increase = case
                       when item.sell_in > 10 then 1
                       when item.sell_in > 5 then 2
                       else 3
                       end

    item.quality = [item.quality + quality_increase, 50].min if item.sell_in > 0
    item.quality = 0 if item.sell_in <= 0
  end


  def update_conjured(item)
    item.quality = [item.quality - 2, 0].max
  end

  def update_normal_item(item)
    quality_increase = item.sell_in > 0 ? 1 : 2
    item.quality = [item.quality - quality_increase, 0].max
  end

  def update_sell_in(item)
    item.days_expired += 1 if item.sell_in.zero?
    item.sell_in -= 1 unless item.name.include?(SULFURAS) || item.sell_in.zero?
  end

  def ensure_quality_bounds(item)
    item.quality = [item.quality, 0].max
    item.quality = [item.quality, 50].min unless item.name.include?(SULFURAS)
  end
end
