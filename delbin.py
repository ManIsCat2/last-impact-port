import os

for filename in os.listdir(os.curdir+"/actors"):
    file_path = os.path.join(os.curdir+"/actors", filename)
    if os.path.isfile(file_path) and filename.endswith('.bin') or os.path.isfile(file_path) and filename.endswith('.col'):
        if not ("yoshi_metal_geo") in filename and not ("yoshi_nest_") in filename and ("yoshi_rideable_") not in filename:
            os.remove(file_path)