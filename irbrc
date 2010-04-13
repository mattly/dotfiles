def prefer lib
  require lib
rescue LoadError
end

home = File.expand_path('~')

%w(
  rubygems 
  ostruct
  yaml
  irb/completion
  map_by_method
  what_methods
  pp
).each {|l| prefer l }

IRB.conf[:AUTO_INDENT]   = true
IRB.conf[:USE_READLINE]  = true
IRB.conf[:HISTORY_FILE]  = File.expand_path('~/.irb_history.rb') rescue nil
IRB.conf[:SAVE_HISTORY]  = 50
IRB.conf[:EVAL_HISTORY]  = 3

def time(times=1)
  ret = nil
  Benchmark.bm {|x| x.report { times.times { ret = yield } } }
  ret
end

