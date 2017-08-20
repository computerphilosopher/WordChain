﻿#encoding: utf-8

class Word
  def initialize(string)
    
    @dic = ["창문", "문지기", "기사도"]
    @string = string
    @candidate = Array.new
  end

  def last_letter
    return @string[-1,1]
  end

  def is_in?
    return @dic.include?(@string)
  end
end

w1 = Word.new("기사도")

p w1.last_letter

puts w1.is_in?

