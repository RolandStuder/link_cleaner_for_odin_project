# Link Checker for Project Odin

* Looks whether links in list (typically students solutions) that point to github are still available or return 404
* returns a revised markdown file that where those links are removed.  

## How to use

* Put Markdown do in `./input.md`
* run `ruby clean.rb`
* Use the revised `./output.md`
* Optionally do a manual check by using the suggested command to open all removed links in Google Chrome

## Install

`bundle install`

