require_relative 'gilded_rose'
require_relative 'item'

items = [
  Item.new("Aged Brie", 10, -20),
  Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
  Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
  Item.new("Conjured", 5, 10),
  Item.new("Normal Item", 3, 7)
]

gilded_rose = GildedRose.new(items)

gilded_rose.run_continuously
