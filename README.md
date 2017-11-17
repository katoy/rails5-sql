# README

See
- https://qiita.com/keita-nishimoto/items/b19bf134ff76e6e579eb  
  Rails5,MySQLの開発環境構築を行う   
- https://qiita.com/kytiken/items/45da8f61775ec1cff3f8  
  Mac OS X Mavericksでrailsのbundle install時にnokogiriインストールエラー  
- https://qiita.com/akito19/items/e1dc54f907987e688cc0  
  RailsプロジェクトでMySQLがbundle installできなかった  
- https://techracho.bpsinc.jp/hachi8833/2017_07_12/42497  
  Ruby on Railsで使ってうれしい19のgem  
- https://techracho.bpsinc.jp/hachi8833/2017_02_16/32827  
  rails newで常に使いたい厳選・定番gemリスト（2017年版）  

- https://qiita.com/yuyasat/items/c2ad37b5a24a58ee3d30
  Rails における内部結合、外部結合まとめ

- http://www.task-notes.com/entry/20170813/1502618254
  論理削除を実装するGemのparanoiaについて

- https://techracho.bpsinc.jp/hachi8833/2016_09_15/25967
  DELETE_FLAG を付ける前に確認したいこと

```
  $ rails db:create
  $ rails db:migrate
  $ rails db:speeds
  $ bundle exec erd
  $ bundle exec annotate

  $ APIPIE_RECORD=params bundle exec rake test
  $ APIPIE_RECORD=examples bundle exec rake test
  $ bundle exec rake apipie:static
  $ rails s
  #   access http://localhost:3000/apipie
```

```
  $ rails c -s
  > Hirb.enable
```

includes, joins の差

```
    > Actress.all.each_with_object({}) do |actress, memo|
        memo[actress.name] = actress.movies.map {|m| m.title}
      end

      Actress Load (1.8ms)  SELECT `actresses`.* FROM `actresses`
      Movie Load (0.7ms)  SELECT `movies`.* FROM `movies` WHERE `movies`.`actress_id` = 1
      Movie Load (0.6ms)  SELECT `movies`.* FROM `movies` WHERE `movies`.`actress_id` = 2
      Movie Load (0.5ms)  SELECT `movies`.* FROM `movies` WHERE `movies`.`actress_id` = 3
      Movie Load (0.7ms)  SELECT `movies`.* FROM `movies` WHERE `movies`.`actress_id` = 4
      Movie Load (0.9ms)  SELECT `movies`.* FROM `movies` WHERE `movies`.`actress_id` = 5
      Movie Load (0.7ms)  SELECT `movies`.* FROM `movies` WHERE `movies`.`actress_id` = 6
    => {
      "多部未華子"=>["夜のピクニック"],
      "佐津川愛美"=>["蝉しぐれ", "忍道-SHINOBIDO-", "貞子vs伽椰子"],
      "新垣結衣"=>[],
      "堀北真希"=>["ALWAYS 三丁目の夕日", "県庁おもてなし課"],
      "吉高由里子"=>["真夏の方程式"],
      "悠城早矢"=>[]
    }
```

```
    > Actress.includes(:movies).each_with_object({}) do |actress, memo|
        memo[actress.name] = actress.movies.map {|m| m.title}
      end

      Actress Load (0.7ms)  SELECT `actresses`.* FROM `actresses`
      Movie Load (1.0ms)  SELECT `movies`.* FROM `movies` WHERE `movies`.`actress_id` IN (1, 2, 3, 4, 5, 6)
    => {
      "多部未華子"=>["夜のピクニック"],
      "佐津川愛美"=>["蝉しぐれ", "忍道-SHINOBIDO-", "貞子vs伽椰子"],
      "新垣結衣"=>[],
      "堀北真希"=>["ALWAYS 三丁目の夕日", "県庁おもてなし課"],
      "吉高由里子"=>["真夏の方程式"],
      "悠城早矢"=>[]
    }
```

```
    > Actress.joins(:movies).select('actresses.id, actresses.name, movies.title').each_with_object({}) do |row, memo|
      memo[row.name] = [] if memo[row.name].nil?
      memo[row.name] << row.title
    end
    Actress Load (1.6ms)  SELECT actresses.id, actresses.name, movies.title FROM `actresses` INNER JOIN `movies` ON `movies`.`actress_id` = `actresses`.`id`
    => {
      "多部未華子"=>["夜のピクニック"],
      "佐津川愛美"=>["蝉しぐれ", "忍道-SHINOBIDO-", "貞子vs伽椰子"],
      "堀北真希"=>["ALWAYS 三丁目の夕日", "県庁おもてなし課"],
      "吉高由里子"=>["真夏の方程式"]
    }
```

```
    > Actress.joins(:movies)
    Actress Load (0.6ms)  SELECT `actresses`.* FROM `actresses` INNER JOIN `movies` ON `movies`.`actress_id` = `actresses`.`id`
    +----+------------+---------------------------+---------------------------+
    | id | name       | created_at                | updated_at                |
    +----+------------+---------------------------+---------------------------+
    | 1  | 多部未華子 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 |
    | 2  | 佐津川愛美 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 |
    | 2  | 佐津川愛美 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 |
    | 2  | 佐津川愛美 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 |
    | 4  | 堀北真希   | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 |
    | 4  | 堀北真希   | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 |
    | 5  | 吉高由里子 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 |
    +----+------------+---------------------------+---------------------------+

    > Actress.joins(:movies).select('actresses.*, movies.*')
    Actress Load (1.1ms)  SELECT actresses.*, movies.* FROM `actresses` INNER JOIN `movies` ON `movies`.`actress_id` = `actresses`.`id`
    +----+------------+---------------------------+---------------------------+------------+---------------------+------+
    | id | name       | created_at                | updated_at                | actress_id | title               | year |
    +----+------------+---------------------------+---------------------------+------------+---------------------+------+
    | 1  | 多部未華子 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 1          | 夜のピクニック      | 2006 |
    | 2  | 佐津川愛美 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 2          | 蝉しぐれ            | 2005 |
    | 3  | 佐津川愛美 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 2          | 忍道-SHINOBIDO-     | 2012 |
    | 4  | 佐津川愛美 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 2          | 貞子vs伽椰子        | 2016 |
    | 5  | 堀北真希   | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 4          | ALWAYS 三丁目の夕日 | 2005 |
    | 6  | 堀北真希   | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 4          | 県庁おもてなし課    | 2013 |
    | 7  | 吉高由里子 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 5          | 真夏の方程式        | 2013 |
    +----+------------+---------------------------+---------------------------+------------+---------------------+------+
```

```
    > Actress.joins(:movies).select('actresses.id, actresses.name, movies.title, movises.year')
    Actress Load (1.3ms)  SELECT actresses.id, actresses.name, movies.title, movies.year FROM `actresses` INNER JOIN `movies` ON `movies`.`actress_id` = `actresses`.`id`
    +----+------------+---------------------+------+
    | id | name       | title               | year |
    +----+------------+---------------------+------+
    | 1  | 多部未華子 | 夜のピクニック      | 2006 |
    | 2  | 佐津川愛美 | 蝉しぐれ            | 2005 |
    | 2  | 佐津川愛美 | 忍道-SHINOBIDO-     | 2012 |
    | 2  | 佐津川愛美 | 貞子vs伽椰子        | 2016 |
    | 4  | 堀北真希   | ALWAYS 三丁目の夕日 | 2005 |
    | 4  | 堀北真希   | 県庁おもてなし課    | 2013 |
    | 5  | 吉高由里子 | 真夏の方程式        | 2013 |
    +----+------------+---------------------+------+

    > Actress.joins(:movies).select('actresses.id, actresses.name, movies.id as movies_id, movies.title, movies.year')

    Actress Load (1.1ms)  SELECT actresses.id, actresses.name, movies.id as movies_id, movies.title, movies.year FROM `actresses` INNER JOIN `movies` ON `movies`.`actress_id` = `actresses`.`id`
    +----+------------+-----------+---------------------+------+
    | id | name       | movies_id | title               | year |
    +----+------------+-----------+---------------------+------+
    | 1  | 多部未華子 | 1         | 夜のピクニック      | 2006 |
    | 2  | 佐津川愛美 | 2         | 蝉しぐれ            | 2005 |
    | 2  | 佐津川愛美 | 3         | 忍道-SHINOBIDO-     | 2012 |
    | 2  | 佐津川愛美 | 4         | 貞子vs伽椰子        | 2016 |
    | 4  | 堀北真希   | 5         | ALWAYS 三丁目の夕日 | 2005 |
    | 4  | 堀北真希   | 6         | 県庁おもてなし課    | 2013 |
    | 5  | 吉高由里子 | 7         | 真夏の方程式        | 2013 |
    +----+------------+-----------+---------------------+------+
```

actress, movie, tag

```
    > Actress.joins(movies: :tags).select('actresses.*, movies.*, tags.*')
      Actress Load (1.3ms)  SELECT actresses.*, movies.*, tags.* FROM `actresses` INNER JOIN `movies` ON `movies`.`actress_id` = `actresses`.`id` INNER JOIN `tags` ON `tags`.`movie_id` = `movies`.`id`
    +----+------------+---------------------------+---------------------------+------------+---------------------+------+----------+------------+
    | id | name       | created_at                | updated_at                | actress_id | title               | year | movie_id | key        |
    +----+------------+---------------------------+---------------------------+------------+---------------------+------+----------+------------+
    | 1  | 佐津川愛美 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 2          | 蝉しぐれ            | 2005 | 2        | 時代劇     |
    | 2  | 佐津川愛美 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 2          | 蝉しぐれ            | 2005 | 2        | 子役       |
    | 3  | 佐津川愛美 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 2          | 蝉しぐれ            | 2005 | 2        | 夏         |
    | 4  | 堀北真希   | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 4          | ALWAYS 三丁目の夕日 | 2005 | 5        | 昭和       |
    | 5  | 佐津川愛美 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 2          | 貞子vs伽椰子        | 2016 | 4        | ホラー     |
    | 6  | 堀北真希   | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 4          | 県庁おもてなし課    | 2013 | 6        | 公務員     |
    | 7  | 堀北真希   | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 4          | 県庁おもてなし課    | 2013 | 6        | 地方活性   |
    | 8  | 吉高由里子 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 5          | 真夏の方程式        | 2013 | 7        | ミステリー |
    | 9  | 吉高由里子 | 2017-11-03 17:49:59 +0900 | 2017-11-03 17:49:59 +0900 | 5          | 真夏の方程式        | 2013 | 7        | 夏         |
    +----+------------+---------------------------+---------------------------+------------+---------------------+------+----------+------------+
```

left_join
```
    > Tag.all
    Tag Load (1.0ms)  SELECT `tags`.* FROM `tags`
    +----+----------+--------------+---------------------------+---------------------------+
    | id | movie_id | key          | created_at                | updated_at                |
    +----+----------+--------------+---------------------------+---------------------------+
    | 1  | 2        | 時代劇       | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 |
    | 2  | 2        | 子役         | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 |
    | 3  | 2        | 夏           | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 |
    | 4  | 5        | 昭和         | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 |
    | 5  | 4        | ホラー       | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 |
    | 6  | 6        | 公務員       | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 |
    | 7  | 6        | 地方活性     | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 |
    | 8  | 7        | ミステリー   | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 |
    | 9  | 7        | 夏           | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 |
    | 10 |          | アカデミー賞 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 |
    +----+----------+--------------+---------------------------+---------------------------+

    > Movie.joins(:tags).select('*')
    Movie Load (0.8ms)  SELECT * FROM `movies` INNER JOIN `tags` ON `tags`.`movie_id` = `movies`.`id`
    +----+------------+---------------------+------+---------------------------+---------------------------+----------+------------+
    | id | actress_id | title               | year | created_at                | updated_at                | movie_id | key        |
    +----+------------+---------------------+------+---------------------------+---------------------------+----------+------------+
    | 1  | 2          | 蝉しぐれ            | 2005 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 2        | 時代劇     |
    | 2  | 2          | 蝉しぐれ            | 2005 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 2        | 子役       |
    | 3  | 2          | 蝉しぐれ            | 2005 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 2        | 夏         |
    | 4  | 4          | ALWAYS 三丁目の夕日 | 2005 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 5        | 昭和       |
    | 5  | 2          | 貞子vs伽椰子        | 2016 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 4        | ホラー     |
    | 6  | 4          | 県庁おもてなし課    | 2013 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 6        | 公務員     |
    | 7  | 4          | 県庁おもてなし課    | 2013 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 6        | 地方活性   |
    | 8  | 5          | 真夏の方程式        | 2013 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 7        | ミステリー |
    | 9  | 5          | 真夏の方程式        | 2013 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 7        | 夏         |
    +----+------------+---------------------+------+---------------------------+---------------------------+----------+------------+

    > Movie.left_joins(:tags).select('*')
    Movie Load (34.5ms)  SELECT * FROM `movies` LEFT OUTER JOIN `tags` ON `tags`.`movie_id` = `movies`.`id`
    +----+------------+---------------------+------+---------------------------+---------------------------+----------+------------+
    | id | actress_id | title               | year | created_at                | updated_at                | movie_id | key        |
    +----+------------+---------------------+------+---------------------------+---------------------------+----------+------------+
    |    | 1          | 夜のピクニック      | 2006 |                           |                           |          |            |
    | 1  | 2          | 蝉しぐれ            | 2005 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 2        | 時代劇     |
    | 2  | 2          | 蝉しぐれ            | 2005 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 2        | 子役       |
    | 3  | 2          | 蝉しぐれ            | 2005 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 2        | 夏         |
    |    | 2          | 忍道-SHINOBIDO-     | 2012 |                           |                           |          |            |
    | 5  | 2          | 貞子vs伽椰子        | 2016 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 4        | ホラー     |
    | 4  | 4          | ALWAYS 三丁目の夕日 | 2005 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 5        | 昭和       |
    | 6  | 4          | 県庁おもてなし課    | 2013 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 6        | 公務員     |
    | 7  | 4          | 県庁おもてなし課    | 2013 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 6        | 地方活性   |
    | 8  | 5          | 真夏の方程式        | 2013 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 7        | ミステリー |
    | 9  | 5          | 真夏の方程式        | 2013 | 2017-11-03 22:26:19 +0900 | 2017-11-03 22:26:19 +0900 | 7        | 夏         |
    +----+------------+---------------------+------+---------------------------+---------------------------+----------+------------+
```

倫理削除

where では、 SQL に "deleta_at IS NULL" が追加されています。
```
    > Tag.where(key: '時代劇')
    Tag Load (0.7ms)  SELECT  `tags`.* FROM `tags` WHERE `tags`.`deleted_at` IS NULL AND `tags`.`key` = '時代劇' LIMIT 11
    => #<ActiveRecord::Relation [#<Tag id: 1, movie_id: 2, key: "時代劇", deleted_at: nil, created_at: "2017-11-09 12:26:54", updated_at: "2017-11-09 12:26:54">]>
```

destroy では、deleted_at が設定されます。
```
    > tag = Tag.where(key: '時代劇').first
    Tag Load (0.7ms)  SELECT  `tags`.* FROM `tags` WHERE `tags`.`deleted_at` IS NULL AND `tags`.`key` = '時代劇' ORDER BY `tags`.`id` ASC LIMIT 1
    => #<Tag id: 1, movie_id: 2, key: "時代劇", deleted_at: nil, created_at: "2017-11-09 12:26:54", updated_at: "2017-11-09 12:26:54">

    > tag.destroy
    (0.2ms)  BEGIN
    SQL (0.5ms)  UPDATE `tags` SET `tags`.`deleted_at` = '2017-11-09 12:38:14', `tags`.`updated_at` = '2017-11-09 12:38:14' WHERE `tags`.`id` = 1
    (0.6ms)  COMMIT
    => #<Tag id: 1, movie_id: 2, key: "時代劇", deleted_at: "2017-11-09 12:38:14", created_at: "2017-11-09 12:26:54", updated_at: "2017-11-09 12:38:14">
```

連理削除されたものは、検索ではヒットしません。
```
    > tag = Tag.where(key: '時代劇')
    Tag Load (0.5ms)  SELECT  `tags`.* FROM `tags` WHERE `tags`.`deleted_at` IS NULL AND `tags`.`key` = '時代劇' LIMIT 11
    => #<ActiveRecord::Relation []>
```

with_deleted を指定すれば、論理削除したものでも検索できます。
```
    > Tag.with_deleted.where(key: '時代劇')
    Tag Load (0.4ms)  SELECT  `tags`.* FROM `tags` WHERE `tags`.`key` = '時代劇' LIMIT 11
    => #<ActiveRecord::Relation [#<Tag id: 1, movie_id: 2, key: "時代劇", deleted_at: "2017-11-09 12:38:14", created_at: "2017-11-09 12:26:54", updated_at: "2017-11-09 12:38:14">]>
```

restore で論理削除状態を元に戻せます。(where でヒットするように戻せます)
```
    > Tag.with_deleted.where(key: '時代劇').first.restore
    Tag Load (0.5ms)  SELECT  `tags`.* FROM `tags` WHERE `tags`.`key` = '時代劇' ORDER BY `tags`.`id` ASC LIMIT 1
    (0.2ms)  BEGIN
    SQL (0.5ms)  UPDATE `tags` SET `tags`.`deleted_at` = NULL, `tags`.`updated_at` = '2017-11-09 12:48:37' WHERE `tags`.`id` = 1
    (23.0ms)  COMMIT
    => #<Tag id: 1, movie_id: 2, key: "時代劇", deleted_at: nil, created_at: "2017-11-09 12:26:54", updated_at: "2017-11-09 12:48:37">

    > Tag.where(key: '時代劇').first
      Tag Load (0.5ms)  SELECT  `tags`.* FROM `tags` WHERE `tags`.`deleted_at` IS NULL AND `tags`.`key` = '時代劇' ORDER BY `tags`.`id` ASC LIMIT 1
    => #<Tag id: 1, movie_id: 2, key: "時代劇", deleted_at: nil, created_at: "2017-11-09 12:26:54", updated_at: "2017-11-09 12:48:37">
```
