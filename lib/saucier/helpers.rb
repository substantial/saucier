RVM_PATH = '/usr/local/rvm'
RVM_BIN_PATH = RVM_PATH + '/bin/rvm'

def _cset(name, *args, &block)
  unless exists?(name)
    set(name, *args, &block)
  end
end

def rvm_wrapper(command)
  "#{RVM_BIN_PATH} #{chef_ruby}@#{chef_gemset} --create do #{command}"
end

