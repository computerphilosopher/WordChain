#encoding: utf-8
#chcp 65001로 인코딩 할 것 

class Word
  def initialize(dic, string)

    @dic = dic

    @user_word = string

    @candidate = []
  end

  def in_dic?
    return @dic.include?(user_word)
  end

  def make_candidate
    @dic.each do |word|
      if word[0] == @user_word[-1]
        @candidate.push(word)
      end
    end
  end

  def show_candidate
    if @candidate == nil 
      puts "사전에 없습니다."
    else
      puts @candidate
    end
  end
end



class Dictionary

  attr_reader :word_list, :last_letter, :first_letter
  def initialize(txt)

    @word_list = txt

    @last_letter = Array.new
    @first_letter = Array.new
  end


  def reprocess
    @word_list.each do |word|
      word = word.chomp!
      word = word.force_encoding("UTF-8")
    end
  end

  def extract_letter
    @word_list.each do |word|
      word.force_encoding("UTF-8")
      @last_letter.push(word.reverse[0]) 
      @first_letter.push(word[0])
    end
  end

  def show_last
    p @last_letter
  end
end

class Killer  

  def initialize(word_list, first_letter, last_letter)

    @word_list = word_list
    @last_letter = last_letter
    @first_letter = first_letter

    @killer_word = Array.new
  end

  
  def show_killer
    p @killer_word
  end

  def killer_last

    @uniq_last = @last_letter

    @uniq_last.each do |letter|
      if @first_letter.include?(letter)
        @uniq_last.delete(letter)
      end
    end

    File.open("uniq.txt","w:UTF-8"){ |f|
      f.puts @uniq_last
    }

  end

  def show_last
    p @last_letter
  end

  def killer_word
    @word_list.each do |word|
      if @uniq_last.include?(word.reverse[0])
        @killer_word.push(word)
      end
    end
  end
end

f = File.open('kor_dic.txt') 
txt = f.readlines

dic = Dictionary.new(txt)
dic.reprocess
dic.extract_letter

k = Killer.new(dic.word_list, dic.first_letter, dic.last_letter)

k.killer_last

k.killer_word

k.show_last

k.show_killer
