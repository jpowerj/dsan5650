import datetime
import os

if not os.getenv("QUARTO_PROJECT_RENDER_ALL"):
  exit()

cur_ts = str(datetime.datetime.now().strftime("%Y-%m-%d, %I:%M:%S %p"))
env_line = f'DSAN5650_LAST_UPDATED="{cur_ts}"'
with open("_environment", 'w', encoding='utf-8') as outfile:
  outfile.write(env_line)

