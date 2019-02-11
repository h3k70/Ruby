class PassengerTrain < Train
  def initialize(number)
    super(number, 2)
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end

  def to_s
    "Поезд № #{self.number}. Пассажирский поезд с количеством вагонов = #{self.wagons.size}"
  end
end
