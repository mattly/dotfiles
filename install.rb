#!/usr/bin/env ruby

# from http://errtheblog.com/posts/89-huba-huba
home = File.expand_path('~')

Dir['*'].each do |file|
  next if file =~ /install.rb/
  target = File.join(home, ".#{file}")
  if File.exists?(target)
    File.unlink(target)
  end
  `ln -s #{File.expand_path file} #{target}`
end

%w(env dir_aliases).each {|f| `touch #{home}/.#{f}` }
`mkdir #{home}/.zsh_cache` unless File.exists?("#{home}/.zsh_cache")

if File.file?("#{home}/.id_dsa") && ! File.exists?('ssh/id_dsa')
  `ln -s #{home}/.id_dsa ssh/id_dsa`
end

# git push on commit
`echo 'git push' > .git/hooks/post-commit`
`chmod 755 .git/hooks/post-commit`
