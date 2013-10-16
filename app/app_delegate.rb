class AppDelegate < PM::Delegate
  include PM::Styling

  def on_load(app, options)
    # Teacup::Appearance.apply

    # set_appearance_defaults

    # Room.load_data

    @home = HomeScreen.new(nav_bar: true)
    # # open RoomsScreen.new(nav_bar: true)
    # @room = RoomsScreen.new(nav_bar: true)
    # @map = MapScreen.new(nav_bar: true)
    @about = AboutScreen.new(nav_bar: true, external_links: :safari)
    open_tab_bar @home, @about
    # # open_tab_bar @map, @about
    # # open MapScreen.new
    # ENV['this'] = 'that'



  end

  # def will_appear
  # end

  # def set_appearance_defaults
  #   UINavigationBar.appearance.tintColor = hex_color("61B637")
  # end
end
