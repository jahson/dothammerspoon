local module = {}
module.showPopUp = false
module.leftCmdLayout = "ABC"
module.rightCmdLayout = "Russian - PC"


module.eventwatcher1 = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(e)
  local flags = e:getFlags()

  if flags.cmd
    and not (flags.alt or flags.shift or flags.ctrl or flags.fn)
    then
    module.cmdWasPressed = true
    module.cmdShouldBeIgnored = false
    return false;
  end

  if flags.cmd
    and (flags.alt or flags.shift or flags.ctrl or flags.fn)
    and module.cmdWasPressed
    then
    module.cmdShouldBeIgnored = true
    return false;
  end

  if not flags.cmd
    then
    if module.cmdWasPressed
      and not module.cmdShouldBeIgnored
      then
      local keyCode = e:getKeyCode()

      if keyCode == 0x37 then
        hs.keycodes.setLayout(module.leftCmdLayout)

        if module.showPopUp then
          hs.alert.show("English", 0.2)
        end

      elseif keyCode == 0x36 then
        hs.keycodes.setLayout(module.rightCmdLayout)

        if module.showPopUp then
          hs.alert.show("Russian", 0.2)
        end
      end
    end

    module.cmdWasPressed = false
    module.cmdShouldBeIgnored = false
  end

  return false;
end):start()


module.eventwatcher2 = hs.eventtap.new({"all", hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.NSEventTypeGesture}, function(e)
  local flags = e:getFlags()

  if flags.cmd and module.cmdWasPressed then
    module.cmdShouldBeIgnored = true
  end

  return false;
end):start()
