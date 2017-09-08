
class Jamo_split 
  attr_reader :chosung, :joongsung, :jongsung

  def initialize(input)
    @letter = input
    @unpacked = input.unpack("U*")

    @syllable_start = 0xAC00
    @hangul_index = @unpacked[0]-@syllable_start 
  end


  def get_chosung

    chosung_start = 0x1100 
    @chosung_code = (@hangul_index/28/21) #+chosung_start

    @chosung = [@chosung_code]

  end
  
  def get_joongsung

    joongsung_start = 0x1161 
    @joongsung_code = ((@hangul_index-@jongsung_code)/28)%21

    @joongsung = [@joongsung_code]

  end

  def get_jongsung

    jongsung_start = 0x11A8 
    @jongsung_code = (@hangul_index%28) #+jongsung_start
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

  def show_split
    puts [@chosung, @joongsung, @jongsung]
  end
end




test = Jamo_split.new('때') 
test.get_chosung
test.get_jongsung
test.get_joongsung
test.repack

test.show_index


