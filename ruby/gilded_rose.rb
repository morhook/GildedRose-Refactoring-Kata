class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      item.decrement_quality unless item.aged_brie? || item.sulferas? || item.backstage_pass?
      item.increment_quality if item.aged_brie? || item.backstage_pass?
      item.sell_in -= 1 unless item.sulferas?

      #   if !item.aged_brie? && !item.backstage_pass?
      #     if item.quality > 0
      #       if !item.sulferas?
      #         item.decrement_quality
      #       end
      #     end
      #   else
      #     if item.quality < 50
      #       item.increment_quality

      #       if item.backstage_pass?
      #         if item.sell_in < 11 && item.quality < 50
      #           item.increment_quality
      #         end

      #         if item.sell_in < 6 && item.quality < 50
      #           item.increment_quality
      #         end
      #       end
      #     end
      #   end


      #   if !item.sulferas?
      #     item.sell_in = item.sell_in - 1
      #   end


      #   if item.sell_in < 0
      #     if !item.aged_brie?
      #       if !item.backstage_pass?
      #         if item.quality > 0 && !item.sulferas?
      #           item.decrement_quality
      #         end
      #       else
      #         item.zero_quality
      #       end
      #     else
      #       if item.quality < 50
      #         item.increment_quality
      #       end
      #     end
      # end
    end
  end
end

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

  def increment_quality
    @quality += 1
  end

  def decrement_quality
    @quality -= 1
  end

  def zero_quality
    @quality = 0
  end

  def aged_brie?
    name == "Aged Brie"
  end

  def backstage_pass?
    name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def sulferas?
    name == "Sulfuras, Hand of Ragnaros"
  end

  def update_quality
  end
end