class Railway
  SELECT_TRAIN = 'Выберите порядковый номер поезда из списка'.freeze
  SELECT_WAGON = 'Выберите порядковый номер вагона из списка'.freeze
  SELECT_ROUTE = 'Выберите порядковый номер маршрута из списка'.freeze
  SELECT_STATION = 'Выберите порядковый номер станции из списка'.freeze
  SELECT_TYPE = 'Укажите тип (1 - cargo / 2 - passenger)'.freeze
  WAGON_ON = 'Вагон прицеплен!'.freeze
  WAGON_OFF = 'Вагон НЕ прицеплен. Разные типы поезда и вагона'.freeze
  TRAIN_CURRENT_STATION = 'Поезд прибыл на станцию '.freeze
  TRAIN_END_STATION = 'Поезд на конечной станции'.freeze
  TRAIN_EMPTY = 'У этого поезда нет вагонов'.freeze
  STATION_EMPTY = 'На этой станции нет поездов'.freeze
  EXCEPTION_SAME_STATIONS = 'Конечная и начальная станции одинаковы!'.freeze
  NOT_ENOUGH_STATIONS = 'Недостаточно станций!'.freeze
  NOT_ENOUGH_ROUTES = 'Нужно создать путь!'.freeze
  NOT_ENOUGH_TRAINS = 'Нужно создать поезд!'.freeze
  NOT_ENOUGH_WAGONS = 'Нужно создать вагон!'.freeze
  NOT_ENOUGH_WAGONS_TO_TRAIN = 'У поезда нет прицепленных вагонов!'.freeze
  SET_TRAIN_NUMBER = 'Введите номер поезда'.freeze
  SET_STATION_NAME = 'Введите название станции'.freeze
  SET_FREE_VOLUME = 'Введите кол-во свободного объема'.freeze
  SET_FREE_SEATS = 'Введите кол-во свободных мест'.freeze
  SET_OCCUPIED_VOLUME = 'Сколько места занять?'.freeze
  SET_STATION_NUMBER = [
    'Введите порядковый номер начальной станции из списка',
    'Введите порядковый номер конечной станции из списка'
  ].freeze

  NOT_VALID_NUM = 'Недопустимый номер'.freeze
  CREATED_TRAIN = 'Создан поезд: '.freeze
  NOT_VALID_CHOCIE = 'Недопустимый выбор'.freeze

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def create_station
    puts SET_STATION_NAME
    name = gets.chomp
    station = Station.new(name)
    @stations << station
  end

  def create_train
    puts SET_TRAIN_NUMBER
    number = gets.chomp

    puts SELECT_TYPE
    train_type = select_from_array([CargoTrain, PassengerTrain])
    @trains << train_type.new(number)
    puts CREATED_TRAIN + @trains.last.to_s
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_route
    return puts(NOT_ENOUGH_STATIONS) if @stations.size < 2

    puts SET_STATION_NUMBER[0]
    show_array(@stations, :name)
    ini_station = select_from_array(@stations)

    puts SET_STATION_NUMBER[1]
    end_station = select_from_array(@stations)

    until ini_station != end_station
      puts EXCEPTION_SAME_STATIONS
      end_station = select_from_array(@stations)
    end

    @routes << Route.new(ini_station, end_station)
  end

  def assign_route
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    train = select_train

    puts SELECT_ROUTE
    show_array(@routes, :to_s)
    route = select_from_array(@routes)

    train.set_route(route)
  end

  def add_station
    return puts(NOT_ENOUGH_STATIONS) if @stations.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    puts SELECT_STATION
    show_array(@stations, :name)
    station = select_from_array(@stations)

    puts SELECT_ROUTE
    show_array(@routes, :to_s)
    route = select_from_array(@routes)

    route.add_station(station)
  end

  def remove_station
    return puts(NOT_ENOUGH_STATIONS) if @stations.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?
    return puts(NOT_ENOUGH_STATIONS) if @stations.size < 3

    puts SELECT_ROUTE
    show_array(@routes, :to_s)
    route = select_from_array(@routes)

    puts SELECT_STATION
    show_array(route.stations, :name)
    station = select_from_array(route.stations)

    route.delete_station(station)
  end

  def create_wagon
    puts SELECT_TYPE
    wagon_type = select_from_array([CargoWagon, PassengerWagon])
    if wagon_type == PassengerWagon
      puts SET_FREE_SEATS
      volume = gets.to_i
    else
      puts SET_FREE_VOLUME
      volume = gets.to_f
    end
    @wagons << wagon_type.new(volume)
  end

  def hook_wagon
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_WAGONS) if @wagons.empty?

    train = select_train

    wagon = select_wagon

    if train.hook_wagon(wagon)
      @wagons.delete(wagon)
      puts WAGON_ON
    else
      puts WAGON_OFF
    end
  end

  def unhook_wagon
    train_with_wagons = @trains.select(&:wagons?)

    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_WAGONS_TO_TRAIN) if train_with_wagons.empty?

    train = select_train

    wagon = select_wagon

    unhooked_wagon = train.unhook_wagon(wagon)
    @wagons << unhooked_wagon unless unhooked_wagon.nil?
  end

  def train_forward
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    train = select_train

    if train.move_forward
      puts TRAIN_CURRENT_STATION + train.current_station.name
    else
      puts TRAIN_END_STATION
    end
  end

  def train_backwards
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    train = select_train

    if train.move_backwards
      puts TRAIN_CURRENT_STATION + train.current_station.name
    else
      puts TRAIN_END_STATION
    end
  end

  def stations_list
    return puts(NOT_ENOUGH_STATIONS) if @stations.empty?

    show_array(@stations, :name)
  end

  def trains_list
    return puts(NOT_ENOUGH_STATIONS) if @stations.empty?
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?

    puts SELECT_STATION
    show_array(@stations, :name)
    station = select_from_array(@stations)

    if station.trains.empty?
      puts STATION_EMPTY
    else
      station.each_trains { |train| puts train.to_s }
    end
  end

  def wagon_list
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?

    train = select_train

    if train.wagons.empty?
      puts TRAIN_EMPTY
    else
      train.each_wagons { |wagon| puts wagon.to_s }
    end
  end

  def wagon_stuff
    return puts(NOT_ENOUGH_WAGONS) if @wagons.empty?

    wagon = select_wagon

    if wagon.is_a?(PassengerWagon)
      wagon.take_volume
    else
      puts SET_OCCUPIED_VOLUME
      volume = gets.to_f
      wagon.take_volume(volume)
    end
  rescue StandardError => e
    puts e.message
    retry
  end

  private

  # Метод не используется в главном файле
  # private, а не protected, потому что у данного класса нет потомков
  def show_array(array, name_method = :name)
    array.each.with_index(1) do |item, index|
      puts "#{index}. #{item.send(name_method)}"
    end
  end

  def select_from_array(array)
    user_input = gets.to_i
    user_input = gets.to_i until user_input.between?(1, array.size)
    array[user_input - 1]
  end

  def select_train
    puts SELECT_TRAIN
    show_array(@trains, :to_s)
    select_from_array(@trains)
  end

  def select_wagon
    puts SELECT_WAGON
    show_array(@wagons, :to_s)
    select_from_array(@wagons)
  end
end
