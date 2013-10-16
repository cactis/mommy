# encoding: utf-8

describe 'Room' do
  dataSource = 'http://data.taipei.gov.tw/opendata/apply/json/QTEyQjE2MjctNzE3RS00NjI5LUFEMkMtMDYyMTJDNUU0M0Qx'

  it 'load from source' do
    data = Room.load_data
    data.respond_to?(:each).should == true
    data.count.should == 426
  end

  it 'Room can new' do
    room = Room.new
    ap [room, 'room', __method__]
    room.is_a?(Room).should == true
  end

  it 'room can create by static data' do
    params = {
                "name" => "臺灣鐵路管理局臺北運務段南港站",
             "content" => "類別 : 哺集乳室  優良哺集乳室 效期至102年\n開放時間：同車站營業時間\n請洽剪收票口服務人員\n(02)2783-8645\n臺北市南港區南港路1段313號B2",
            "poi_addr" => "台北市南港路一段313號",
        "traffic_info" => nil,
                   "X" => nil,
                 "tel" => "(02)2783-8645",
        "display_addr" => "臺北市南港區南港路1段313號B2",
                   "Y" => nil
    }
    room = Room.create(params)
    Room.count.should == 1
    room.name.should == params["name"]
  end

  # it 'room can create by Room.load_data' do
  #   params = Room.load_data.first
  #   room = Room.create(params)
  #   Room.count.should == 1
  #   room.name.should == params["name"]
  # end
end
