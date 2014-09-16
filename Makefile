
# Makefile for tom command
#
#	Planned Targets:
#

tom: FORCE
	rm -f bin/tom
	cat src/usage.sh > bin/tom
	cat src/utils.sh >> bin/tom
	cat src/commands/*.sh >> bin/tom
	cat src/main.sh >> bin/tom
	chmod u+x bin/tom
	
install: 
	cp bin/tom /Users/brant/bin/tom
	
FORCE:
	

