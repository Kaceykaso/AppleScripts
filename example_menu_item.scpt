on do_menu(app_name, menu_name, menu_item)
  try
    --Bring the target application to the front
    tell application app_name
      activate
    end tell
    tell application "System Events"
      tell process app_name
        tell menu bar 1
          tell menu bar item menu_name
            tell menu menu_name
              click menu item menu_item
            end tell
          end tell
        end tell
      end tell
    end tell
    return true
  on error error_message
    return false
  end try
end do_menu

--Now do the work
try
  do_menu("Safari","File","New Tab")
  display notification "The " & menu_name & " " & menu_item & " has been opened!" with title "Success"
end try
