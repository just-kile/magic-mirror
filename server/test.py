import time
import sys
import os

unbuffered = os.fdopen(sys.stdout.fileno(), 'w', 0)
sys.stdout = unbuffered

for i in range(10):
    time.sleep(0.2)
    print(i)