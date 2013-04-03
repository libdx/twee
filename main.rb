#!/usr/bin/env ruby

require 'gtk2'
require 'login'
require 'model'

module Twee

	class App
		def run
			Config.load

			@login = Login.new(
				:on_ok => lambda{puts :sign_in},
				:on_cancel => lambda{puts :now_way}
			)
			@login.dialog.signal_connect("destroy") {Gtk.main_quit}
			@login.user = Store.instance.user

			@login.dialog.show_all
			Gtk.main
		end
	end

end

Twee::App.new.run

