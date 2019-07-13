local applicationHotkeys = {
   a = 'iTerm',
   e = 'emacs',
}

local hyper = { "cmd", "alt", "ctrl", "shift" }

for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function()
      hs.application.launchOrFocus(app)
  end)
end
