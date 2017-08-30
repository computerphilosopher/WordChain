require './access_key'
include Access_key

client = Access_key.get_key

test = "한글테스트2"
test = test.encode("utf-8")

client.update(test)
