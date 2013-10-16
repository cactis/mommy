class Room


  # ENV['api'] = 'http://data.taipei.gov.tw/opendata/apply/json/QTEyQjE2MjctNzE3RS00NjI5LUFEMkMtMDYyMTJDNUU0M0Qx'
  # ENV['data_file'] = 'rooms.dat'


  include MotionModel::Model
  include MotionModel::ArrayModelAdapter

  columns :name         => :string,
          :content      => :string,
          :poi_addr     => :string,
          :traffic_info => :string,
          :X            => :float,
          :Y            => :float,
          :tel          => :string,
          :display_addr => :string

  def self.load_data
    ap [ENV['api'], "ENV['api']", __method__]
    # json = get_location
    ap [Room.count, 'Room.count', __method__]
    if Room.count > 0
      results = Room.all
    elsif results = Room.deserialize_from_file(ENV['data_file'])
      ap [results.count, 'results.count', __method__]
    else
      results = JSONParser.parse_from_url(ENV['api'])
      ap [results.first, 'results.first', __method__]

      (0..results.count - 1).each do |index|
        # ap [data, 'data']
        data = results[index]
        # ap [json[index], 'json[index]']
        Room.create(
          :name => data['name'],
          :content => data['content'],
          :poi_addr => data['poi_addr'],
          :traffic_info => data['traffic_info'],
          :X => data['X'],
          :Y => data['Y'],
          :tel => data['tel'],
          :display_addr => data['display_addr']
        )
        # ap [Room.count, 'Room.count']
      end
      Room.serialize_to_file(ENV['data_file'])
      ap [Room.count, 'Room.count', __method__]
    end
    # ap [Room.all.map{|room| room.poi_addr}.join("\n"), 'Room.all.map{|room| room.poi_addr}']
    results = Room.order(:name).all
  end

  # def self.get_location
  #   url = 'http://127.0.0.1:1337/'
  #   JSONParser.parse_from_url(url)
  #   error_ptr = Pointer.new(:object)
  #   json = []
  #   file = 'rooms.json'.resource
  #   ap [file, 'file', __method__], raw: true
  #   File.open(file, 'r') do |f|
  #     json = NSJSONSerialization.JSONObjectWithData(f.read, options:0, error:error_ptr)
  #     ap [json, 'json', __method__], raw: true
  #   end
  #   json
  # end

  private
  def presentError(error)
    $stderr.puts error.description
  end
end
