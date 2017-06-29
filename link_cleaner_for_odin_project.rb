require 'http'
require 'pry'

def valid? url
	response = HTTP.get(url)
	if response.status == 404
		return false
	else
		return true
	end	
end

def link_of_list_item line
	match = line.match(/^\*\s+\[.*\]\((https:\/\/github.com\/[^)]*)\)/)
	unless match.nil?
	  return nil if match[1].match(/[\(\)]/)
		return match[1]
	else
		return nil
	end
end

def remove_invalid_lines text
	result = ""
	counter = 0
	invalid_links = []
	text.each_line do |line|
		link = link_of_list_item line
		unless link.nil?
			if valid? link
				result << line
				puts "Valid  :" + line
			else
				line_feedback = "INVALID:".red + line.red
				print line_feedback
				counter += 1
				invalid_links << link
			end
		else
			result << line
		end
	end
	puts "======== #{counter} RESULTS REMOVED ========="
	puts "MANUAL CHECK WITH:"
	puts "open -a Google\\ Chrome " + invalid_links.join(' ')
	return result
end

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end
