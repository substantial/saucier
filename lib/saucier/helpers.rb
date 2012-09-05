def _cset(name, *args, &block)
  unless exists?(name)
    set(name, *args, &block)
  end
end

def rvm_wrapper(command)
  "rvm #{chef_ruby}@#{chef_gemset} --create do #{command}"
end
