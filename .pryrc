require 'json'
#require 'socket'
require 'byebug'
require 'pathname'
require 'securerandom'

Pry.config.color = true
Pry.config.auto_indent = true
Pry.config.correct_indent = true
Pry.commands.alias_command 'q', 'exit'

def get_class_info(cl)
	my_public_methods = cl.public_methods
	my_protected_methods = cl.protected_methods
	my_private_methods = cl.private_methods

	my_variables = cl.instance_variables
	my_constants = cl.constants
	my_class_variables = cl.class_variables

	my_instance_public_methods = cl.public_instance_methods
	my_instance_protected_methods = cl.protected_instance_methods
	my_instance_private_methods = cl.private_instance_methods
	if cl.class == Class
		parent = cl.superclass
	else
		parent = Module
	end
	if parent
		cl = parent
		my_public_methods -= cl.public_methods
		my_protected_methods -= cl.protected_methods
		my_private_methods -= cl.private_methods
		
		my_variables -= cl.instance_variables
		my_constants -= cl.constants
		my_class_variables -= cl.class_variables

		my_instance_public_methods -= cl.public_instance_methods
		my_instance_protected_methods -= cl.protected_instance_methods
		my_instance_private_methods -= cl.private_instance_methods
	end


	return my_public_methods,my_protected_methods,my_private_methods,my_variables,my_constants,my_class_variables,my_instance_public_methods,my_instance_protected_methods,my_instance_private_methods
end

class Object
	#打印自己定义的函数
	def self_methods
		#是否是实例
		is_instance = nil
		str = ""
		if self.class == Class
			my_public_methods = self.public_methods
			my_protect_methods = self.protected_methods
			my_private_methods = self.private_methods
			parent = self.superclass
		elsif self.class == Module
			str = "unsupport\n"
		else
			#实例
			is_instance = true
			my_public_methods = self.public_methods
			parent = self.class.superclass
		end

		if is_instance && parent
			parent_public_methods = parent.public_instance_methods
		elsif parent
			parent_public_methods = parent.public_methods
			parent_protected_methods = parent.protected_methods
			parent_private_methods = parent.private_methods
		end
				
		if my_public_methods
			my_public_methods -= parent_public_methods
		end
		if my_protect_methods
			my_protect_methods -= parent_protected_methods
		end
		if my_private_methods
			my_private_methods -= parent_private_methods
		end


		if my_public_methods && my_public_methods.size >0
			str += "-Public Methods-\n#{my_public_methods.sort}\n"
		end
		if my_protect_methods && my_protect_methods.size >0
			str+= "-Protect Methods-\n#{my_protect_methods.sort}\n"
		end
		if my_private_methods && my_private_methods.size >0
			str+= "-Private Methods-\n#{my_private_methods.sort}\n"
		end
		#return str
		Kernel.puts str
	end

	#打印相关信息
	def info
		str = ""
		if self.class == Class || self.class==Module  #类
			my_public_methods,my_protected_methods,my_private_methods,my_variables,my_constants,my_class_variables,
			my_instance_public_methods,my_instance_protected_methods,my_instance_private_methods = get_class_info self
			
			if self.class == Class
				str += "Class: #{self.name}\n"
			else
				str += "Module: #{self.name}\n"
			end
			if self.class == Class
				if self.superclass
					str += "Inherit: #{self.ancestors[1..-1]}\n"
				end
			end
			if my_public_methods.size>0
				str += "Public methods:\n#{my_public_methods.sort}\n"
			end
			if my_protected_methods.size>0
				str += "Protect methods:\n#{my_protected_methods.sort}\n"
			end
			if self.class == Class
				puts self
				if my_private_methods.size>0
					str += "Private methods:\n#{my_private_methods.sort}\n"
				end
			end
			if my_variables.size>0
				str += "Variables:\n"
				my_variables.each_with_index do |var,index|
					value = instance_variable_get(var)
					if index != 0
						str += ", "
					end
					str += "#{var}=#{value}"
				end
				str += "\n"
			end
			if my_constants.size>0
				str += "Constants:\n"
				my_constants.each_with_index do |var,index|
					value = self.const_get(var)
					if index != 0
						str += ", "
					end
					str += "#{var}=#{value}"
				end
				str += "\n"
			end
			if my_class_variables.size>0
				str += "Class variables:\n"
				my_class_variables.each_with_index do |var,index|
					value = class_variable_get(var)
					if index != 0
						str += ", "
					end
					str += "#{var}=#{value}"
				end
				str += "\n"
			end

			if my_instance_public_methods.size>0
				str += "Instance Public methods:\n#{my_instance_public_methods.sort}\n"
			end
			if my_instance_protected_methods.size>0
				str += "Instance Protect methods:\n#{my_instance_protected_methods.sort}\n"
			end
			if self.class == Class
				if my_instance_private_methods.size>0
					str += "Instance Private methods:\n#{my_instance_private_methods.sort}\n"
				end
			end
		else
			#实例
			str += "Object: from class #{self.class}\n"
			if self.singleton_methods.size>0
				str += "Singleton methods:\n #{self.singleton_methods.sort}\n"
			end
			my_variables = self.instance_variables
			if my_variables.size>0
				str += "Variables:\n"
				my_variables.each_with_index do |var,index|
					value = instance_variable_get(var)
					if index != 0
						str += ", "
					end
					str += "#{var}=#{value}"
				end
				str += "\n"
			end
			my_public_methods = self.public_methods
			parent = self.class.superclass
			if parent
				my_public_methods -= parent.public_instance_methods
			end
			if my_public_methods.size>0
				str+= "Useful self methods:\n#{my_public_methods.sort}\n"
			end

		end
		#return str
		Kernel.puts str
	end
end

class Class
	#打印自己定义的实例函数
	def self_instance_methods

		my_public_methods = self.public_instance_methods
		my_protect_methods = self.protected_instance_methods
		my_private_methods = self.private_instance_methods
		parent = self.superclass

		parent_public_methods = parent.public_instance_methods
		parent_protected_methods = parent.protected_instance_methods
		parent_private_methods = parent.private_instance_methods

				
		if my_public_methods
			my_public_methods -= parent_public_methods
		end
		if my_protect_methods
			my_protect_methods -= parent_protected_methods
		end
		if my_private_methods
			my_private_methods -= parent_private_methods
		end

		str = ""
		if my_public_methods && my_public_methods.size >0
			str += "public methods#{my_public_methods.sort}\n"
		end
		if my_protect_methods && my_protect_methods.size >0
			str += "protect methods#{my_protect_methods.sort}\n"
		end
		if my_private_methods && my_private_methods.size >0
			str += "private methods#{my_private_methods.sort}\n"
		end
		#return str
		Kernel.puts str
	end

	def all_info
		str = ""
		ancestors.each do |cl|
			Kernel.puts cl.info
			Kernel.puts '-'*20
			Kernel.puts "\n"
		end
		#Kernel.puts str
	end
end
