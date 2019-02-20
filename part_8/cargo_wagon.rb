class CargoWagon < Wagon

  def to_s
    "Грузовой вагон, свободный объем: #{free_volume}, занятый объем: #{occupied_volume}"
  end
end
