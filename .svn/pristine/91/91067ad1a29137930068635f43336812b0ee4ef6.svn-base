#!/usr/bin/env python

import sys
import os

# Check if an access file is provided as a command-line argument
if len(sys.argv) != 2:
    print("Usage: cleanAccess.py <access_file>")
    sys.exit(1)

access_file = sys.argv[1]

# Check if the provided access file exists
if not os.path.isfile(access_file):
    print(f"Error: Access file '{access_file}' not found.")
    sys.exit(1)

# Define a set to store defined groups
defined_groups = set()

try:
    with open(access_file, 'r') as file:
        lines = file.readlines()
except FileNotFoundError:
    print(f"Error: Access file '{access_file}' not found.")
    sys.exit(1)

# Function to check if a group is defined
def is_group_defined(group_name):
    return group_name in defined_groups

# Output the modified access file
output_file = "access_removed_undefined.txt"
with open(output_file, 'w') as file:
    for line in lines:
        line = line.strip()
        if not line.startswith('@'):
            # Keep lines that don't start with '@'
            file.write(line + '\n')
        else:
            # Check if the group is defined
            group_name = line[1:]  # Remove the '@' symbol
            if is_group_defined(group_name):
                file.write(line + '\n')
            else:
                print(f"Access entry '{line}' refers to an undefined group and will be removed.")

print(f"Undefined group references removed. Modified access file saved as '{output_file}'")
