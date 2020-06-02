import requests 
import json
import pandas as pd
from pandas import json_normalize

# https://developer.riotgames.com/
KEY= "RGAPI-c22a4c31-a12b-41b9-ac88-bf37ab044449"




def to_df(data):
    json_data = json.dumps(data)
    dataframe = pd.read_json(json_data, orient='index')
    dataframe = dataframe.reset_index(drop=True)
    return dataframe

def get_summoner_data_by_name(name):
    header = {"X-Riot-Token": "{0}".format(KEY)}
    URL = "https://eun1.api.riotgames.com/lol/summoner/v4/summoners/by-name/{0}".format(name)
    r = requests.get(url = URL,headers=header) 
    summoner_data = r.json() 
    return summoner_data

def get_all_champions_data_patch(patch):
    champs_url = "http://ddragon.leagueoflegends.com/cdn/{0}/data/en_US/champion.json".format(patch)
    r = requests.get(url = champs_url) 
    champions_data = r.json()
    champs=pd.DataFrame.from_dict(champions_data.values())
    champions = to_df(champs[0][3])
    champions.reset_index()
#     champions = pd.concat([champions.drop(['info'], axis=1), json_normalize(champions['info'])], axis=1)
    champions = pd.concat([champions.drop(['stats'], axis=1), json_normalize(champions['stats'])], axis=1)
    champions = pd.concat([champions.drop(['image'], axis=1), json_normalize(champions['image'])], axis=1)
    champions = champions.drop(['name'], axis=1)
    return champions

def get_history_for_player_id(player_id,champion_id='',queue='',season='',endTime='',beginTime='',endIndex='',beginIndex=''):
    params = "?"
    header = {"X-Riot-Token": "{0}".format(KEY)}
    
    if champion_id != '' and champion_id != None:        
        params=params + "champion={0}&".format(champion_id)
    if queue != '' and queue != None:        
        params=params + "queue={0}&".format(queue)
    if season != '' and season != None:         
        params=params + "season={0}&".format(season)
    if endTime != '' and endTime != None:        
        params=params + "endTime={0}&".format(endTime)
    if beginTime != '' and beginTime != None:           
        params=params + "beginTime={0}&".format(beginTime)
    if endIndex != '' and endIndex != None:          
        params=params + "endIndex={0}&".format(endIndex)
    if beginIndex != '' and beginIndex != None:          
        params=params + "beginIndex={0}&".format(beginIndex)
        
    URL = "https://eun1.api.riotgames.com/lol/match/v4/matchlists/by-account/{0}{1}".format(player_id,params)
    r = requests.get(url = URL,headers=header) 
    matchhistory = r.json() 
    return matchhistory


def add_champs_to_history(history,champs):
    for game  in history['matches']:
        game['champion_name'] = champs.loc[champs['key']==game['champion']]['id'].iat[0]
    return history

def get_match_for_matchid(matchid):
    URL = "https://eun1.api.riotgames.com/lol/match/v4/matches/{0}".format(matchid)
    header = {"X-Riot-Token": "{0}".format(KEY),
             }
    r = requests.get(url = URL,headers=header) 
    match = r.json() 
    return match

def get_champion_name(champ_id,champs):
    return champs.loc[champs['key']==champ_id]['id'].iat[0]

def get_game_data(match_data,account_id):

    game_data = dict()
    
    base_data = dict()
    
    advance_data = dict()
    
    players_data = dict()
    
    main_player_id_from_game = 1
    
    for player in match_data['participantIdentities']:
        if player['player']["currentAccountId"] == account_id:
            main_player_id_from_game = player['participantId']
        players_data[player['participantId']] = dict()
        players_data[player['participantId']]['summonerName:']= player['player']["summonerName"]
        players_data[player['participantId']]['accountID:']= player['player']["currentAccountId"]
        players_data[player['participantId']]['profileIcon:']= player['player']["profileIcon"]
    
    for player in match_data['participants']:
        players_data[player['participantId']]['stats'] = player['stats']
        kills = player['stats']['kills']
        assists = player['stats']['assists']
        deaths = player['stats']['deaths']
        players_data[player['participantId']]['KDA'] = [kills,assists,deaths]
#         items = []
#         for item in ['item0','item1','item2','item3','item4','item5','item6']:
#             items.append(player['stats'][item])
#         runes = []
#         for rune in ['item0','item1','item2','item3','item4','item5','item6']:
#             runes.append(player['stats'][item])
#         players_data[player['participantId']]['items'] = items
#         players_data[player['participantId']]['largestMultiKill'] = player['stats']['largestMultiKill']
    
    base_data = get_base_data_data_for_player(match_data,main_player_id_from_game)
    base_data['KDA'] = players_data[main_player_id_from_game]['KDA']
    
    advance_data["players_data"] = players_data
    
    game_data["base_data"] = base_data
    game_data["advance_data"] = advance_data
    return game_data
    
    
def get_base_data_data_for_player(match_data,main_player_id_from_game):
    """
    match_data -> raw data from riot
    main_player_id_from_game -> int from 1-10 represents player in game
    finds data about:
    perks
    championId
    win
    game_duration
    """
    base_data = dict()
#     print(main_player_id_from_game)
#     print(match_data['participants'][main_player_id_from_game-1])
    base_data['perks'] = [match_data['participants'][main_player_id_from_game-1]['stats']['perk0'],
                          match_data['participants'][main_player_id_from_game-1]['stats']['perkSubStyle']]    
    base_data['championId'] = match_data['participants'][main_player_id_from_game-1]['championId']    
    base_data['win'] = match_data['participants'][main_player_id_from_game-1]['stats']['win']
    base_data['game_duration'] = match_data['gameDuration']
    return base_data

def get_n_match_history_games_for_player(summonername,index_begin, champion,n_games=10):
    summoner_data=get_summoner_data_by_name(summonername)
    print(summoner_data)
    account_id =summoner_data['accountId']
    history = get_history_for_player_id(account_id,champion_id=champion,endIndex=index_begin+n_games,beginIndex=index_begin)
    match_history = []
    for game in range(0,n_games):
#         print("GAME_{0}".format(game))
        match_data = get_match_for_matchid(history['matches'][game]['gameId'])
        analyzed_data = get_game_data(match_data,account_id)
        match_history.append(analyzed_data)
        
    return json.dumps(match_history)

def get_ranked_data_for_sum_id(sum_id):
    header = {"X-Riot-Token": "{0}".format(KEY)}
    rank_data_url = "https://eun1.api.riotgames.com/lol/league/v4/entries/by-summoner/{0}".format(sum_id)
    r = requests.get(url = rank_data_url,headers=header) 
    data = r.json()
    return data

def get_profile_info_for_player(summonername):
    summoner_data=get_summoner_data_by_name(summonername)
    summoner_id =summoner_data['id']
    all_rankeds_data = get_ranked_data_for_sum_id(summoner_id)
    profile_info_data = dict()
    profile_info_data['profileIconId'] = summoner_data['profileIconId']
    profile_info_data['accountId'] = summoner_data['accountId']
    profile_info_data['name'] = summoner_data['name']
    profile_info_data['summonerLevel'] = summoner_data['summonerLevel']
    profile_info_data['ranked_data'] = all_rankeds_data
    return json.dumps(profile_info_data)