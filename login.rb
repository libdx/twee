#!/usr/bin/env ruby

require "gtk2"

module Twee

	class Login
		attr_accessor :dialog
		attr_accessor :on_ok
		attr_accessor :on_cancel

		def initialize (args={})
			@on_ok, @on_cancel  = args[:on_ok], args[:on_cancel]
			builder = Gtk::Builder.new.add_from_file('login.glade')
			@dialog = builder.get_object('login_dialog')
			builder.connect_signals do |signal|
				lambda {
					case signal
						when 'on_ok'
							on_ok.call unless on_ok.nil?
						when 'on_cancel'
							on_cancel.call unless on_cancel.nil?
					end
				}
			end
		end
	end

end

