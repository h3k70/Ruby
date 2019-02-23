require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'

class Train
  include Manufacturer
  include InstanceCounter

  NOT_VALID_NUM = 'Недопустимый номер поезда'.freeze
  NUM_FORMAT = /^[a-zа-яё\d]{3}-?[a-zа-яё\d]{2}$/i.freeze

  attr_reader :speed, :number, :type, :route, :wagons

  @@all_trains = {}

  def self.find(number)
    @@all_trains[number]
  end

  def initialize(number, type)
    @number = number.to_s
    @type = type
    validate!
    @speed = 0
    @wagons = []
    @@all_trains[number] = self
    # register_instance
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

  def wagons?
    !wagons.empty?
  end

  def each_wagons
    @wagons.each { |wagon| yield(wagon) }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise NOT_VALID_NUM if @number.nil? || @number !~ NUM_FORMAT
  end
end
