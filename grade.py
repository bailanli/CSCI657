import sys
import os
import math

NUM = 5 
assignment_name = ['wordcount', 'mapreduce', 'viewservice', 'pbservice', 'paxos', 'kvpaxos']

point = {'wordcount' : [25],
         'mapreduce' : [25, 25, 25],
         'viewservice' : [10, 10, 20, 10, 10, 10, 15, 15],
         'pbservice' : [7, 7, 7, 7, 7, 7, 7, 7, 10, 7, 10, 7, 10],
         'paxos' : [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 10, 5, 5, 5, 10, 5],
         'kvpaxos' : [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 10, 10]}

def get_grade(folder):
  assignment = assignment_name[NUM]
  num_test = len(point[assignment])
  result = [0] * num_test
  for i in range(10):
    log_file_name = '{0}/{1}/{1}.log.{2}'.format(folder, assignment, i + 1)
    if not os.path.isfile(log_file_name):
      continue
    with open(log_file_name) as f:
      j = -1
      for line in f:
        if 'Test' == line[:4]:
          j += 1
        if 'Passed' in line:
          result[j] += 1
  sys.stdout.write('{0:18} '.format(folder.split('-')[0]))
  for p in result:
    sys.stdout.write('{0:2}'.format(p))
  sys.stdout.write(' ')
  s = 0.0
  for i in range(len(point[assignment])):
    if NUM < 4:
      sys.stdout.write('{0:5}'.format(float(point[assignment][i]) * result[i] / 10))
      s += float(point[assignment][i]) * result[i] / 10
    else:
      if result[i] == 0:
        score = 0
      else:
        score = float(point[assignment][i]) * math.pow(2, result[i] - 10)
      sys.stdout.write('{0:5.1f}'.format(score))
      s += score
  sys.stdout.write('{0:7.2f}\n'.format(s))

for filename in sorted(os.listdir('.')):
  if os.path.isdir(filename):
    get_grade(filename)

