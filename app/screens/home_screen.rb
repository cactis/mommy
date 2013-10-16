# encoding: utf-8

class HomeScreen < PM::Screen

  def on_load
    self.title = "#{ENV['name']}"
    @map = MapScreen.new
    @rooms = RoomsScreen.new(container: self)
    set_attributes self.view, {
      background_color: hex_color(ENV['background_color'])
    }

    set_nav_bar_button :right, title: '所在位置', action: :auto_locate
  end

  def auto_locate
    @map.auto_locate
  end

  def will_appear
    @view_setup ||= self.set_up_view
  end

  def on_rotate#(orientation, duration)
    set_up_view
  end

  def set_up_view
    add @map.view, {
      frame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height / 2)
    }
    add @rooms.view, {
      frame: CGRectMake(0, view.frame.size.height / 2, view.frame.size.width, view.frame.size.height / 2)
    }

    Dispatch::Queue.concurrent.async do
      begin
        Room.load_data
      rescue RuntimeError => e
        presentError e.message
      end
      Dispatch::Queue.main.sync {
        @rooms.will_appear
        @map.will_appear
      }
    end

    true
  end

  def tapped_room(args = {})
    ap [args, 'args', __method__]
    @map.go_to args[:id] - 1
    # room = Room.find(args[:id])
    # coordinate = {latitude:}
    # @map.go_to coordinate
  end
end
