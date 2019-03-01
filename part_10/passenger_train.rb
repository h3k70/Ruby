class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, VALUE_FORMAT

  def initialize(number)
    super(number, 2)
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end

  def to_s
    "Поезд № #{number}. Пассажирский поезд с количеством вагонов = #{wagons.size}"
  end
end
