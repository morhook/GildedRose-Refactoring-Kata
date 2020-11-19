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
    self.quality += 1 if quality < 50
  end

  def decrement_quality
    self.quality -= 1 if quality > 0
  end

  def decrement_sell_in
    self.sell_in -= 1
  end

  def expire
    self.quality = 0
  end

  def expired?
    sell_in < 0
  end

  private

  attr_writer :name, :sell_in, :quality
end

# Handler
class Handler
  attr_reader :item

  def initialize(item)
    @item = item
  end

  # Aged Brie
  class AgedBrie < Handler
    def call
      item.increment_quality
      item.decrement_sell_in
      item.increment_quality if item.sell_in < 0
    end
  end

  # Tickets
  class Tickets < Handler
    def call
      item.increment_quality
      item.increment_quality if item.sell_in < 11
      item.decrement_sell_in
      item.expire if item.expired?
    end
  end

  # Sulferas
  class Sulfuras < Handler
    def call
      item.increment_quality
    end
  end

  # Default
  class Default < Handler
    def call
      item.decrement_quality
      item.decrement_sell_in
      item.decrement_quality if item.expired?
    end
  end
end

# Item Handler
class ItemHandler
  HANDLER_MAP = {
    'Aged Brie' => ::Handler::AgedBrie,
    'Backstage passes to a TAFKAL80ETC concert' => ::Handler::Tickets,
    'Sulfuras, Hand of Ragnaros' => ::Handler::Sulfuras
  }.freeze

  def self.classify(item)
    handler = HANDLER_MAP[item.name] || ::Handler::Default
    handler.new(item)
  end
end
