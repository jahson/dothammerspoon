hyper = { 'cmd', 'alt', 'shift', 'ctrl' }

-- A global variable for the sub-key Hyper Mode
k = hs.hotkey.modal.new({}, 'F17')

-- Hyper-key for all the below are setup somewhere... Usually Keyboard Maestro or similar. Alfred doesn't handle them very well, so will set up separate bindings for individual apps below.
hyperBindings = {'H','J','K','L','Y','U','I','O','P','N','M','SPACE','=','-','LEFT','RIGHT'}

for i,key in ipairs(hyperBindings) do
  k:bind({}, key, nil, function() hs.eventtap.keyStroke(hyper, key, 0)
    k.triggered = true
  end)
end

-- Enter Hyper Mode when F18 is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE', 0)
  end
end

-- Bind the Hyper key
f19 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)
