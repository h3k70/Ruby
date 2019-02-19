class PassengerWagon < Wagon


  def initialize(seats)
    super
    @free_volume = seats.to_i
  end

  def take_volume(volume = 1)
    super
  end

  def to_s
    "Пассажирский вагон, свободных мест: #{@free_volume}, занятых мест: #{@occupied_volume}"
  end
end
