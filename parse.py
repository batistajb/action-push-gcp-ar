import sys,json

argv = sys.argv[1]
json_argv = json.loads(argv)

# Serializing json
json_object = json.dumps(json_argv, indent=4)

# Writing to credentials.json
with open("credentials.json", "w") as outfile:
    outfile.write(json_object)
    print("File written successfully")

