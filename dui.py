import sys,  webbrowser, subprocess, os


from PyQt5 import QtWidgets, QtCore
from PyQt5.QtWidgets import QDialog,QApplication,QFileDialog, QPushButton, QInputDialog, QLineEdit
from PyQt5.uic import loadUi



class MainWindow(QDialog):
	def __init__(self):
		super(MainWindow,self).__init__()
		loadUi("dui.ui",self)
		self.browse.clicked.connect(self.browsfiles)
		self.browse_2.clicked.connect(self.browsfiles2)
		self.run_button.clicked.connect(self.run)
		# self.run_button.clicked.connect(self.run)
		self.run_exit.clicked.connect(self.exit)
		self.run_exit_2.clicked.connect(self.exit)
		self.run_exit_3.clicked.connect(self.exit)
		self.run_exit_4.clicked.connect(self.exit)
		self.run_help.clicked.connect(self.help)

		self.combo_check_box.stateChanged.connect(self.method_check)
		self.selected = None
		self.selected2 = None
		
		self.selected_string = None
		self.selected_time = None
		self.state = 0
		self.setWindowTitle("Diagdoall")

		# String PDT tab
		self.string_btn.clicked.connect(self.searchString)
		self.help_string.clicked.connect(self.help_s)

		# Time PDT tab
		self.time_btn.clicked.connect(self.searchTime)
		self.help_time.clicked.connect(self.help_t)

		# search ALL tab
		self.search_btn.clicked.connect(self.searchAll)
		self.help_search.clicked.connect(self.help_s2)



	def browsfiles(self):
		browseLocation = os.path.join(os.path.expandvars("%userprofile%"),"Desktop/customers")
		folder = QFileDialog.getExistingDirectory(self, 'Select Folder', browseLocation)
		self.filename.setText(folder)
		# text display only
		pdt_folder = "Path: " + (folder) + "/pdt"
		self.string_path.setText(pdt_folder) 
		self.time_path.setText(pdt_folder)
		self.selected = (folder)

	def browsfiles2(self):
		browseLocation2 = os.path.join(os.path.expandvars("%userprofile%"),"Desktop/customers")
		folder2 = QFileDialog.getExistingDirectory(self, 'Select Folder', browseLocation2)
		self.filename_2.setText(folder2)
		# text display only
		# pdt_folder2 = "Path: " + (folder2) + "/pdt"
		# self.string_path.setText(pdt_folder2) 
		# self.time_path.setText(pdt_folder2)
		self.selected2 = (folder2)


	def searchAll(self):
		selected2 = self.selected2
		string2 = (self.search_line.text())
		if string2=="":
			string2 = None
			print ("Nothing Entered")

	   #if user does not set folder at main
		if selected2 == None:
			print ("Where do want to search, select a folder?")
			return None
		#if user does not enter a string
		if string2 == None:
			print ("What do want to search for, enter a string?")
			return None

		if not os.path.isdir(selected2):
			print ("Folder does not exist")
			print (selected2)
			print ("Return to Main tab and first select search folder")
			return None
		else:
			print ("Searched String:", (string2))
			print ("Selected Path:", (selected2))


		os.chdir(selected2)

		findString_tool = os.path.join(os.path.expandvars("%userprofile%"),"bin/trunk/search.bat")
		print ("Running tool:", findString_tool)
		subprocess.Popen([findString_tool, selected2, string2])


	def searchString(self):
		#get variables from other methods
		selected = self.selected
		string = (self.string_line.text())
		if string=="":
			string = None
			print ("Nothing Entered")
	
		# print ("path", (selected))
		# print ("Searched String", (string))
	
	
	   #if user does not set folder at main
		if selected == None:
			print ("Return to Main tab and first select search folder")
			return None
		#if user does not enter a string
		if string == None:
			print ("What do want to search for?")
			return None

		selected_pdt = (selected) + "/pdt"
		if not os.path.isdir(selected_pdt):
			print ("Folder does not exist")
			print (selected_pdt)
			print ("Return to Main tab and first select search folder")
			return None
		else:
			print ("Searched String:", (string))
			print ("Selected Path:", (selected_pdt))


		os.chdir(selected)

		findString_tool = os.path.join(os.path.expandvars("%userprofile%"),"bin/trunk/findstring.bat")
		print ("Running tool:", findString_tool)
		subprocess.Popen([findString_tool, "pdt", string])


	def searchTime(self):
		#get variables from other methods
		selected = self.selected
		string = (self.time_line.text())
		if string=="":
			string = None
			print ("Nothing Entered")
		
	   #if user does not set folder at main
		if selected == None:
			print ("Return to Main tab and first select valid folder")
			return None
		#if user does not enter a string
		if string == None:
			print ("What do want to search for?")
			return None

		selected_pdt = (selected) + "/pdt"
		if not os.path.isdir(selected_pdt):
			print ("Folder does not exist")
			print (selected_pdt)
			print ("Return to Main tab and first select valid folder")
			return None
		else:
			print ("Searched String:", (string))
			print ("Selected Path:", (selected_pdt))


		os.chdir(selected)

		findTime_tool = os.path.join(os.path.expandvars("%userprofile%"),"bin/trunk/findtime.bat")
		print ("Running tool:", findTime_tool)
		subprocess.Popen([findTime_tool, "pdt", string])

	#this is for NOcombo box 
	def method_check(self, state):
		if state == QtCore.Qt.Checked:
			# print("checked")
			self.state = 1
		else:
			# print("Not checked")
			self.state = 0


	def run(self):

		#get variables from other methods
		selected = self.selected
		state = self.state

		#if user forgets to browse
		if selected == None:
			print ("Please first select a folder with Browse Button, hover over to see tooltips")
			return None
		
		os.chdir(selected)
		
		#If combo_check_box off run "diagdoall", otherwise run "diagdoal -nocombo"
		if state == 0:
			#run simple doall 
			print ("RUNNING DIAGDOALL")
			print ("Selected Folder:", selected)
			tool = os.path.join(os.path.expandvars("%userprofile%"),"bin/trunk/diagdoall.bat")
			print ("Running tool:", tool)
			subprocess.Popen(tool)
			
		else:
			#run doall -nocombo 
			print ("RUNNING DIAGDOALL")
			print ("Selected Folder:", selected)
			tool = os.path.join(os.path.expandvars("%userprofile%"),"bin/trunk/diagdoall.bat -nocombo")
			print ("Running tool:", tool)
			subprocess.Popen(tool)
		

	def exit(self):
		QApplication.quit()


	def help(self):
		webbrowser.open('https://cns.net.plm.eds.com/polarion/#/project/support/wiki/How%20To/Diagtool%20scripts')

	def help_s(self):
		webbrowser.open('https://cns.net.plm.eds.com/polarion/#/project/support/wiki/How%20To/Diagtool%20scripts?selection=SUPPORT-10617')

	def help_t(self):
		webbrowser.open('https://cns.net.plm.eds.com/polarion/#/project/support/wiki/How%20To/Diagtool%20scripts?selection=SUPPORT-10618')

	def help_s2(self):
		webbrowser.open('https://cns.net.plm.eds.com/polarion/#/project/support/wiki/How%20To/Diagtool%20scripts?selection=SUPPORT-10621')



app=QApplication(sys.argv) 
MainWindow=MainWindow()
widget=QtWidgets.QStackedWidget()
widget.addWidget(MainWindow)
widget.setFixedWidth(396)
widget.setFixedHeight(260)
widget.show()
sys.exit(app.exec_())



