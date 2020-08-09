# GithubUserList

## Environment Settings
Before build the app, If you use OAuth, Create 'assets/secrets/github_oauth.json' and write your Client Secret of Github OAuth App
* If you want to register a new OAuth application, [Visit here](https://github.com/settings/applications/new). Also, [There is docs](https://docs.github.com/en/developers/apps/building-oauth-apps)
* Please use the following settings only in the debug/development environment to prevent the API key from being leaked to users, and when distribute, use a different method for.
```
{
    "client_id": "Your Client ID",
    "client_secret":"Your Client Secret"
}
```