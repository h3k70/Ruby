class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    @start_station = start_station
    @end_station = end_station
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return if [@start_station, @end_station].include?(station)
    @stations.delete(station)
  end

  def stations_list
    @stations.each { |station| puts station.name }
  end
end
