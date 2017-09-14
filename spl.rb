
class Jamo_split 
  attr_reader :chosung, :jungsung, :jongsung

  def initialize(input)
    @letter = input
    @unpacked = input.unpack("U*")

    @syllable_start = 0xAC00
    @hangul_index = @unpacked[0]-@syllable_start 
  end


  def get_chosung

    chosung_start = 0x1100 
    @chosung_code = (@hangul_index/28/21)+chosung_start

    @chosung = [@chosung_code]

  end
  
  def get_jungsung

    jungsung_start = 0x1161 
    @jungsung_code = ((@hangul_index/28)%21)+jungsung_start

    @jungsung = [@jungsung_code]

  end

  def get_jongsung

    jongsung_start = 0x11A8 
    @jongsung_code = (@hangul_index%28)+jongsung_start-1
    @jongsung = [@jongsung_code]
  end


  def repack
    @chosung = @chosung.pack("U*") 
    @jungsung = @jungsung.pack("U*")
    @jongsung = @jongsung.pack("U*")
  end

  def show_index
    puts @chosung_code
    puts @jungsung_code
    puts @jongsung_code
  end

  def show_split
    puts [@chosung, @jungsung, @jongsung]
  end
end

j = Jamo_split.new('라')

j.get_chosung
j.get_jungsung
j.get_jongsung

j.show_index



