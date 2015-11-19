module Geof
  
  C = ['bash ', File.join(ENV.fetch('HOME'), 'bin', 'geo')].join
  
  def geof
    fork do
      trap('INT') { exit }
      loop do
        system C 
	sleep 3600
      end
    end
  end

end
include Geof
