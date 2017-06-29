require './link_cleaner_for_odin_project.rb'

file_path = ARGV.first.to_s

contents = File.read(file_path)
puts "Checking #{contents.lines.length} lines? Press Enter to Continue"
input = $stdin.gets.chomp

if input == ""
  output = remove_invalid_lines contents

  puts "Save changes? (y/n)"
  input = $stdin.gets.chomp
  File.open('./output.md', 'w') { |file| file.write(output) } if input == "y"
end


