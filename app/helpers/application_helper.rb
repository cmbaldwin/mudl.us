module ApplicationHelper

	def body(photo = nil)
		if photo == nil
			('<body>')
		else
			('<body style="background: url(' + photo + ') no-repeat center center fixed; -webkit-background-size: contain; -moz-background-size: contain; -o-background-size: contain; background-size: contain; margin: 5px;">')
		end
	end

end
