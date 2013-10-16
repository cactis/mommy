class DataParser
  def self.parse(url)
    error_ptr = Pointer.new(:object)
    data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(url), options:NSDataReadingUncached, error:error_ptr)
    # ap [data, 'data', __method__]
    unless data
      raise error_ptr[0]
    end
    data
  end
end

