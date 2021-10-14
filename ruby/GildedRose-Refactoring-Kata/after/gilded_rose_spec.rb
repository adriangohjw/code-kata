require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    it 'decreases in sell_in' do
      items = [Item.new('foo', 1, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 0
    end

    it 'quality will not drop below 0' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it 'never increases in quality beyond 50' do
      items = [Item.new('Aged Brie', 1, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 50
    end

    describe 'Sulfuras, Hand of Ragnaros' do
      it 'does not change in quality' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 80
      end

      it 'does not change in sell_in' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 0
      end
    end

    describe 'Aged Brie' do
      it 'increases in quality the older it gets' do
        items = [Item.new('Aged Brie', 1, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 1
      end
    end

    describe 'Backstage passes to a TAFKAL80ETC concert' do
      it 'increases in quality by 2 when sell_in is 10 or less' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 2
      end

      it 'increases in quality by 3 when sell_in is 5 or less' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 3
      end

      it 'drops quality to 0 after the concert' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end
    end

    describe 'Conjured Mana Cake' do
      it 'decreases in quality twice as fast as normal items' do
        items = [
          Item.new('Conjured Mana Cake', 3, 6),
          Item.new('Conjured Mana Cake', 0, 6)
        ]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 4
        expect(items[1].quality).to eq 2
      end
    end

    describe 'others' do
      it 'decreases in quality by 1' do
        items = [Item.new('foo', 10, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 9
      end

      it 'decreases in quality by 2 when sell_in is 0' do
        items = [Item.new('foo', 0, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 8
      end
    end
  end
end
