# encoding: utf-8

class RoomsScreen < PM::TableScreen
  # title "#{ENV['name']}"
  searchable placeholder: '依名稱、地址尋找'
  # indexable

  attr_accessor :container



  # tab_bar_item icon: "home-screen-tab", title: "Home"
  def on_load
    ap [self.class.name, __method__]
    # load_data
    # ap [ENV['name'], "ENV['name']", __method__]
    # ap [ENV['this'], "ENV['this']", __method__]
    # set_attributes self.view, {
    #   background_color: hex_color("DBDBDB")
    # }
  end

  def will_appear
    ap [self.class.name, __method__]
    load_data
    update_table_data
  end

  def table_data
    @table_data ||= []
  end

  def load_data
    @rooms = Room.all
    load_rooms @rooms
    # @rooms ||= begin
    #   ap ['load rooms data...', __method__]
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
    @rooms = rooms
    # ap [@rooms.count, '@rooms.count', __method__]
    ap [@rooms.first, '@rooms.first', __method__]
    # ap ['load @rooms to table begin...', __method__]

    button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap{|b| b.titleLabel.text = "詳細" }

    cells = @rooms.map{|room|
      {
        id: room.id,
        # cell_style: UITableViewCellStyleSubtitle,
        title: room.name,
        # subtitle: room.display_addr,
        search_text: room.content,
        action: :tapped_room,
        arguments: { id: room.id },
        # type: :check,
        # selection_style: UITableViewCellSelectionStyleGray
        accessory: {
          # view: :switch, # UIView or :switch
          view: button,
          # value: true, # whether it's "checked" or not
          # action: :accessory_switched,
          # arguments: { some_arg: true } # :value is passed in if a hash
        }
      }
    }
    ap [cells.first, 'cells.first']
    @table_data = [{
      # title: 'Group Title',
      cells: cells
      }]
    update_table_data
  end

  # def accessory_switched(arguments = {})
  #   ap [arguments, 'arguments', __method__]
  # end

  # def tapped_cell(arguments={})
  #   ap [arguments, 'arguments', __method__]
  #   open RoomScreen.new(nav_bar: true, id: arguments[:id])
  # end

  def tapped_room(arguments = {})
    container.tapped_room arguments
  end
end
