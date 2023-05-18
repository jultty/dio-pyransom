import os

def traverse(root_dir):
    for path, subdirs, files in os.walk(root_dir):
        for subdir in subdirs:
            traverse(os.path.join(path, subdir))
        for file in files:
            filepath = os.path.join(path, file)
            # encrypt logic

traverse('/test_root')
