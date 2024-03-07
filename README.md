# trollabot_python

## TODO

1. Handle permissioning
2. Handle errors and dont crash if something bad happens
3. Fix the bug where if someone says !quote before there are quotes, we crash
4. Deploy to Heroku
    1. First get the AWS DB migrated over to heroku
        1. Consider doing this with migrations in python actually
    2. Then make sure all the env vars are setup in heroku
    3. Simply deploy.