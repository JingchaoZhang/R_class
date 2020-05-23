import requests_with_caching
import json

def get_movies_from_tastedive(movie_name):
    baseurl = "https://tastedive.com/api/similar"
    params_diction = {}
    params_diction['q'] = movie_name
    params_diction['type'] = 'movies'
    params_diction['limit'] = 5
    td = requests_with_caching.get(baseurl, params = params_diction)
    #print(td.url)
    return td.json()

def extract_movie_titles(d):
    return [x['Name'] for x in d['Similar']['Results']]

def get_related_titles(l):
    name_list = []
    for i in l:
        names = extract_movie_titles(get_movies_from_tastedive(i))
        for n in names:
            if n not in name_list:
                name_list.append(n)
    return name_list

def get_movie_data(movie_name):
    baseurl = "http://www.omdbapi.com/"
    params_diction = {}
    params_diction['t'] = movie_name
    params_diction['r'] = 'json'
    td = requests_with_caching.get(baseurl, params = params_diction)
    return td.json()

def get_movie_rating(m):
    d = get_movie_data(m)
    l = []
    for s in d['Ratings']:
        l.append(s['Source'])
        if s['Source'] == 'Rotten Tomatoes':
            return int(s['Value'].split('%')[0])
    if 'Rotten Tomatoes' not in l:
        return 0

def get_sorted_recommendations(l):
    movies = get_related_titles(l)
    d = {}
    for m in movies:
        d[m] = get_movie_rating(m)
    return(sorted(d, key = lambda x:(d[x], x), reverse = True))
