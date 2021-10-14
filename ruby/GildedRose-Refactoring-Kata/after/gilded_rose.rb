require File.join(File.dirname(__FILE__), 'item')

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      wrapper = ItemToWrapperConverter.new(item).call
      wrapper.update_sell_in
      wrapper.update_quality
    end
  end
end

class ItemToWrapperConverter
  def initialize(item)
    @item = item
  end

  def call
    case @item.name
    when 'Aged Brie'
      AgedBrie.new(@item)
    when 'Sulfuras, Hand of Ragnaros'
      Sulfuras.new(@item)
    when 'Backstage passes to a TAFKAL80ETC concert'
      BackstagePasses.new(@item)
    when 'Conjured Mana Cake'
      Conjured.new(@item)
    else
      NormalItem.new(@item)
    end
  end
end
