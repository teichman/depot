#!/opt/homebrew/bin/python3

import ipdb
import os
import argparse
#from rich import print
from cli import cli, clio

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument('server', type=str, help="")
  parser.add_argument('target', nargs='?', type=str, default='.', help="")
  args = parser.parse_args()

  args.target = os.path.realpath(args.target)

  cmd = f"ssh {args.server} ls {args.target}"
  #cmd = f"ssh -t {args.server} ls -l {args.target}"
  remote_contents = clio(cmd).split('\n')
  
  local_contents = []
  if os.path.exists(args.target):
    local_contents = clio(f"ls {args.target}").split('\n')

  contents = sorted(list(set(remote_contents + local_contents)))
  idx_rc = 0
  idx_lc = 0
  print()
  width = max([len(c) for c in contents]) + 5
  print(f"{'local':{width}} {args.server:{width}}")
  print('-'*(width*2+5))
  for idx, c in enumerate(contents):
    if idx_lc < len(local_contents) and local_contents[idx_lc] == c:
      if idx_rc < len(remote_contents) and remote_contents[idx_rc] == c:
        print(f"{c:{width}} {c:{width}}")
        idx_rc += 1
        idx_lc += 1
    elif idx_lc < len(local_contents) and local_contents[idx_lc] == c:        
      print(f"{c:{width}}")
      idx_lc += 1
    elif idx_rc < len(remote_contents) and remote_contents[idx_rc] == c:      
      print(f"{'':{width}} {c:{width}}")
      idx_rc += 1
      
    
  
