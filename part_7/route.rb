require_relative 'instance_counter.rb'

class Route

  include InstanceCounter

  NOT_VALID_OBJECT = "Начальная и/или конечная станция не является объектом класса 'Station'"
  STATIONS_ERROR = "Начальная и конечная станции одинаковы"

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    #register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def show_stations(stations)
    @stations.each { |station| puts station.name }
  end

  def to_s
    new_stations = @stations.map { |station| station.name }
    new_stations.delete_at(0)
    new_stations.delete_at(-1)
    [@stations.first.name, new_stations, @stations.last.name].join(' > ')
  end

  def valid?
    validate!
    return true
  rescue
    return false
  end

  private
    def validate!
      raise NOT_VALID_OBJECT unless @stations.first.is_a?(Station) || @stations.last.is_a?(Station)
      raise STATIONS_ERROR if @stations.first == stations.last
    end
end
