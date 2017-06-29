require './link_cleaner_for_odin_project.rb'

file_path = ARGV.first.to_s

contents = File.read(file_path)
puts "Checking #{contents.lines.length} lines? Press Enter to Continue"
input = $stdin.gets.chomp

output = remove_invalid_lines contents

File.open(file_path, 'w') { |file| file.write(output) }


