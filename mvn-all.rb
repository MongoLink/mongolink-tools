#!/usr/bin/env ruby

if ARGV.empty?
	puts "utilisation: #{$0} <cible>[ <cible>[...]]"
	exit
end

projets = ["mongolink", "mongolink-example", "mongolink-integrationtests"]

Dir.chdir("..")
projets.each do |projet|
	Dir.chdir(projet)
	if not system "mvn #{ARGV.join(" ")}"
		exit
	end
	Dir.chdir("..")
end
