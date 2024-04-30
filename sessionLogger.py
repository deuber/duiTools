import re
from datetime import datetime
import sys

def calculate_polarion_session_times(log_file_path):
    # Read License log data from the provided file path
    try:
        with open(log_file_path, 'r') as file:
            log_data = file.read()
    except FileNotFoundError:
        return "Log file not found. Please check the file path."

    # Regular expression pattern for matching log entries
    log_pattern = r"(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}),\d{3} .* INFO  PolarionLicensing - User '(\w+)' (logged in|logged out)"

    # Parsing the log data
    log_entries = re.findall(log_pattern, log_data)

    # Tracking user sessions
    user_sessions = {}
    for entry in log_entries:
        timestamp, user, action = entry
        timestamp = datetime.strptime(timestamp, '%Y-%m-%d %H:%M:%S')

        if action == "logged in":
            if user not in user_sessions:
                user_sessions[user] = []
            user_sessions[user].append([timestamp, None])
        elif action == "logged out" and user in user_sessions and user_sessions[user][-1][1] is None:
            user_sessions[user][-1][1] = timestamp

    # Calculating session durations
    session_durations = {user: [] for user in user_sessions}
    session_output = []
    for user, sessions in user_sessions.items():
        for session in sessions:
            if session[1] is not None:
                duration = session[1] - session[0]
                session_durations[user].append(duration)
                session_output.append(f"User '{user}' session: {session[0]} - {session[1]}, Duration: {duration}")

    # Writing session durations to a new log file
    output_file_path = log_file_path.replace('.log', '_sessions.log')
    with open(output_file_path, 'w') as output_file:
        for line in session_output:
            output_file.write(line + '\n')

    return "Session duration data written to " + output_file_path

# Main execution
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <log_file_path>")
    else:
        log_file_path = sys.argv[1]
        result = calculate_polarion_session_times(log_file_path)
        print(result)
