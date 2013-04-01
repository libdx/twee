#!/usr/bin/env ruby

require 'gtk2'
require 'login'
require 'model'

module Twee

	class App
		def run
			@login = Login.new(
				:on_ok => lambda{puts :sign_in},
				:on_cancel => lambda{puts :now_way}
			)
			@login.dialog.signal_connect("destroy") {Gtk.main_quit}
			@login.dialog.show_all
			Gtk.main
		end
	end

end

Twee::App.new.run

