class TmpModel
  def method_missing(method, *args, &block)
    'hello world'
  end
end