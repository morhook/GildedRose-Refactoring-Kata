require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  let(:gilded_rose) { GildedRose.new(items) }
  let(:items) do
    [
      Item.new('+5 Dexterity Vest', 10, 20),
      Item.new('Aged Brie', 2, 0),
      Item.new('Elixir of the Mongoose', 5,  7),
      Item.new('Sulfuras, Hand of Ragnaros', 0,  80),
      Item.new('Sulfuras, Hand of Ragnaros', -1, 80),
      Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20),
      Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 49),
      Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 49)
    ]
  end

  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    context 'with a number of days' do
      subject(:update_quality) { days.times { gilded_rose.update_quality } }

      context 'when 0 day' do
        let(:days) { 0 }

        let(:expected_strings) do
          [['+5 Dexterity Vest', 10, 20],
           ['Aged Brie', 2, 0],
           ['Elixir of the Mongoose', 5, 7],
           ['Sulfuras, Hand of Ragnaros', 0, 80],
           ['Sulfuras, Hand of Ragnaros', -1, 80],
           ['Backstage passes to a TAFKAL80ETC concert', 15, 20],
           ['Backstage passes to a TAFKAL80ETC concert', 10, 49],
           ['Backstage passes to a TAFKAL80ETC concert', 5, 49],
           ['Conjured Mana Cake', 3, 6]]
        end
        it 'works' do
          days.times { update_quality }
          check_items(items, expected_strings)
        end
      end

      context 'when 1 days' do
        let(:days) { 1 }
        let(:expected_strings) do
          [['+5 Dexterity Vest', 9, 19], ['Aged Brie', 1, 1], ['Elixir of the Mongoose', 4, 6], ['Sulfuras, Hand of Ragnaros', 0, 80], ['Sulfuras, Hand of Ragnaros', -1, 80], ['Backstage passes to a TAFKAL80ETC concert', 14, 21], ['Backstage passes to a TAFKAL80ETC concert', 9, 50], ['Backstage passes to a TAFKAL80ETC concert', 4, 50], ['Conjured Mana Cake', 2, 5]]
        end

        it 'works' do
          days.times { update_quality }
          check_items(items, expected_strings)
        end
      end

      context 'when 2 days' do
        let(:days) { 2 }
        let(:expected_strings) do
          [['+5 Dexterity Vest', 8, 18], ['Aged Brie', 0, 2], ['Elixir of the Mongoose', 3, 5], ['Sulfuras, Hand of Ragnaros', 0, 80], ['Sulfuras, Hand of Ragnaros', -1, 80], ['Backstage passes to a TAFKAL80ETC concert', 13, 22], ['Backstage passes to a TAFKAL80ETC concert', 8, 50], ['Backstage passes to a TAFKAL80ETC concert', 3, 50], ['Conjured Mana Cake', 1, 4]]
        end

        it 'works' do
          days.times { update_quality }
          check_items(items, expected_strings)
        end
      end

      context 'when 3 days' do
        let(:days) { 3 }
        let(:expected_strings) do
          [['+5 Dexterity Vest', 7, 17], ['Aged Brie', -1, 4], ['Elixir of the Mongoose', 2, 4], ['Sulfuras, Hand of Ragnaros', 0, 80], ['Sulfuras, Hand of Ragnaros', -1, 80], ['Backstage passes to a TAFKAL80ETC concert', 12, 23], ['Backstage passes to a TAFKAL80ETC concert', 7, 50], ['Backstage passes to a TAFKAL80ETC concert', 2, 50], ['Conjured Mana Cake', 0, 3]]
        end

        it 'works' do
          days.times { update_quality }
          check_items(items, expected_strings)
        end
      end

      context 'when 10 days' do
        let(:days) { 10 }
        let(:expected_strings) do
          [['+5 Dexterity Vest', 0, 10], ['Aged Brie', -8, 18], ['Elixir of the Mongoose', -5, 0], ['Sulfuras, Hand of Ragnaros', 0, 80], ['Sulfuras, Hand of Ragnaros', -1, 80], ['Backstage passes to a TAFKAL80ETC concert', 5, 35], ['Backstage passes to a TAFKAL80ETC concert', 0, 50], ['Backstage passes to a TAFKAL80ETC concert', -5, 0], ['Conjured Mana Cake', -7, 0]]
        end

        it 'works' do
          days.times { update_quality }
          check_items(items, expected_strings)
        end
      end

      context 'when 30 days' do
        let(:days) { 30 }
        let(:expected_strings) do
          [['+5 Dexterity Vest', -20, 0], ['Aged Brie', -28, 50], ['Elixir of the Mongoose', -25, 0], ['Sulfuras, Hand of Ragnaros', 0, 80], ['Sulfuras, Hand of Ragnaros', -1, 80], ['Backstage passes to a TAFKAL80ETC concert', -15, 0], ['Backstage passes to a TAFKAL80ETC concert', -20, 0], ['Backstage passes to a TAFKAL80ETC concert', -25, 0], ['Conjured Mana Cake', -27, 0]]
        end

        it 'works' do
          days.times { update_quality }
          check_items(items, expected_strings)
        end
      end
    end
  end
end

def check_items(items, expected_strings)
  # ex. [ [item, 'expected'],
  #       [item, 'expected'] ]
  items_strings = items.zip(expected_strings.map { |string| string.join(', ') })

  items_strings.each do |(item, expected_string)|
    expect(item.to_s).to eq expected_string
  end
end
