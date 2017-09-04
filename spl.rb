#encode

class Jamo_split 
  attr_reader :chosung, :joongsung, :jongsung

  def initialize(input)
    @letter = input
    @unpacked = input.unpack("U*")
  end

  def split 
    syllable_start = 44032

    chosung_start = 4352
    joongsung_start = 4449
    jongsung_start = 4520


    @chosung_code = ((@unpacked[0]-syllable_start)/28)/21 + chosung_start

    @joongsung_code = (@unpacked[0]-syllable_start/28)%21 + joongsung_start

    @jongsung_code = (@unpacked[0]-syllable_start/28)%28 + jongsung_start

    @chosung = [@chosung_code]
    @joongsung = [@joongsung_code]
    @jongsung = [@jongsung_code]
    
  end

  def repack
    @chosung = @chosung.pack("U*") 
    @joongsung = @joongsung.pack("U*")
    @jongsung = @jongsung.pack("U*")
  end
end




test = Jamo_split.new('대') 
test.split

test.repack

p test.chosung
p test.joongsung
p test.jongsung
