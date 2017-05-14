require './link_cleaner_for_odin_project.rb'

contents = File.read('./input.md')

puts "checking #{contents.lines.length}? Press Enter to Continue"

gets

output = remove_invalid_lines contents

File.open('./output.md', 'w') { |file| file.write(output) }
