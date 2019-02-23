class PassengerWagon < Wagon
  def take_volume(_volume = 1)
    super(1)
  end

  def to_s
    "Пассажирский вагон, свободных мест: #{free_volume}, занятых мест: #{@occupied_volume}"
  end
end
