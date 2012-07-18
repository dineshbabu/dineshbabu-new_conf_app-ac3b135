

def method_name
  yield
end
method_name {puts 'I am a block'}

BEGIN{puts 'begin'}
END{puts 'end'}
