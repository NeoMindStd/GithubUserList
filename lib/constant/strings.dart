class Global {
  static const INFO = "Info";
  static const CONFIRM = "Confirm";
  static const YES = "Yes";
  static const NO = "No";

  static const LOGIN = "Login";
  static const LOGOUT = "Logout";
  static const USERNAME = "Username";
  static const PASSWORD = "Password";
}

class HTTP {
  static const API_GITHUB_ROOT = "https://api.github.com";
  static const API_GITHUB_LOGGED_IN_USER = "$API_GITHUB_ROOT/user";
  static apiGithubUsers(int since, int perPage) =>
      "$API_GITHUB_ROOT/users?since=$since&per_page=$perPage";
  static apiGithubFollowing(String username) =>
      "$API_GITHUB_ROOT/users/$username/following";
  static apiGithubStarred(String username) =>
      "$API_GITHUB_ROOT/users/$username/starred";

  static const GITHUB_ROOT = "https://github.com";
  static String _githubTap(String username) =>
      "https://github.com/$username?tab=";
  static String githubTapFollowers(String username) =>
      "${_githubTap(username)}followers";
  static String githubTapFollowing(String username) =>
      "${_githubTap(username)}following";
  static String githubTapStars(String username) =>
      "${_githubTap(username)}stars";

  static const DIALOG_ERROR_API_RATE_LIMIT_SHORT = "API rate limit exceeded";
  static const DIALOG_ERROR_API_RATE_LIMIT_LONG =
      "Failed to load some information because API rate limit.";
  static const DIALOG_ERROR_NETWORK_SHORT =
      "Network communication error occurred";
  static const DIALOG_ERROR_NETWORK_LONG =
      "Failed to load some information because a network communication error occurred.";
}

class DetailPage {
  static const PAGE_TITLE_LOGGED_IN_USER = 'My Profile';
  static const PAGE_TITLE_NORMAL = "Details";
  static const REPOSITORIES = "Repositories";
  static const FOLLOWERS = "followers";
  static const FOLLOWING = "following";
  static const STARS = "stars";

  static const DIALOG_MSG_LOGOUT = 'Are you sure you want to log out?';
}

class AuthPage {
  static const PAGE_TITLE = 'Github Authorization';
  static const CARD_TITLE = 'Input';
  static const DIALOG_LOGIN_FAILED =
      "Login failed. Please check the username and password";
}

class HomePage {}
