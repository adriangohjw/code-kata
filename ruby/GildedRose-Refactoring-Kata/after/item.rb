class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class ItemWrapper
  attr_accessor :item

  def initialize(item)
    @item = item
  end
end

class NormalItem < ItemWrapper
  def update_sell_in
    @item.sell_in -= 1 unless @item.sell_in.zero?
  end

  def update_quality
    @item.quality -= @item.sell_in.zero? ? 2 : 1
    quality_floor_at_zero
  end

  private

  def quality_floor_at_zero
    @item.quality = 0 if @item.quality.negative?
  end
end

class AgedBrie < ItemWrapper
  def update_sell_in
    @item.sell_in -= 1 unless @item.sell_in.zero?
  end

  def update_quality
    @item.quality += 1
    quality_ceiling_at_50
  end

  private

  def quality_ceiling_at_50
    @item.quality = 50 if @item.quality > 50
  end
end

class Sulfuras < ItemWrapper
  def update_sell_in; end

  def update_quality; end
end

class BackstagePasses < ItemWrapper
  def update_sell_in
    @item.sell_in -= 1 unless @item.sell_in.zero?
  end

  def update_quality
    case @item.sell_in
    when 0
      @item.quality = 0
    when 1..5
      @item.quality += 3
    when 6..10
      @item.quality += 2
    else
      @item.quality += 1
    end

    quality_ceiling_at_50
  end

  private

  def quality_ceiling_at_50
    @item.quality = 50 if @item.quality > 50
  end
end

class Conjured < ItemWrapper
  def update_sell_in
    @item.sell_in -= 1 unless @item.sell_in.zero?
  end

  def update_quality
    @item.quality -= @item.sell_in.zero? ? 4 : 2
    quality_floor_at_zero
  end

  private

  def quality_floor_at_zero
    @item.quality = 0 if @item.quality.negative?
  end
end
