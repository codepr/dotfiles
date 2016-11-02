#!/usr/bin/ruby
#
# gulpease.rb
# Calculate Gulpease index of given pdf for ScalateKids VM
# Author: Andrea Giacomo Baldan
# Version: 1.0

require 'lingua/it/readability'

rep = Lingua::IT::Readability.new
Dir.glob('*.pdf') do |pdf|
  text = `pdftotext #{pdf} -`
  rep.analyze(text, ':', ';')
  puts "\n\e[1m[*] " + pdf + "\e[0m\n\n"
  puts rep.report
end
# text = 'Testo campione da analizzare con Gulpease e Flesch tarati su lingua Italiana.'
# rep.analyze(text)
# puts rep.num_syllables
# puts rep.syllables
# puts rep.report
