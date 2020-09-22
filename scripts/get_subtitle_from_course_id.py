import json
import sys

subtitles = json.load(sys.stdin)
for s in subtitles:
    print('。'.join(s))
