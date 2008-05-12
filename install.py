import os

for icon in os.listdir('.'):
	os.system('cp '+icon+' /usr/local/share/ccsm/icons/hicolor/scalable/apps/'+icon)
	print "Copying "+icon

print "Now re-install CCSM"
