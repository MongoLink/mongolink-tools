#!/usr/bin/env ruby

if ARGV.empty?
	puts "utilisation: #{$0} version versionDeveloppementSuivante"
	exit
end

def release(projet, version, versionDeveloppementSuivante)
	Dir.chdir(projet)
	if not system "mvn clean release:prepare -B -Dtag=#{version} -DreleaseVersion=#{version} -DdevelopmentVersion=#{versionDeveloppementSuivante} -DignoreSnapshots=true && mvn release:perform -DignoreSnapshots=true"
		exit
	end
	Dir.chdir("..")
end

def commit_et_push_pom(projet, message)
	if not system "git commit pom.xml -m '#{message}' && git push origin master"
		exit
	end
end

def change_version_parent(projet, versionCourante, versionSuivante)
	Dir.chdir(projet)
	pom = File.read("pom.xml").sub(versionCourante, versionSuivante)
	File.open("pom.xml", 'w') {|f| f.write(pom) }
	commit_et_push_pom(projet, "[Releaser] Change parent version to #{versionSuivante}")
	Dir.chdir("..")
end

Dir.chdir("..")
version = ARGV[0]
versionDeveloppementCourante = "#{ARGV[0]}-SNAPSHOT"
versionDeveloppementSuivante = ARGV[1]

release("mongolink-parent", version, versionDeveloppementSuivante)
change_version_parent("mongolink-testtools", versionDeveloppementCourante, version)
change_version_parent("mongolink", versionDeveloppementCourante, version)
change_version_parent("mongolink-test", versionDeveloppementCourante, version)
release("mongolink-testtools", version, versionDeveloppementSuivante)
release("mongolink", version, versionDeveloppementSuivante)
release("mongolink-test", version, versionDeveloppementSuivante)
change_version_parent("mongolink-testtools", version, versionDeveloppementSuivante)
change_version_parent("mongolink", version, versionDeveloppementSuivante)
change_version_parent("mongolink-test", version, versionDeveloppementSuivante)
