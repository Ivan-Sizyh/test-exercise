require_relative 'gilded_rose'

class GildedRose
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

      check_expired_items

      puts "Хотите выполнить еще одну итерацию? (yes/no)"
      input = gets.chomp.downcase

      break unless input == "yes"
    end
  end

  private

  def update_item_quality(item)
    case item.name
    when "Aged Brie"
      update_aged_brie(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      update_backstage_passes(item)
    when "Sulfuras, Hand of Ragnaros"
      # Не нужно обновлять качество
    when "Conjured"
      update_conjured(item)
    else
      update_normal_item(item)
    end

    update_sell_in(item)
    ensure_quality_bounds(item)
  end

  def update_aged_brie(item)
    item.quality = [item.quality + (item.sell_in > 0 ? 1 : 2), 50].min
  end

  def update_backstage_passes(item)
    if item.sell_in > 0
      item.quality = [item.quality + (item.sell_in > 10 ? 1 : (item.sell_in > 5 ? 2 : 3)), 50].min
    else
      item.quality = 0
      puts "Информация: Качество товара '#{item.name}' стало 0"
    end
  end

  def update_conjured(item)
    item.quality = [item.quality - 2, 0].max
    puts "Ошибка: Отрицательное качество для товара '#{item.name}'" if item.quality.negative?
  end

  def update_normal_item(item)
    item.quality = [item.quality - (item.sell_in > 0 ? 1 : 2), 0].max
    puts "Ошибка: Отрицательное качество для товара '#{item.name}'" if item.quality.negative?
  end

  def update_sell_in(item)
    item.days_expired += 1 if item.sell_in.zero?
    item.sell_in -= 1 if !(item.name == "Sulfuras, Hand of Ragnaros") && !(item.sell_in.zero?)
  end

  def ensure_quality_bounds(item)
    # [0, 50] за исключением легендарного товара
    item.quality = [item.quality, 0].max
    item.quality = [item.quality, 50].min unless item.name == "Sulfuras, Hand of Ragnaros"
    # > 50
    puts "Ошибка: Превышено максимальное качество для товара '#{item.name}'" if item.quality > 50 && item.name != "Sulfuras, Hand of Ragnaros"
  end

  def check_expired_items
    expired_items = @items.select { |item| item.sell_in < 0 }
    expired_items.each do |item|
      days_expired = item.sell_in.abs
      puts "Информация: Товар '#{item.name}' просрочен на #{days_expired} дней"
    end
  end
end
