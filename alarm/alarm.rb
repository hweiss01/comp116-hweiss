require 'packetfu'

def error(incident_number, attack, packet,  protocol)
  source_IP_address = packet.ip_saddr;
  puts protocol
puts " #{incident_number}. ALERT: #{attack} from #{source_IP_address} (#{protocol})!"
  incident_number+=1
end


incident_number = 1;

caps = PacketFu::Capture.new(:start=> true, :iface => 'eth0', :promisc => true)
caps.stream.each do |raw| #iterate all captured packets
packet = PacketFu::Packet.parse(raw) #returns correct packet subclass based on raw data

#packet = PacketFu::TCPPacket.new
#packet.eth_saddr = "00:01:AB:BC:02:DE"
#packet.eth_daddr = "00:0c:29:67:fc:29"

#packet.ip_header.ip_saddr = "192.158.43.120"
#packet.ip_header.ip_daddr = "192.168.2.80"

#packet.payload = "password hjkgj"
#packet.tcp_flags.fin = 1
#packet.to_w('eth0')

protocol = packet.proto[2]
#puts  protocol
if packet.proto[1] == "IP"

if packet.proto[2] == "TCP"

#puts "tcp packet"

  if packet.tcp_flags.urg==0 and packet.tcp_flags.ack==0 and packet.tcp_flags.psh==0 and packet.tcp_flags.rst==0 and packet.tcp_flags.syn==0 and packet.tcp_flags.fin==0
    error(incident_number, "Null scan is detected", packet,  protocol)


end


if packet.tcp_flags.urg==1 and packet.tcp_flags.ack==0 and packet.tcp_flags.psh==1 and packet.tcp_flags.rst==0 and packet.tcp_flags.syn==0 and packet.tcp_flags.fin==1

  error(incident_number, "Xmas scan is detected", packet, protocol)

end

 end 

payload = packet.payload


if /Nmap/.match(payload)
  error(incident_number, "Nmap scan is detected", packet, protocol)
end

if /pass/.match(payload)
   error(incident_number, "password leak is detected", packet, protocol)
end

if /PASS/.match(payload)
   error(incident_number, "password leak is detected", packet, protocol)
end

if /<script>alert\(.*\);< /.match(payload)
   error(incident_number, "cross scripting is detected", packet, protocol)
end

if /<script>window.location.* /.match(payload)
   error(incident_number, "cross scripting is detected", packet, protocol)
end


if  /\d{4}-\d{4}-\d{4}-\d{4}/.match(payload)

   error(incident_number, "credit card leak is detected", packet, protocol)
end

if  /\d{4} \d{4} \d{4} \d{4} /.match(payload)
   error(incident_number, "credit card leak is detected", packet, protocol)
end

if /\d{16} /.match(payload)
   error(incident_number, "credit card leak", packet,  protocol)
end


end

end



