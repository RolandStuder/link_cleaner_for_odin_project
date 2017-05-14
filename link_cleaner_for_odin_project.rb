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
				puts "INVALID:" + line
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