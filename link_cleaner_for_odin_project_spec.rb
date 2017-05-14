require './link_cleaner_for_odin_project.rb'

describe "link checker" do 

	it "returns true for valid links" do
		expect( valid?("https://github.com") ).to eq(true)
	end	

	it "returns false for 404 links" do
		expect( valid?("https://github.com/some/url/that/does/not/exist") ).to eq(false)
	end

	it "return true for redirects" do
		expect( valid?("https://github.com/d-zer0/caeser_cipher/blob/master/lib/caesar_cipher.rb")).to eq(true)
	end
end

describe "link matcher" do
	it "matches lines with github-links in list" do
		line = "* [Hello World](https://github.com/)"
		line_2 = "* [Hello World](https://github.com/something/more) somemore"
		line_3 = "* [HenrytheDJ's solution](https://github.com/henrythedj/caesar_cipher)|[View in Browser](https://repl.it/CieN/0)"
		expect( link_of_list_item(line  )).to eq("https://github.com/")
		expect( link_of_list_item(line_2)).to eq("https://github.com/something/more")
		expect( link_of_list_item(line_3)).to eq("https://github.com/henrythedj/caesar_cipher")
	end

	it "ignores lines with parentheses in links" do
  	#regexe would need to handle balancing parenthes, which is complexity I don't want to get into right now
  	line = "* [Parentheses in Link :-(](https://github.com//odin(Ruby%20projects)/"
		expect( link_of_list_item(line  )).to eq(nil)
	end

	it "return nil for non matches" do
		line = "**Something bold**"
		line_2 = "* blabla"
		line_3 = "* [Something] blabal"
		line_3 = "* [Something](http://hitobito.com)"
		expect( link_of_list_item(line  )).to eq(nil)
		expect( link_of_list_item(line_2)).to eq(nil)
		expect( link_of_list_item(line_3)).to eq(nil)
	end
end

describe "erase 404 links" do
	it "erases 404 lines" do
		
		valid_line = "* [Valid](https://github.com)\n"
		invalid_line = "* [Invalid](https://github.com/some/url/that/does/not/exist)\n"
		other_valid_line = "* [More_valid stuff](https://github.com)\n"
		
		expect( remove_invalid_lines(
			valid_line + invalid_line + other_valid_line
		)).to eq(
			valid_line + other_valid_line
		)
	end
end
