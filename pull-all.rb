#!/usr/bin/env ruby

projets = ["mongolink-parent", "mongolink-testtools", "mongolink", "mongolink-test", "mongolink-integrationtests", "mongolink.github.com"]

projets.each do |projet|
	Dir.chdir("../#{projet}")
	if not system "git pull origin master"
		exit
	end
end
