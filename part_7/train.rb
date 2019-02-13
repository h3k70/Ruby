require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'

class Train

  include Manufacturer
  include InstanceCounter

  @@all_trains = {}

  NOT_VALID_NUM = "Недопустимый номер"
  NUM_FORMAT = /^[a-zа-я\d]{3}(-(\d{2}|[a-zа-я]{2}))?$/i

  def self.find(number)
    @@all_trains[number]
  end

  attr_reader :speed, :current_station, :number,
    :type, :route, :wagons

  def initialize(number, type)
    @number = number.to_s
    @speed = 0
    @type = type
    @wagons = []
    @@all_trains[number] = self
    valid!
    #register_instance
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

  def valid?
    valid!
    return true
    rescue
    return false
  end

  protected

  def valid!
    raise NOT_VALID_NUM if @number.nil? || @number !~ NUM_FORMAT
  end
end


