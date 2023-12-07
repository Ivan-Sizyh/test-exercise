require 'minitest/autorun'
require File.join(File.dirname(__FILE__), 'gilded_rose')
require File.join(File.dirname(__FILE__), 'item')

class TestGildedRose < Minitest::Test

  def test_update_quality_after_5_days
    initial_item = Item.new("foo", 5, 10)

    items = [initial_item]

    5.times { GildedRose.new(items).update_quality }

    expected_item = Item.new("foo", 0, 5)

    assert_equal expected_item.name, items[0].name
    assert_equal expected_item.sell_in, items[0].sell_in
    assert_equal expected_item.quality, items[0].quality
  end
end
