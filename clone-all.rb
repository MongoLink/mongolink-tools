#!/usr/bin/env ruby

projets = ["mongolink-parent", "mongolink-testtools", "mongolink", "mongolink-test"]

Dir.chdir("..")
projets.each do |projet|
	if not system "git clone git@github.com:MongoLink/#{projet}.git"
		exit
	end
end