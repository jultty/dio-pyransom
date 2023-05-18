import os
import pyaes
import base64

key = b"0000000000000000"
aes = pyaes.AESModeOfOperationCTR(key)

def traverse(root_dir):
    print('traversing dir: ' + root_dir)
    for path, subdirs, files in os.walk(root_dir):
        for subdir in subdirs:
            print('found subdir: ' + subdir)
            traverse(os.path.join(path, subdir))
        for f in files:
            print('found file: ' + f)
            filepath = os.path.join(path, f)
            filename_split = os.path.splitext(filepath)

            if (filename_split[1] == '.aes'):
                file = open(filepath, "rb")
                encoded_contents = file.read()
                file.close()

                os.remove(filepath)

                encrypted_contents = base64.b64decode(encoded_contents)
                decrypted_contents = aes.decrypt(encrypted_contents)

                out = open(f"{filename_split[0]}", "wb")
                print('writing decrypted contents for ' + f)
                out.write(decrypted_contents)
                out.close()

traverse('test_root')
