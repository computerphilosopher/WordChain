#encoding: utf-8

class Word
  def initialize(dic, string)
    
    @dic = dic
    @string = string
    @candidate = Array.new
  end

  def last_letter
    return @string[-1,1]
  end

  def in_dic?
    return @dic.include?(@string)
  end

  def make_candidate
    @dic.each do |word|
      if word[0] == @string[-1,1]
        @candidate.push(word)
      end
    end
  end

  def show_candidate
    @candidate.each do |word|
      p word
    end
  end
end


dic = ["창문", "문지기", "기사도"]

w1 = Word.new(dic, "유리문")

w1.make_candidate

w1.show_candidate


