class CargoWagon < Wagon

  attr_reader :free_volume, :occupied_volume

  def initialize(volume)
    @free_volume = volume.to_f
    @occupied_volume = 0
  end

  def take_volume(take_volume)
    if take_volume <= free_volume
      @free_volume -= take_volume
      @occupied_volume += take_volume
    end
  end


  def to_s
    "Грузовой вагон, свободный объем: #{@free_volume}, занятый объем: #{occupied_volume}"
  end
end
