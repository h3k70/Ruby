class CargoWagon < Wagon


  def initialize(volume)
    super
    @free_volume = volume.to_f
  end

  def take_volume(volume)
    super
  end

  def to_s
    "Грузовой вагон, свободный объем: #{@free_volume}, занятый объем: #{occupied_volume}"
  end
end
