# Gilded Rose
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.map { |item| ItemHandler.classify(item).call }
  end
end

# Item
class Item
  attr_reader :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def increment_quality
    @quality += 1 if quality < 50
  end

  def decrement_quality
    @quality -= 1 if quality > 0
  end

  def decrement_sell_in
    @sell_in -= 1
  end

  def expire
    @quality = 0
  end

  def expired?
    sell_in < 0
  end
end

# Aged Brie
class AgedBrie < SimpleDelegator
  def call
    increment_quality
    decrement_sell_in
    increment_quality if sell_in < 0
  end
end

# Tickets
class Tickets < SimpleDelegator
  def call
    increment_quality
    increment_quality if sell_in < 11
    decrement_sell_in
    expire if expired?
  end
end

# Sulferas
class Sulfuras < SimpleDelegator
  def call
    increment_quality
  end
end

# Default
class Default < SimpleDelegator
  def call
    decrement_quality
    decrement_sell_in
    decrement_quality if expired?
  end
end

# Item Handler
class ItemHandler
  HANDLER_MAP = {
    'Aged Brie' => ::AgedBrie,
    'Backstage passes to a TAFKAL80ETC concert' => ::Tickets,
    'Sulfuras, Hand of Ragnaros' => ::Sulfuras
  }.freeze

  def self.classify(item)
    handler = HANDLER_MAP[item.name] || ::Default
    handler.new(item)
  end
end
