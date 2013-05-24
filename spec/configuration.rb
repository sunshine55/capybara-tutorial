#http://mjijackson.com/2010/02/flexible-ruby-config-objects
require 'yaml'

class Configuration

  def self.load_from_file path
   Configuration.new(YAML.load_file(path))
  end

  def initialize(data={})
    @data = {}
    update!(data)
  end

  def update!(data)
    data.each do |key, value|
      self[key] = value
    end
  end

  def [](key)
    @data[key.to_sym]
  end

  def []=(key, value)
    if value.class == Hash
      @data[key.to_sym] = Configuration.new(value)
    else
      @data[key.to_sym] = value
    end
  end

  def to_s
    @data.to_s
  end

  def method_missing(sym, *args)
    if sym.to_s =~ /(.+)=$/
      self[$1] = args.first
    else
      self[sym]
    end
  end
end