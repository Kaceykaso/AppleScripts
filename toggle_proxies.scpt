--Declare variables for status messages
global outStr1, outStr2

--Toggle function
on toggle_proxy()
	tell application "System Preferences"
		activate
		set current pane to pane "com.apple.preference.network"
	end tell
	
	tell application "System Events"
		get properties
		tell process "System Preferences"
			tell window "Network"
				-- Selects the active network connection
				tell table 1 of scroll area 1
					click row 1
				end tell
				
				--Select the Advanced button
				click button 8
				
				--Select the Proxies tab
				tell tab group 1 of sheet 1
					-- delay 1
					click radio button 6
					
					tell group 1
						tell table 1 of scroll area 1
							--Toggle for Web Proxy (HTTP)
							set selected of row 3 to true
							click checkbox 1 of row 3
							if value of (checkbox 1 of row 3) is 1 then
								set outStr1 to "Web Proxy has been turned ON"
							else
								set outStr1 to "Web Proxy has been turned OFF"
							end if
							--Toggle for Secure Web Proxy (HTTPS)
							set selected of row 4 to true
							click checkbox 1 of row 4
							if value of (checkbox 1 of row 4) is 1 then
								set outStr2 to "
and Secure Web Proxy has been turned ON"
							else
								set outStr2 to "
and Secure Web Proxy has been turned OFF"
							end if
						end tell
					end tell
					
				end tell
				tell sheet 1
					click button "OK"
				end tell
			end tell
			tell window "Network"
				click button "Apply"
			end tell
		end tell
	end tell
	tell application "System Preferences"
		quit
	end tell
end toggle_proxy

--Now do the work!
try
	toggle_proxy()
	display notification outStr1 & outStr2 with title "Proxy Toggle"
end try
