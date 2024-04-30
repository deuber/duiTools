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

# Define a dictionary to store group definitions
group_definitions = {}

try:
    with open(access_file, 'r') as file:
        lines = file.readlines()
except FileNotFoundError:
    print(f"Error: Access file '{access_file}' not found.")
    sys.exit(1)

# Parse group definitions
current_group = None
for line in lines:
    line = line.strip()
    if line.startswith('[') and line.endswith(']'):
        # This is a group definition line
        current_group = line[1:-1]
        group_definitions[current_group] = []
    elif current_group:
        # Add users to the current group
        users = line.split(',')
        group_definitions[current_group].extend(users)

# Find access entries that refer to undefined groups
undefined_groups = []
for group, users in group_definitions.items():
    for user in users:
        if user.startswith('@'):
            referenced_group = user[1:]
            if referenced_group not in group_definitions:
                undefined_groups.append((group, referenced_group))

# Print the undefined group names
for group, undefined_group in undefined_groups:
    print(f"Access entry in group '{group}' refers to undefined group '{undefined_group}'")
    # Remove the undefined group reference
    group_definitions[group] = [user for user in group_definitions[group] if user != f"@{undefined_group}"]

# Output the modified access file
output_file = "access_removed_undefined.txt"
with open(output_file, 'w') as file:
    for group, users in group_definitions.items():
        file.write(f"[{group}]\n")
        user_line = ', '.join(users)
        file.write(user_line + '\n')

print(f"Undefined group references removed. Modified access file saved as '{output_file}'")
