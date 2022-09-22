import sys,json

argv = sys.argv[1]

if len(argv) > 1:
    credentials = open('credentials.json')
    data = json.load(credentials)
    if not (data.get(argv) is None):
        print(data.get(argv))

    credentials.close()


