class Config
  @@config = {}

  def self.set(config)
    @@config = config
  end

  def self.[](k)
    @@config[k]
  end

  def self.keys()
    @@config.keys
  end
end
