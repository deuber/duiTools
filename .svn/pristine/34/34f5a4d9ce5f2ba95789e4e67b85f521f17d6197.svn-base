#!/usr/bin/env python
import sys
import subprocess, webbrowser, os



#This script runs Radomir's Java main log parse and analyize tool
#https://cns.net.plm.eds.com/polarion/#/project/PolarionSVN/wiki/Documentation/Polarion%20Log%20Parser%20-%20Analyzer
#Requires Windows BS modification to registry key.
#[HKEY_CLASSES_ROOT\Applications\python.exe\shell\open\command]
#https://stackoverflow.com/questions/2640971/windows-is-not-passing-command-line-arguments-to-python-programs-executed-from-t
#From "C:\Python\Python33\python.exe" "%1" to "C:\Python\Python33\python.exe" "%1" %* 
#Example:
#analyzer.py log4j-20221222-1021-07.log



# Check that a filename was provided as an argument
if len(sys.argv) > 1:
    print(sys.argv[1])
else:
    print("Error: No Main log provided")
    sys.exit(1)


# Open the file and read its contents
filename = sys.argv[1]


try:
    with open(filename, "r") as f:
        contents = f.read()
except IOError:
    print("Error: Unable to open file '%s'" % filename)
    sys.exit(1)

print(os.path.dirname(__file__))
html_file = filename+".html"

# Build the command to run the jar file
command = ["java", "-jar", "C:\\Users\\o9cxuh\\bin\\trunk\\plpa-1.0.1.jar", "-h" , html_file ,  filename]

# Run the command and capture the output
try:
    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
    print(result.stdout.decode())
    webbrowser.open('file://' + os.path.realpath(html_file))
except subprocess.CalledProcessError as e:
    print("Error: The jar file returned an error code: %d" % e.returncode)
    sys.exit(1)
    
