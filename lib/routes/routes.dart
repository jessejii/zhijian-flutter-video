/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

enum Routes {
  splash('splash', '/'),
  test('test', '/test'),
  webView('webView', '/webView'),
  home('home', '/index'),
  videoDetails('videoDetails', '/video/details'),
  articleDetails('articleDetails', '/article/details'),
  setting('setting', '/setting'),
  settingYoung('settingYoung', '/setting/young'),
  settingTheme('settingTheme', '/setting/theme'),
  settingAbout('settingAbout', '/setting/about'),
  userShow('userShow', '/user/show'),
  userLogin('userLogin', '/user/login'),
  userMessage('userMessage', '/user/message'),
  userHistory('userHistory', '/user/history'),
  userFav('userFav', '/user/fav'),
  userFavShow('userFavShow', '/user/fav/show'),
  userAccount('userAccount', '/user/account'),
  userAccountUsername('userAccountUsername', '/user/account/username'),
  userAccountAvatar('userAccountAvatar', '/user/account/avatar'),
  search('search', '/search');

  final String _fullPath;
  final String _name;

  const Routes(this._name, this._fullPath);

  String get fullPath => _fullPath;

  String get name => _name;
}
