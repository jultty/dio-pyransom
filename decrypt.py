import os
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

key = b'0000000000000000'

def traverse(root_dir):
  print('traversing: ' + root_dir)
  for path, subdirs, files in os.walk(root_dir):
    for subdir in subdirs:
      traverse(os.path.join(path, subdir))
    for f in files:
      print('found file: ' + f)
      filepath = os.path.join(path, f)
      filename_split = os.path.splitext(filepath)

      if (filename_split[1] == '.aes'):
        encrypted_file = open(filepath, 'rb')
        nonce = encrypted_file.read(16)
        tag = encrypted_file.read(16)
        ciphertext = encrypted_file.read(-1)
        encrypted_file.close()

        cipher = AES.new(key, AES.MODE_EAX, nonce)
        plain_data = unpad(cipher.decrypt_and_verify(ciphertext, tag),
                           AES.block_size)

        os.remove(filepath)

        plain_file = filename_split[0]
        plain_file = open(f'{plain_file}', 'wb')
        plain_file.write(plain_data)
        plain_file.close()

traverse('test_root')
