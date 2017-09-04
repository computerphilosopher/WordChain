#encode

class String

  def initialize(input)
    @letter = input
    @unicode = input.unpack("U*")[0]
  end

  def split 
    start_point = 44032
    @chosung = ((@unicode-start_point)/28)/21

    @joongsung = (@unicode-start_point/28)%21

    @jongsung = (@unicode-start_point/28)%28
    
    puts @chosung
    puts @joongsung
    puts @jongsung
  end

end




test = String.new('다') 
test.split

