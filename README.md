# RSS Reader 
"RSS Reader!" is made by [@katorie](https://twitter.com/katorie)

## yochiyochi yomyom
Deployed as [yochiyochi yomyom](http://yochiyochi-yomyom.herokuapp.com/)

## Ruby
'2.1.5'

## Ruby on Rails
'4.1.5'

## Bootstrap
[Bootswatch: Amelia](http://bootswatch.com/amelia/)

## how to use
1. `git clone https://github.com/katorie/rss_reader.git`
2. `cd rss_reader`
3. `bundle install`
4. `rake db:migrate`
5. `rake db:seed`
6. `rails server`
7. open `http://localhost:3000/`

## default Email and password
- Email: yochiyochi@example.jp
- password: yochiyochi

## how to add to crontab
RSS Reader! uses ['whenever'](https://github.com/javan/whenever)
When you do `whenever -i`, every hour RSS Reader! gets new feeds. 

## Looking forward to your Pull Requests
RSS Reader! has some issues. I am looking forward to your Pull Requests or your advice to solve those issues. Thank you!
