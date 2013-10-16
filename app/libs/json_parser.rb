class JSONParser
  def self.parse_from_url(url)
    ap [url, 'url', __method__, self.name]
    data = DataParser.parse(url)
    error_ptr = Pointer.new(:object)
    json = NSJSONSerialization.JSONObjectWithData(data, options:0, error:error_ptr)
    # ap [json.first, 'json.first', __method__]
    unless json
      raise error_ptr[0]
    end
    json
  end
end
