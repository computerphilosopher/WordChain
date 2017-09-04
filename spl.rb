#encode

class Jamo_split 
  attr_reader :chosung, :joongsung, :jongsung

  def initialize(input)
    @letter = input
    @unpacked = input.unpack("U*")
  end

  def split 
    syllable_start = 0xAC00

    chosung_start = 0x1100 
    joongsung_start = 0x1161 
    jongsung_start = 0x11A8 


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

  def show_index
    puts @chosung_code
    puts @joongsung_code
    puts @jongsung_code
  end
end




test = Jamo_split.new('대') 
test.split

test.repack

test.show_index

puts [test.chosung, test.joongsung, test.jongsung]


