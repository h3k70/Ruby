class Train
  attr_reader :speed, :wagons_count, :type

  def initialize(num, type, wagons_count)
    @num = num
    @type = type
    @wagons_count = wagons_count
    @speed = 0
  end

  def raise_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def hook_wagon
    @wagons_count += 1 if speed == 0
  end

  def unhook_wagon
    @wagons_count -= 1 if speed == 0 && @wagons_count > 0
  end

  def set_route(route)
    @route = route
    @current_station = 0
    @route.stations[@current_station].add_train(self)
  end

  def next_station
    @route.stations[@current_station + 1]
  end

  def move_forward
    if next_station
      current_station.send_train(self)
      @current_station += 1
      current_station.add_train(self)
    end
  end

  def previous_station
    @route.stations[@current_station - 1] if @current_station > 0
  end

  def move_backward
    if previous_station
      current_station.send_train(self)
      @current_station -= 1
      current_station.add_train(self)
    end
  end

  def current_station
    @route.stations[@current_station]
  end
end

