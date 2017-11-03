require 'database_cleaner'

ACTRESSES = {
  '多部未華子': [
    {title: '夜のピクニック', year: 2006}
  ],
  '佐津川愛美': [
    {title: '蝉しぐれ', year: 2005},
    {title: '忍道-SHINOBIDO-', year: 2012},
    {title: '貞子vs伽椰子', year: 2016}
  ],
  '新垣結衣':[],
  '堀北真希':[
    {title: 'ALWAYS 三丁目の夕日', year: 2005},
    {title: '県庁おもてなし課', year: 2013}
  ],
  '吉高由里子':[
    {title: '真夏の方程式', year: 2013}
  ],
  '悠城早矢':[]
}
TAGS = {
  '蝉しぐれ': ['時代劇', '子役', '夏'],
  'ALWAYS 三丁目の夕日': ['昭和'],
  '貞子vs伽椰子': ['ホラー'],
  '県庁おもてなし課': ['公務員', '地方活性'],
  '真夏の方程式': ['ミステリー', '夏']
}

DatabaseCleaner.clean_with(:truncation)

ACTRESSES.each do |actress, mvs|
  movies = mvs.map { |mv| Movie.create(mv) }
  Actress.create(name: actress, movies: movies)
end

TAGS.each do |title, tags|
  movie = Movie.find_or_create_by!(title: title)
  movie.tags = tags.map { |tag| Tag.create(key: tag) }
end
Tag.create(key: 'アカデミー賞').save
