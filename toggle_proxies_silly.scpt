--Silly script that uses AppleScripting GUI scripting to toggle Internet proxies
--Save this script as an app and keep in your dock or desktop to easily toggle settings with one click
--Watch the magic happen!
--Author: kaceycoughlin@mac.com


--Declare variables for status messages
global outStr1, outStr2

--Toggle function
on toggle_proxy()
	--Open System Preferences
	tell application "System Preferences"
		activate
		set current pane to pane "com.apple.preference.network"
	end tell
	
	--Tell OS to do stuff
	tell application "System Events"
		get properties
		--Make System Preferences active
		tell process "System Preferences"
			--Get Network pane
			tell window "Network"
				-- Selects the active network connection; IE Wi-Fi if you're on wifi
				--Table 1 is the list of connections on the left side of the window
				--Scroll Area 1 is the area on the left that Table 1 is inside of
				tell table 1 of scroll area 1
					--Row 1 should be Wi-Fi
					click row 1
				end tell
				
				--Select the Advanced button
				click button 8
				
				--Once the Advance page slides down, select the Proxies tab
				--Tab group 1 is the row of tabs at the top
				--Sheet 1 is that entire Advanced page that slides in
				tell tab group 1 of sheet 1
					--The tabs are aparently radio buttons, don't ask :P
					--Radio button 6 is the Proxies tab
					click radio button 6
					
					--Group 1 is the first grouping on the Proxies tab (Select a protocol to configure)
					tell group 1
						--Table 1 is the list of items in Group 1
						--Scroll area 1 is that first window on the left that Table 1 is in
						--Example (Group 1(Scroll Area 1(Table 1(Row 1))))
						tell table 1 of scroll area 1
							--Toggle for Web Proxy (HTTP)
							--Row 3 should be Web Proxy
							set selected of row 3 to true
							click checkbox 1 of row 3
							if value of (checkbox 1 of row 3) is 1 then
								set outStr1 to "1"
							else
								set outStr1 to "0"
							end if
							--Toggle for Secure Web Proxy (HTTPS)
							--Row 4 should be Secure Web Proxy
							set selected of row 4 to true
							click checkbox 1 of row 4
							if value of (checkbox 1 of row 4) is 1 then
								set outStr2 to "1"
							else
								set outStr2 to "0"
							end if
						end tell
					end tell
					
				end tell
				--Select the Ok button on the Proxies tab to back out of Advanced
				tell sheet 1
					click button "OK"
				end tell
			end tell
			--Select the Apply button on the Network window
			tell window "Network"
				click button "Apply"
			end tell
		end tell
	end tell
	--Quit System Preferences
	tell application "System Preferences"
		quit
	end tell
end toggle_proxy

--Now do the work!
try
	toggle_proxy()
	--If the Web Proxy was toggled, tell us
	if (outStr1 = "1") then
		--If the Secure Web Proxy was toggled, tell us
		if (outStr2 = "1") then
			set statusStr to "The internets have been opened!"
		else
			set statusStr to "The internets have been closed!"
		end if
	else
		--Otherwise, tell us this instead
		set statusStr to "The internets have been closed!"
	end if
	
	--Display Notification Center notification if successful
	display notification statusStr with title "Proxy Toggle"
	
	--Open Safari
	tell application "Safari"
		activate
		--Opens a silly webpage to check for successful internet connection
		--This can be changed to any URL
		open location "http://www.omfgdogs.com/"
	end tell
	--Terminal will now speak!
	say statusStr
end try
