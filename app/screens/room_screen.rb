# encoding: utf-8

class RoomScreen < PM::FormotionScreen
  title "詳細資訊"
  attr_accessor :id

  def table_data
    ap [id, 'id', __method__]
    room = Room.find(id)
    {
      sections: [{
        title: room.name,
        rows: [
          {
            title: room.content,
            type: :string
          }, {
            title: room.display_addr,
            type: :string
          }
        ]
      }]
    }
  end
end
