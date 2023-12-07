class Item
  attr_accessor :name, :sell_in, :quality, :days_expired

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in < 0 ? 0 : sell_in
    @quality = quality
    @days_expired = [0, -sell_in].max
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}, #{@days_expired} дней просрочено"
  end
end

