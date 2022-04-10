import subprocess  
import os  

g_devnull = open(os.devnull, 'w')  

# waits for output  
def clio(cmd, quiet=True):  
  try:  
    if quiet:  
      return subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)[:-1].decode('UTF-8')
    else:  
      print('[cli] {}'.format(cmd))  
      return subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)[:-1].decode('UTF-8')

  except subprocess.CalledProcessError as e:  
    print('[cli] Return code of {} from cmd: {}'.format(e.returncode, cmd))  
    return(e.output[:-1])  

# Non-blocking if you have a trailing ampersand in the command  
def cli(cmd, quiet=True):  
  if quiet:  
    rc = subprocess.call(cmd, shell=True, stdout=g_devnull, stderr=g_devnull)  
  else:  
    print('[cli] {}'.format(cmd))  
    rc = subprocess.call(cmd, shell=True)  

  if rc != 0:  
    print('[cli] Return code of {} from cmd: {}'.format(rc, cmd))  
