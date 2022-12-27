package com.whatalab.vipspad.navigation

sealed class AppScreens(val route: String) {
    object SplashScreen: AppScreens("splash_screen")
    object LoginScreen: AppScreens("first_screen")
    object WebViewer: AppScreens("web_viewer")
    object HomeScreen: AppScreens("home_screen")
    object PostsScreen: AppScreens("posts_screen")
    object CreatePostScreen: AppScreens("create_post_screen")
    object PhotoViewer: AppScreens("photo_viewer_screen")
}
