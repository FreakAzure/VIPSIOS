package com.whatalab.vipspad.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.google.accompanist.pager.ExperimentalPagerApi
import com.whatalab.vipspad.view.PhotoViewer.PhotoViewer
import com.whatalab.vipspad.view.homeScreen.HomeScreen
import com.whatalab.vipspad.view.homeScreen.HomeScreenViewModel
import com.whatalab.vipspad.view.webViewer.WebViewer
import com.whatalab.vipspad.view.loginScreen.LoginScreen
import com.whatalab.vipspad.view.loginScreen.LoginScreenViewModel
import com.whatalab.vipspad.view.postCreation.PostCreationScreen
import com.whatalab.vipspad.view.postCreation.PostCreationViewModel
import com.whatalab.vipspad.view.postFeed.PostFeed
import com.whatalab.vipspad.view.postFeed.PostFeedViewModel
import com.whatalab.vipspad.view.splash.SplashScreen

@OptIn(ExperimentalPagerApi::class)
@Composable
fun AppNavigation(startDestination: String) {
    val navController = rememberNavController()
    NavHost(navController = navController, startDestination = startDestination, builder = {
        composable(route = AppScreens.LoginScreen.route + "/{show_alert}") {
            val viewModel = LoginScreenViewModel()
            val showAlert = navController.currentBackStackEntry?.arguments?.getString("show_alert").toBoolean()
            LoginScreen(navController = navController, loginScreenViewModel = viewModel, showAlert = showAlert ?: false)
        }
        composable(route = AppScreens.WebViewer.route) {
            WebViewer(navController = navController)
        }
        composable(route = AppScreens.HomeScreen.route) {
            val viewModel: HomeScreenViewModel = HomeScreenViewModel()
            HomeScreen(navController = navController, viewModel)
        }
        composable(route = AppScreens.SplashScreen.route) {
            SplashScreen(navController = navController)
        }
        composable(route = AppScreens.PostsScreen.route + "/{category_id}") {
            val categoryId = navController.currentBackStackEntry?.arguments?.getString("category_id")
            val viewModel = PostFeedViewModel()
            if (categoryId != null) {
                PostFeed(navController, viewModel, categoryId.toInt())
            }
        }
        composable(route = AppScreens.CreatePostScreen.route) {
            val viewModel = PostCreationViewModel()
            PostCreationScreen(navController = navController, viewModel = viewModel)
        }
        composable(route = AppScreens.PhotoViewer.route +  "/{image_url}") {
            val imageUrl = navController.currentBackStackEntry?.arguments?.getString("image_url")
            PhotoViewer(navController = navController, image_url = imageUrl.toString())
        }
    })
}