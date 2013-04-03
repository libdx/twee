#!/usr/bin/env ruby

require "gtk2"

module Twee
	
	class Gtk::Builder
		# use |get_objects| like this:
		# 	@dialog, @username_entry = builder.get_objects([
		# 		'login_dialog', 
		# 		'username_entry'
		# 	])
		# or using block and auxiliary object
		# 	builder.get_objects {|i|
		# 		@dialog = i['login_dialog']
		# 		@username_entry = i['username_entry']
		# 	}
		# or mix both			
		def get_objects(names=[])
			yield ObjectIndexer.new(self) if block_given?
			objs = []
			names.each { |name| objs.push(get_object(name)) }
			objs
		end
		class ObjectIndexer
			def initialize(builder)
				@builder = builder
			end
			def [](key)
				@builder.get_object(key)
			end
		end
	end

	class Login
		attr_accessor :dialog
		attr_accessor :on_ok
		attr_accessor :on_cancel
		attr_accessor :user

		def initialize (args={})
			@on_ok, @on_cancel  = args[:on_ok], args[:on_cancel]
			builder = Gtk::Builder.new.add_from_file('login.glade')
			@dialog, @username_entry, @password_entry = builder.get_objects([
				'login_dialog', 
				'username_entry',
				'password_entry'
			])
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

		def user=(user)
			@username_entry.text = user.username
			@password_entry.text = "**********" unless user.nil?
		end
	end

end

