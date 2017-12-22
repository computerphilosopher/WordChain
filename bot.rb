# encoding: utf-8

require './access_key'

require './game'

include Access_key

client = Access_key.get_key
test = "한글 테스트" 

test = test.encode("utf-8")

client.update(test)
