tell application "Viscosity"
	
	if the state of connection 1 is "Connected" then
		disconnect "baseVPN"
		
		repeat until the state of connection 1 is "Disconnected"
			delay 0.5
		end repeat
		
		display dialog "Disconnected" buttons {"OK"} default button 1 with icon note with title "baseVPN" giving up after 2.5
		
	else
		connect "baseVPN"
		
		display dialog "Authenticating..." buttons {"OK"} default button 1 with icon note with title "baseVPN" giving up after 2.5
		
		repeat until the state of connection 1 is "Connected"
			delay 0.5
		end repeat
		
		set dnsInfo to do shell script "cat /etc/resolv.conf | grep nameserver | sed s/nameserver//"
		set vpnInfo to "VPN connection established" & "\n\n" & "VPN: " & name of connection 1 & "\n" & "State: " & state of connection 1 & "\n" & "IP: " & IPv4Address of connection 1 & "\n" & "DNS: " & dnsInfo
		
		display dialog vpnInfo buttons {"OK"} default button 1 with icon note with title "baseVPN" giving up after 10
		
	end if
	
end tell