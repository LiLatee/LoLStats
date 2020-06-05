import requests 
import json
import pandas as pd
from pandas import json_normalize
import re
import os

def get_perks_img_for_id(perks_id,perks_all): 
    path = re.findall('(?<=Styles/).*$', perks_all[perks_id]['path'])
    path = '/perks/Styles/'+path[0]
    return path

def get_s_spell_img_for_id(s_spell_id,s_spell_all): 
    path = '/s_spell/'+s_spell_all[s_spell_id]+'.png'
    return path
