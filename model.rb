#!/usr/bin/env ruby

require 'singleton'
require 'yaml'

module Twee

	UserConfigDirName = ".twee"
	UserConfigMainFileName = "config.yml"

	class Config
		include Singleton
		attr_accessor :write_password
		alias_method :write_password?, :write_password

		def self.load
			Config.instance
		end

		def initialize
			super
			load_system_config
			load_user_config
		end

		def user
			@users[0]
		end

		def users
			@users
		end

		def config_path
			File.expand_path("~/#{UserConfigDirName}/#{UserConfigMainFileName}")
		end

		def load_system_config
		end

		def load_user_config
			path = config_path
			if File.exist?(path)
				config = YAML.load_file(path)
				@users = config[:users]
				write_password = config[:write_password]
			else
				# populate dummy user
				user = User.new
				user.username = "elkness"
				user.password = "*******"
				@users = [user]
			end
		end

		def write_system_config
		end

		def write_user_config
			path = config_path
			config = {:users => @users, :write_password => write_password?}
			File.open(path, 'w') { |out| YAML.dump(config, out) }
		end
	end

	class Store
		include Singleton
		def user
			Config.instance.user
		end
		def users
			Config.instance.users
		end
	end

	class User
		attr_accessor :username
		attr_accessor :password
		attr_accessor :token
		attr_accessor :messages

		def initialize
			yield self if block_given?
		end
	end

	class Message
		attr_accessor :text

		def belongs_to_user?(user)
		end
	end

end

