tell application "Viscosity"

-- check if VPN is already connected to toggle on/off. Insert individual VPN connection name above, note that changing the order of connections in the GUI does not affect the order of 'connection 1, 2, 3'

	if the state of connection 1 is "Connected" then
		disconnect "VPN connection name" 
		
		repeat until the state of connection 1 is "Disconnected"
			delay 0.5
		end repeat
		
		display dialog "Disconnected" buttons {"OK"} default button 1 with icon note with title "VPN connection name" giving up after 2.5
		
	else
		connect "VPN connection name"
		
		display dialog "Authenticating..." buttons {"OK"} default button 1 with icon note with title "VPN connection name" giving up after 2.5
		
		repeat until the state of connection 1 is "Connected"
			delay 0.5
		end repeat
		
-- display dialog with VPN connection detail summary

		set dnsInfo to do shell script "cat /etc/resolv.conf | grep nameserver | sed s/nameserver//"
		set vpnInfo to "VPN connection established" & "\n\n" & "VPN: " & name of connection 1 & "\n" & "State: " & state of connection 1 & "\n" & "IP: " & IPv4Address of connection 1 & "\n" & "DNS: " & dnsInfo
		
		display dialog vpnInfo buttons {"OK"} default button 1 with icon note with title "VPN connection name" giving up after 10
		
	end if
	
end tell