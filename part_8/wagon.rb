require_relative 'manufacturer.rb'

class Wagon
  include Manufacturer

  attr_reader :free_volume, :occupied_volume

  def initialize(volume)
    @free_volume = volume
    @occupied_volume = 0
  end

  def take_volume(take_volume)
    if take_volume <= free_volume
      @free_volume -= take_volume
      @occupied_volume += take_volume
    end
  end
end
