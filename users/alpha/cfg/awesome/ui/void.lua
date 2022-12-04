local wibox = require 'wibox'

return function (as_widget)
	return as_widget and wibox.widget.textbox() or {
		widget = wibox.widget.textbox,
	}
end
