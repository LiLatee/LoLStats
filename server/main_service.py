from flask import Flask, escape, request

from match_history_data import get_n_match_history_games_for_player,get_profile_info_for_player

app = Flask(__name__)


@app.route('/')
def hello():
    return '''[
        {"name": "Marcin", "lastname": "Wiecny"}
    ]'''


@app.route('/get_player_history_nick/<nick>')
def get_player_history_nick(nick):
    # EXAMPLE: get_player_history_nick/CrowTrop?n_games=10&index_begin=10
    n_games  = int(request.args.get('n_games', None))
    index_begin  = int(request.args.get('index_begin', None))
    champion  = request.args.get('champion', None)
    print(nick)
    history = get_n_match_history_games_for_player(nick,index_begin,champion,n_games)
    return history
    # return history

@app.route('/get_player_profile_info/<nick>')
def get_player_profile_info(nick):
    profile_data=get_profile_info_for_player(nick)

    return profile_data

if __name__ == '__main__':
    app.run(host='0.0.0.0')