class PassengerWagon < Wagon

  attr_reader :free_seats, :occupied_steats

  def initialize(seats)
    @free_seats = seats.to_i
    @occupied_steats = 0
  end

  def take_seats
    if @free_seats > 0
      @free_seats -= 1
      @occupied_steats += 1
    end
  end

  def to_s
    "Пассажирский вагон, свободных мест: #{@free_seats}, занятых мест: #{@occupied_steats}"
  end
end
