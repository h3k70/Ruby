require_relative 'manufacturer.rb'

class Wagon
  include Manufacturer

  NOT_ENOUGH_SPACE = 'не хватает места'.freeze

  attr_reader :occupied_volume

  def initialize(volume)
    @total_volume = volume
    @occupied_volume = 0
  end

  def free_volume
    @total_volume - @occupied_volume
  end

  def take_volume(take_volume)
    raise NOT_ENOUGH_SPACE if take_volume > free_volume

    @occupied_volume += take_volume
  end
end
