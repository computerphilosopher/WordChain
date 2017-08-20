#encoding: euc-kr 

dic = ["창문", "문지기", "기사도"]
      
class Word
  def initialize(string)
    @string = string
    @candidate = Array.new
  end

  def last_letter
    return @string[-1,1]
  end
end

W1 = Word.new("도지사")

p W1.last_letter

