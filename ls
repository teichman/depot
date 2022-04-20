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
  response = clio(cmd, quiet=True)
  if type(response) == bytes:
    print(f"Remote server said: {response}")
    remote_contents = []
  else:
    remote_contents = clio(cmd).split('\n')
  
  local_contents = []
  if os.path.exists(args.target):
    local_contents = clio(f"ls {args.target}").split('\n')

  contents = sorted(list(set(remote_contents + local_contents)))
  print()
  width = max([len(c) for c in contents]) + 5
  print(f"{'local':{width}} {args.server:{width}}")
  print('-'*(width*2+5))
  # O(n^2) but who cares
  for fname in contents:
    is_local = fname in local_contents
    is_remote = fname in remote_contents
    if is_local and is_remote:
      print(f"{fname:{width}} {fname:{width}}")
    elif is_local and not is_remote:
      print(f"{fname:{width}}")
    elif not is_local and is_remote:      
      print(f"{'':{width}} {fname:{width}}")
