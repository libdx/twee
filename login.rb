#!/usr/bin/ruby

require "gtk2"

class User
	attr_accessor :username
	attr_accessor :password
end

class Login
	attr_accessor :dialog
	attr_accessor :on_ok
	attr_accessor :on_cancel
	def initialize (args={})
		@on_ok = args[:on_ok]
		@on_cancel = args[:on_cancel]
		builder = Gtk::Builder.new.add_from_file('login.glade')
		@dialog = builder.get_object('login_dialog')
		builder.connect_signals do |signal|
			lambda {
				case signal
					when 'on_ok'
						on_ok.call if not on_ok.nil?
					when 'on_cancel'
						on_cancel.call if not on_cancel.nil?
				end
			}
		end
	end
end

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

App.new.run
