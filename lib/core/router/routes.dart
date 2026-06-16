/// Centralized route names and path builders. Using names everywhere keeps
/// deep links and navigation calls refactor-safe.
class Routes {
  const Routes._();

  static const onboarding = 'onboarding';
  static const login = 'login';
  static const register = 'register';
  static const forgotPassword = 'forgot-password';

  static const home = 'home';
  static const search = 'search';
  static const favorites = 'favorites';
  static const inquiries = 'inquiries';
  static const account = 'account';

  static const listing = 'listing';
  static const savedSearches = 'saved-searches';
  static const sell = 'sell';
  static const notifications = 'notifications';
  static const myListings = 'my-listings';
  static const settings = 'settings';

  // Paths
  static const onboardingPath = '/onboarding';
  static const loginPath = '/login';
  static const registerPath = '/register';
  static const forgotPasswordPath = '/forgot-password';
  static const homePath = '/home';
  static const searchPath = '/search';
  static const favoritesPath = '/favorites';
  static const inquiriesPath = '/inquiries';
  static const accountPath = '/account';
  static const listingPath = '/listing/:id';
  static const savedSearchesPath = '/saved-searches';
  static const sellPath = '/sell';
  static const notificationsPath = '/notifications';
  static const myListingsPath = '/my-listings';
  static const settingsPath = '/settings';

  static String listingTo(String id) => '/listing/$id';
}
