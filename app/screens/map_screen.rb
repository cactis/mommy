class MapScreen < PM::MapScreen
  # # title "附近的#{ENV['name']}"
  # # start_position latitude: 25.0411189, longitude: 121.5733669, radius: 4
  # latitude = 25.053216
  # longitude = 121.6070578

  def stop_auto_locate
    BW::Location.stop if BW::Location
  end

  def auto_locate
    # auto_location = true
    BW::Location.get { |location|
      BW::Location.stop
      # ap [location, 'location', __method__]
      latitude = location[:to].latitude
      longitude = location[:to].longitude
      position = {latitude: latitude, longitude: longitude, radius: 0.01}
      ap [position, 'position', __method__]
      # self.class.start_position position
      marker = {
        coordinate: {
          latitude: latitude,
          longitude: longitude
        },
        span: [0.0001, 0.0001]
      }
      set_region region(marker)
    }
  end

  def on_load
    # load_data
  end

  def will_appear
    # current_location
    load_data
    # set_current
    # go_to 0, [0.3, 0.3], false
  end

  def go_to(index, span = [0.00005, 0.00005], notate = true)
    # stop_auto_locate
    # ap [room, 'room', __method__]
    annotation = annotations[index]
    ap [annotation, 'annotation', __method__]
    params = annotation.annotation_params
    marker = {
      coordinate: {
        latitude: params[:latitude],
        longitude: params[:longitude]
      },
      span: span
    }
    set_region region(marker)
    # annotations[index].annotation_params[:pin_color] = MKPinAnnotationColorGreen
    select_annotation annotation if notate
  end

  def go_to_rigion(room)
    my_region = region({
      coordinate: {
        latitude: room.X,
        longitude: room.Y
      },
      span: [0.00005, 0.00005]
    })
    set_region my_region
  end

  def load_data
    @rooms = Room.all
    load_rooms @rooms
    # @rooms ||= begin
    #   Dispatch::Queue.concurrent.async do
    #     begin
    #       results = Room.load_data
    #     rescue RuntimeError => e
    #       presentError e.message
    #     end
    #     Dispatch::Queue.main.sync {load_rooms(results)}
    #   end
    # end
  end

  def load_rooms(rooms)
    ap [rooms.count, 'rooms.count', __method__]
    @rooms = rooms


    @annotation_data = @rooms.map{ |room|
      latitude, longitude = address_to_coordination(room)
      # ap [[latitude, longitude], '[latitude, longitude]', __method__]
      {
        latitude: latitude,
        longitude: longitude,
        title: room.name,
        subtitle: room.display_addr,
        action: :tapped,
        arguments: {id: room.id}
      }
    }
    ap [@annotation_data.count, '@annotation_data.count', __method__]
    update_annotation_data
  end

  def address_to_coordination(room)
    # my_region = look_up_address address: address do |points, error|
    #   MKCoordinateRegionMakeWithDistance(points.first.region.center, points.first.region.radius, points.first.region.radius)
    #   # set_region my_region, true
    # end
    # ap [my_region, 'my_region', __method__]
    # return my_region.center.latitude, my_region.center.longitude
    return room.X, room.Y
  end

  def tapped(arguments = {})
    ap [arguments, 'arguments', __method__]
  end


  def self.current_location

  end

  def annotation_data
    @annotation_data ||= []
    # [{
    #   longitude: 25.0411189,
    #   latitude: 121.5733669,
    #   title: "Rainbow Falls",
    #   subtitle: "Nantahala National Forest"
    # }]
  end

  # def zoom_to_marker(marker)
  #   set_region region(coordinate: marker[:coordinate], span: marker[:span])
  #   select_annotation marker
  #   # set_region marker, true
  #   # select_annotation marker.coordinate

  #   # set_region region(coordinate: marker.coordinate, span: [0.05, 0.05])
  #   # select_annotation marker
  # end


end
