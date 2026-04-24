enum UrlLauncherScheme {
  email,
  whatsApp;

  String getScheme({required UrlLauncherScheme urlScheme}) {
    switch (urlScheme) {
      case UrlLauncherScheme.email:
        return 'mailto';
      case UrlLauncherScheme.whatsApp:
        return 'https://wa.me/';
    }
  }
}
