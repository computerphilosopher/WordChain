#encoding: euc-kr 

dic = ["â��", "������", "��絵"]
      
class Word
  def initialize(string)
    @string = string
    @candidate = Array.new
  end

  def last_letter
    return @string[-1,1]
  end
end

W1 = Word.new("������")

p W1.last_letter

