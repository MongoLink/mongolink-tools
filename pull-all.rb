#!/usr/bin/env ruby

projets = ["mongolink-parent", "mongolink-testtools", "mongolink", "mongolink-test"]

projets.each do |projet|
	Dir.chdir("../#{projet}")
	if not system "git pull origin master"
		exit
	end
end