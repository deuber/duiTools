import requests
import json


# The provided code is a Python script that interacts with Polarion’s REST API to retrieve details about a specific work item within a project. Here is a step-by-step description of what the code does:

# Import Required Libraries: The script begins by importing the requests library, which is used to make HTTP requests in Python, and the json library, which is used for parsing JSON data.

# Define Variables: The script sets up several variables with placeholder values:

# myToken: a placeholder for the authentication token required to authenticate with the Polarion REST API.
# projId: the ID of the project in Polarion from which you want to retrieve a work item.
# wiId: the ID of the work item you want to retrieve.
# domain: the domain where your Polarion server is hosted, set to ‘localhost’ by default.
# Endpoint URL: The script constructs the API endpoint URL using the variables defined above. The URL follows the structure required by Polarion's REST API to access a specific work item.

# HTTP Headers: The script defines headers for the HTTP request, which include:

# Authorization: a header that authorizes the request using the provided token, formatted as a bearer token.
# Accept: a header indicating the script expects a response in JSON format.
# Content-Type: a header indicating that the request body is in JSON format.
# Make HTTP GET Request: The requests.get() function is called with the endPoint URL and headers. This sends an HTTP GET request to the Polarion REST API to retrieve data about the specified work item.

# Check Response Status: The script checks if the status code of the response is 200, which means the request was successful.

#Eg.
# response_content = '''{
#     "links": {
#         "self": "http://localhost/polarion/rest/v1/projects/drivepilot/workitems/DP-313"
#     },
#     "data": {
#         "type": "workitems",
#         "id": "drivepilot/DP-313",
#         "attributes": {
#             "id": "DP-313",
#             "type": "systemrequirement",
#             "title": "DrivePilot shall easily engage operations while the vehicle is at rest.",
#             "severity": "must_have",
#             "status": "approved"
#             // Placeholder for the 'description' field. It will be added to the JSON below.
#         },
#         "relationships": {
#             "project": {
#                 "data": {
#                     "type": "projects",
#                     "id": "drivepilot"
#                 },
#                 "links": {
#                     "self": "http://localhost/polarion/rest/v1/projects/drivepilot/workitems/DP-313/relationships/project"
#                 }
#             }
#         },
#         "links": {
#             "self": "http://localhost/polarion/rest/v1/projects/drivepilot/workitems/DP-313",
#             "portal": "http://localhost/polarion/redirect/project/drivepilot/workitem?id=DP-313"
#         }
#     }
# }'''



# Parse JSON Response: If the request is successful, the JSON response is parsed using json.loads() to convert the JSON data into a Python dictionary.

# Extract and Print WI URL and Description

# Handle Unsuccessful Response: If the status code is not 200, the script prints an error message along with the response status code to indicate that something went wrong.


#Added steps:

#1)Create access token
#See https://docs.sw.siemens.com/en-US/doc/230235217/PL20221020258116340.xid1465510/xid2210302

#2)Enable the REST API in polarion.properties
#com.siemens.polarion.rest.enabled=true

#3)Run pip install requests 


# Your token, project ID, work item ID, and Polarion server domain
# Ensure you replace the placeholder values with actual data specific to your setup

#myToken = '<your Token here>'
myToken = 'eyJraWQiOiJmYzBmYjYwYy03ZjAwMDAwMS02MjM3Y2IwNS01MTE4ODk2ZSIsInR5cCI6IkpXVCIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJhZG1pbiIsImlkIjoiNjc4NDFkMDUtYzBhODAxMDYtMDc2MGEwODctMThlYWUyZDMiLCJleHAiOjE3MTM1MTAwMDAsImlhdCI6MTcwNjgzODcyN30.HFM6GB2NBysLVWB96Sk6ML22bdLcshipqtWuYsJcOorwsBzybw6VxFIob7usk82OnAo4ENEzJNpz6fRb5lK1sVjmWLSDY4kBfFmlFsTUBUQkvxHgFlfA3sCdk_29KQQTmQk3ifPsgKX9f8dPkgPhbgIHmGl7cgP3EGS-8dmiQAa8tDb_65ONV71RRh-89u-AaCeV7jiSahd1R9XhxDHzw19PsOBM-3pg2InPEiOVMoNzoJgUValPBIbNETocDWKQjZHjGVhdYHbBJLf_La6vobcWjq_iYXCpklPRhox-qdDfWrGqLuWyOTVUuloYA-L61XJt-w25_JFD2S2cS02fMg'  # Replace with your actual token
projId = 'drivepilot'
wiId = 'DP-313'
domain = 'localhost'  # Change this if your Polarion server is hosted on a different address

# The REST API endpoint URL for accessing a specific work item in a project
endPoint = f'http://{domain}/polarion/rest/v1/projects/{projId}/workitems/{wiId}'

# Headers including the Authorization token and specifying the expected content type as JSON
headers = {
    'Authorization': f'Bearer {myToken}',
    'Accept': 'application/json',
    'Content-Type': 'application/json'
}

# Perform HTTP GET request to the Polarion REST API
response = requests.get(endPoint, headers=headers)




# Check if the request was successful (HTTP status code 200 indicates success)
if response.status_code == 200:
    # Decode the JSON response content
    workitem = json.loads(response.content)
    
    # Extract the title from the work item data
    title = workitem['data']['attributes']['title']
    
    # Print the title
    print('Title:', title)
    
    portal = workitem['data']['links']['portal']
    print('URL to workitem:', portal)
else:
    # If the response status code is not 200, print an error message and the status code
    print('Request failed with status code:', response.status_code)