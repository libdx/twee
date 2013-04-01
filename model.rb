#!/usr/bin/env ruby

require 'singleton'

module Twee

	UserConfigDirName = ".twee"

	class Config
		include Singleton
		attr_accessor :username
		attr_accessor :password
		attr_accessor :token
		attr_accessor :write_password
		alias_method :write_password?, :write_password

		def instance
			super
			load_system_config
			load_user_config
		end

		def load_system_config
		end

		def load_user_config
		end

		def write_system_config
		end

		def write_user_config
			home = File.expand_path('~')
			
		end
	end

	class DataAccessor
		include Singleton
		def user
			Congif.instance.user
		end
	end

	#class User
	#	attr_accessor :username
	#	attr_accessor :password
	#	attr_accessor :token

	#	def initialize
	#		yield self if block_given?
	#	end

	#	def self.me
	#		DataAccessor.instance
	#	end
	#end

	class Tweet
		attr_accessor :text
		attr_accessor :my
		alias_method :my?, :my
	end

end

