fork do
	loop do
	  system ['bash ', File.join(ENV.fetch('HOME'), 'bin', 'geo')].join
	  sleep 3600
	end
end
