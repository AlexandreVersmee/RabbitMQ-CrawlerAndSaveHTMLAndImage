# Description

The program crawls given urls and stores the contents (HTML and images) in a database.
<br/>
P0: It creates and fills a queue with the contents of the database's table "url".<br/>
P1: It fetches the queue created by P0 and crawls the websites. Then it creates and fills 2 queues, 1 containing the HTML and 1 containing the images of the websites crawled.<br/>
P2: It fetches the HTML's queue and fills the database.<br/>
P3: It fetches the images' queue and fills the database.<br/>

## Prerequisite

Run Redis server and RabbitMq before run P0, P1, P2 and P3.

## Database's Installation

Create a database named 'tp2_systeme_distribue' (mysql):

```sql
CREATE DATABASE tp2_systeme_distribue;
```

You will probably need to edit `db/config.yml` and `test/Test_MYSQL_Connection.rb` with your user and password database.

Test your connection:

```ruby
ruby test/Test_MYSQL_Connection.rb
```

The output should be similar as:
- Server version: 5.5.47-0ubuntu0.14.04.1
- Server version: 5.5.44-MariaDB

## Setup environment

```ruby
bundle install
bundle update
rake db:migrate
rake db:seed
```

Change the default encoding to UTF8 for HTML's contents (optional):

```sql
USE tp2_systeme_distribue;
ALTER TABLE web_pages CONVERT TO CHARACTER SET utf8;
```

## Run P0

```ruby
ruby P0/create_and_fill_Q1.rb [nameQueue1] (default 42)
```

## Run P1

```ruby
ruby P1/crawl_url.rb [nameQueue1] [nameQueue2] [nameQueue3] (default 42, 37, 1337)
```

## Run P2

```ruby
ruby P2/save_html.rb [nameQueue2] (default 37)
```

## Run P3

```ruby
ruby P3/save_image_.rb [nameQueue3] (default 1337)
```

## Lib folder

If you need to create queue and channel use InitCreateQ class in ./lib/init_create_q.rb
