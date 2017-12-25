class Word
	def initialize(dic, string, killer)

		@dic = dic

		@user_word = string

		@killer_dic = killer

		@candidate = Array.new 

	end

	def in_dic?
		return @dic.include?(user_word)
	end

	def make_candidate
		@dic.each do |word|
			if word[0] == @user_word.reverse[0]
				@candidate.push(word)
			end
		end
	end

	def show_candidate
		if @candidate == nil 
			puts "not in dictionary"
		else
			puts @candidate
		end
	end

	def can_kill?
		p @killer_dic & @candidate

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
			word = word.encode("UTF-8")
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

class Killer_Dic < Dictionary  

	attr_reader :killer_list, :uniq_last

	def show_killer
		p @killer_list
	end

	#첫 글자에 등장하지 않는 글자 추출

	def find_killer_last

		@uniq_last = @last_letter

		@uniq_last.each do |letter|
			head_sound=Jamo_handler.new(letter)
			head_sound.change_head_sound
			if @first_letter.include?(letter)
				@uniq_last.delete(letter)
			else @first_letter.include?(head_sound.changed_letter)
				p head_sound.changed_letter
				@uniq_last.delete(letter)
			end

		end

	end
	#killer_last를 끝 글자로 하는 단어 추출

	def find_killer_word
		@killer_list = Array.new
		@word_list.each do |word|
			if @uniq_last.include?(word.reverse[0])
				@killer_list.push(word)
			end
		end
	end
end

class Jamo_handler 
	attr_reader :chosung, :jungsung, :jongsung, :chosung_code, :changed_letter

	SYLLABLE_START = 0xAC00
	CHOSUNG_START = 0x1100 
	JUNGSUNG_START = 0x1161 
	JONGSUNG_START = 4520 
	CONSONANT_START = 0x11A7 

	def initialize(input)
		@letter = input
		@unpacked = input.unpack("U*")

		@hangul_index = @unpacked[0]-SYLLABLE_START 

		get_chosung()
		get_jongsung()
		get_jongsung()

	end

	def get_chosung

		@chosung_code = (@hangul_index/28/21)+CHOSUNG_START

		@chosung = [@chosung_code]

	end

	def get_jungsung

		@jungsung_code = ((@hangul_index/28)%21)+JUNGSUNG_START

		@jungsung = [@jungsung_code]

	end

	def get_jongsung

		@jongsung_code = (@hangul_index%28)+JONGSUNG_START
		@jongsung = [@jongsung_code]
	end

	def repack_seperated
		@chosung = @chosung.pack("U*") 
		@jungsung = @jungsung.pack("U*")
		@jongsung = @jongsung.pack("U*")
	end

	def detach_jongsung 
		detached= @unpacked[0]-(@jongsung_code-JONGSUNG_START)
		 
		return [detached].pack("U*")

	end

	def show_index
		puts @chosung_code
		puts @jungsung_code
		puts @jongsung_code
	end

	def show_split
		puts [@chosung, @jungsung, @jongsung]
	end

	def change_head_sound

		head_letter = detach_jongsung

		case head_letter

		when "녀"
			then changed_letter= "여"
		when "뇨"
			then changed_letter= "요"
		when "뉴"
			then changed_letter= "유"
		when "니"
			then changed_letter= "이"

		when "랴"
			then changed_letter= "야"
		when "려"
			then changed_letter= "여"
		when "례"
			then changed_letter= "예"
		when "료"
			then changed_letter= "요"
		when "류"
			then changed_letter= "유"
		when "리"
			then changed_letter= "이"

		when "라"
			then changed_letter= "나"
		when "래"
			then changed_letter= "내"
		when "로"
			then changed_letter= "노"
		when "뢰"
			then changed_letter= "뇌"
		when "루"
			then changed_letter= "누"
		when "르"
			then changed_letter= "느"

		else 
			changed_letter=head_letter
		end
		
		return attach_jongsung(changed_letter)
	end

	def attach_jongsung(detached_letter)
		jongsung = (@jongsung_code - JONGSUNG_START)
		dl_index = detached_letter.unpack("U*")[0]
		complete_letter= dl_index + jongsung 
		return [complete_letter].pack("U*")
	end
end


#f = File.open("kor_dic.txt") 
#txt = f.readlines

#k = Killer_Dic.new(txt)
#k.reprocess
#k.extract_letter

#k.find_killer_last
#k.find_killer_word
#k.show_killer

