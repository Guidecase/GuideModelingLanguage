class TitledText
  attr_reader :text, :title
  
  def initialize(*args)
    @text, @title = args.flatten
  end  
  
  def to_a
    [text, title].delete_if {|x| x.nil? }
  end
  
  def self.to_mongo(value)
    value.to_a
  end

  def self.from_mongo(value)
    value.is_a?(self) ? value : Outcome::TitledText.new(value)
  end  
end