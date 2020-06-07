import shutil

import requests



summoners_url = 'http://ddragon.leagueoflegends.com/cdn/10.11.1/data/en_US/summoner.json'
r = requests.get(url = summoners_url) 
summoners_json = r.json()
summoners = dict()
for summoner in summoners_json['data']:
    summoners[summoners_json['data'][summoner]['name']] = summoners_json['data'][summoner]['id']

for v in summoners:
    try:
        url = 'http://ddragon.leagueoflegends.com/cdn/10.11.1/img/spell/{0}.png'.format(summoners[v])
        print(url)
        response = requests.get(url, stream=True)
        if response.status_code == 200:
            with open('{0}.png'.format(v), 'wb') as out_file:
                shutil.copyfileobj(response.raw, out_file)
            del response
        else:
            print("There is no {0} icon under this adress".format(v))

    except:
        print("There is no {0} icon under this adress".format(v))