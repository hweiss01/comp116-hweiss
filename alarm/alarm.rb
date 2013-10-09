require 'packetfu'

def error(incident_number, attack, packet, protocol) 
    source_IP_address = packet.ip_saddr;
    puts "#{incident_number}. ALERT: #{attack} from #{source_IP_address} (#{protocol})!"
    incident_number+=1
end

incident number = 1;

caps = PacketFu::Capture.new(:start=> true, :iface => 'eth0', :promisc => true)
caps.stream.each do |raw| #iterate all captured packets
packet = PacketFu::Packet.parse(raw) #returns correct packet subclass based on raw data

protocol = packet.proto[2]
       if packet.proto[1] == "IP"

       	  if packet.proto[2] == "TCP"

	     if packet.tcp_flags.urg==0 and packet.tcp_flags.ack==0 and packet.tcp_flags.psh==0 and packet.tcp_flags.rst==0 and packet.tcp_flags.syn==0 and packet.tcp_flags.fin==0
	     error(incident_number, "Null scan is detected", packet, protocol)	 
	     end

	     if packet.tcp_flags.urg==1 and packet.tcp_flags.ack==0 and packet.tcp_flags.psh==1 and packet.tcp_flags.rst==0 and packet.tcp_flags.syn==0 and packet.tcp_flags.fin==1
	     error(incident_number, "Xmas scan is detected", packet, protocol)
	     end
	
	  end

	payload = packet.payload;

	if /Nmap/.match(payload)
	   error(incident_number, "Nmap scan is detected", packet, protocol)
	end

	if /pass/.match(payload)
	   error(incident_number, "Password leak is detected", packet, protocol)
	end

	if /PASS/.match(payload)
	   error(incident_number, "Password leak is detected", packet, protocol)
	end

	if /<script>alert\(.*\);< /.match(payload)
	   error(incident_number, "Cross scripting is detected", packet, protocol)
	end

	if /<script>window.location.* /.match(payload)
	   error(incident_number, "Cross scripting is detected", packet, protocol)
	end

	if /\d{4}-\d{4}-\d{4}-\d{4} /.match(payload)
	   error(incident_number, "Credit card leaked in the clear", packet, protocol)
	end

	if /\d{4} \d{4} \d{4} \d{4} /.match(payload)
	   error(incident_number, "Credit card leaked in the clear", packet, protocol)
	end

	if /\d{16} /.match(payload)
	   error(incident_number, "Credit card leaked in the clear", packet, protocol)
	end


       end

end