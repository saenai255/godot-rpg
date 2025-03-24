from datetime import datetime, timezone
import sys

args = sys.argv[1:]

if len(args) < 2:
    raise Exception('not enough args')

git_hash = args[0]
channel = args[1]

now = datetime.now(timezone.utc).isoformat('T').split('.')[0]

full_version = f'{channel}_{now}_{git_hash}'
print(full_version)

with open('project.godot', 'r+') as file:
    content = file.read()
    file.seek(0)
    content = str(content)
    content = content.replace('config/version="Development"', f'config/version="{full_version}"', count=1)
    file.write(content)

