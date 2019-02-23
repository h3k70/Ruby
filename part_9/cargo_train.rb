class CargoTrain < Train
  def initialize(number)
    super(number, 1)
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(CargoWagon)
  end

  def to_s
    "Поезд № #{number}. Грузовой поезд с количеством вагонов = #{wagons.size}"
  end
end
