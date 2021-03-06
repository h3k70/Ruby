class Train
  attr_reader :speed, :current_station, :number,
    :type, :route, :wagons

  def initialize(number, type)
    @number = number
    @speed = 0
    @type = type
    @wagons = []
  end

  def raise_speed(change_speed)
    @speed += change_speed
  end

  def stop
    @speed = 0
  end

  def hook_wagon(wagon)
    @wagons << wagon if attachable_wagon?(wagon)
  end

  def unhook_wagon(wagon)
    @wagons.delete(wagon) if attachable_wagon?(wagon)
  end

  def set_route(route)
    @route = route
    @current_station = 0
    @route.stations[@current_station].add_train(self)
  end

  def move_forward
    if next_station
      current_station.send_train(self)
      @current_station += 1
      current_station.add_train(self)
    end
  end

  def move_backwards
    if previous_station
      current_station.send_train(self)
      @current_station -= 1
      current_station.add_train(self)
    end
  end

  def previous_station
    @route.stations[@current_station - 1] if @current_station > 0
  end

  def next_station
    @route.stations[@current_station + 1]
  end

  def current_station
    @route.stations[@current_station]
  end

  def have_wagons?
    self.wagons.size > 0
  end
end
