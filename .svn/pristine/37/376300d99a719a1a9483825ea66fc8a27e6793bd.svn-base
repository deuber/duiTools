import sys
import os
import zipfile

def zip_folder(folder_path):
    for root, dirs, files in os.walk(folder_path):
        for dir in dirs:
            dir_path = os.path.join(root, dir)
            zip_path = dir_path + '.zip'
            if os.path.exists(zip_path):
                print(f'{zip_path} already exists. Skipping...')
                continue
            print(f'Zipping {dir_path}...')
            with zipfile.ZipFile(zip_path, 'w') as zip:
                for sub_root, sub_dirs, sub_files in os.walk(dir_path):
                    for file in sub_files:
                        file_path = os.path.join(sub_root, file)
                        zip.write(file_path, os.path.relpath(file_path, dir_path))
            print(f'{dir_path} zipped successfully.')

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Please specify the folder path as the first argument.')
        sys.exit(1)
    
    folder_path = sys.argv[1]
    zip_folder(folder_path)
