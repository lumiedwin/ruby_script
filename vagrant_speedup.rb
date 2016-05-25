config.vm.provider "virtualbox" do |v|
  host = RbConfig::CONFIG['host_os']

  # Give VM 1/4 system memory 
  case host
  when  /darwin/ then mem = `sysctl -n hw.memsize`.to_i / 1024
  when  /linux/ then mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i 
  when /mswin|mingw|cygwin/ then mem = `wmic computersystem Get TotalPhysicalMemory`.split[1].to_i / 1024
  else
    puts "The #{host} OS is not supported for speed up yet. Please alert Tools team."
    next
  end

  mem = mem / 1024 / 4
  v.customize ["modifyvm", :id, "--memory", mem]
end
