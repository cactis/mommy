# encoding: utf-8

# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = '哺集乳室'
  # app.device_family = [:ipad, :iphone]
  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :portrait_upside_down, :landscape_left, :landscape_right]
  app.frameworks += %w(CoreLocation MapKit QuartzCore AVFoundation CoreGraphics StoreKit)

  app.icons = ['BreastfeedingRoomHelper.png']
  # app.env['api'] = 'http://data.taipei.gov.tw/opendata/apply/json/QTEyQjE2MjctNzE3RS00NjI5LUFEMkMtMDYyMTJDNUU0M0Qx'
  app.env['api'] = 'http://mommy-api.airfont.com/'
  app.env['data_file'] = 'rooms.dat'
  app.env['name'] = '台北市哺集乳室查詢助手'
  app.env['name'] = '查詢助手'
  app.env['background_color'] = 'ffffff'
end
