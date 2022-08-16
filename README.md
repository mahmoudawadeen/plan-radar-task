# Plan radar task
## Weather and News API
Postman doc: https://documenter.getpostman.com/view/22771398/VUjTmPGw
### Assumptions
1. The inconsistent API scheme was on purpose, the GET endpoint is not version while the POST is versions (v1).
2. Each user can register for a city with both notification methods, mail and mobile.
3. Registration is unique by the city and the notification method identifier
   1. for mail notification method, the mail needs to be unique
   2. for mobile notification method, the mobile needs to be unique
4. A user registering for the same notification method with the same notification identifier is updating their registration info (name, notification_frequence)
### Fetching news
```
Request:
GET http://localhost:3000/api/news/vienna
Expected Response:
{
   "city": "vienna",
   "latest_news": [
      # News from the newsAPI.org
   ],
   "weather": [
      # Weather information from the OpenWeatherMap.org
   ]
}
```
### Registering for notifications (upsert)
```
Request:
POST/PUT http://localhost:3000/api/v1/news/vienna/register
Request body:
{
   "name": "Jon Doe",
   "mail": "jon@doe.com",
   "mobile": "+43660000000",
   "notification_method": "(mail|mobile)",
   "notification_frequency": "(1h|2h|3h|...)"
}
Response:
{
   "deregister_url": "http:localhost:3000/api/v1/new/vienna/deregister/1"
}
```
### Deregistering
```
Request:
DELETE http:localhost:3000/api/v1/new/vienna/deregister/1
Response:
200 Ok
```
### Running the app
#### Docker compose (recommended)
1. Install mutagen-compose
> [Docker has performance issues when it comes to bind mounts on M1 Macbooks](https://github.com/docker/for-mac/issues/3677), mutagen solves the issue and provides the same docker-compose cli.
```
brew install mutagen-io/mutagen/mutagen-compose
```
2. Start the stack
```
mutagen-compose up
```
3. Run migrations
```
mutagen-compose exec app rails db:migrate
```
4. Generate Token
> runs the initializer which generates and prints the token
```
mutagen-compose exec app rails runner ""
```

#### Directly on host machine
1. `docker-compose up db`
2. `bundle install`
3. `setup db env variables`
   ```
   $ export POSTGRES_DB=plan_radar-task_development
   ```
   ```
   $ export POSTGRES_USER=plan_radar-task
   ```
   ```
   $ export POSTGRES_PASSWORD=plan_radar-task
   ```
4. `bundle exec rails db:migrate`
5. `bundle exec rails s`
> Since the migration ran before starting the app, the token will be printed to the console.

### Authentication
```
Authorization: Token token=<access_token>
```