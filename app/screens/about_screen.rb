# encoding: utf-8

class AboutScreen < PM::WebScreen
  title '關於'

  def on_load
    set_attributes self.view, {
      background_color: hex_color(ENV['background_color'])
    }
  end

  def content
    'about.html'
  end

  def will_appear
    set_initial_content
  end
end
