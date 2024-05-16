abstract class View {}

abstract class SplashScreenView extends View {}

abstract class MainScreenView extends View{
  void didHomePageListEnd();
}

abstract class HomeScreenView extends MainScreenView {}

abstract class SearchScreenView extends View {}

abstract class DetailScreenView extends View {}
