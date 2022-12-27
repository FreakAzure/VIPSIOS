package com.whatalab.vipspad.view.homeScreen

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.Surface
import androidx.compose.runtime.*
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.TileMode
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import androidx.navigation.compose.rememberNavController
import com.whatalab.vipspad.controllers.SharedPreferencesController
import com.whatalab.vipspad.controllers.SharedPreferencesController.Companion.API_KEY
import com.whatalab.vipspad.models.Categories
import com.whatalab.vipspad.navigation.AppScreens
import com.whatalab.vipspad.ui.composables.LoadingScreen
import com.whatalab.vipspad.ui.composables.TopBar
import com.whatalab.vipspad.ui.composables.alertDialog
import com.whatalab.vipspad.ui.composables.recycledViews.CategoryItem
import com.whatalab.vipspad.ui.theme.GradientButton
import com.whatalab.vipspad.ui.theme.VipsPadTheme
import com.whatalab.vipspad.util.Singleton

@Composable
fun HomeScreen(navController: NavController, viewModel: HomeScreenViewModel) {
    VipsPadTheme {
        HomeBodyContent(navController, viewModel)
    }
}

@Composable
fun HomeBodyContent(navController: NavController, viewModel: HomeScreenViewModel) {
    val categories: Categories? by viewModel.categories.observeAsState()
    val loading by viewModel.loading.observeAsState()
    var showLogoutMessage by remember { mutableStateOf(false) }

    viewModel.retrieveUserData(navController.context)
    viewModel.retrieveCategories(0, navController.context)
    val createPostGradient =
        Brush.verticalGradient(
            listOf(Color(0xFFFFCD82), Color(0xFF845C21), Color(0x00000000)),
            tileMode = TileMode.Decal
        )
    val backgroundGradient =
        Brush.horizontalGradient(listOf(Color(0xFF000000), Color(0xFF090909), Color(0xFF212121)))
    Surface(
        modifier = Modifier
            .fillMaxSize()
            .background(backgroundGradient),
        color = Color.Transparent
    ) {
        if (showLogoutMessage) {
            alertDialog(title = "Logout!",
                subtitle = "¿Vas a cerrar la sesión, estás seguro?",
                onDismissRequest = { showLogoutMessage = false },
                onAcceptRequest = {
                    SharedPreferencesController(navController.context).deletePreference(
                        API_KEY
                    )

                    navController.popBackStack()
                    navController.navigate(AppScreens.LoginScreen.route + "/${false}")
                })

        }
        Column(
            modifier = Modifier
                .fillMaxSize()
                .background(Color.Transparent),
            verticalArrangement = Arrangement.Top,
            horizontalAlignment = Alignment.CenterHorizontally

        ) {
            Row {
                TopBar(screenName = "HOME", "V1P$ CALLS", false, { navController.popBackStack() }, {showLogoutMessage = true})
            }
            Row {
                categories?.let { categories ->
                    LazyColumn(
                        modifier = Modifier
                            .padding(horizontal = 16.dp)
                            .background(Color.Transparent)
                            .fillMaxHeight(0.93f)
                    ) {
                        items(categories) { category ->
                            CategoryItem(category, navController.context, navController)
                        }
                    }
                }
            }

            Singleton.user.value?.let {
                if (it.is_admin) {
                    Column(
                        modifier = Modifier.fillMaxHeight(),
                        verticalArrangement = Arrangement.Bottom
                    ) {
                        GradientButton(
                            onClick = {
                                navController.navigate(AppScreens.CreatePostScreen.route)
                            },
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(40.dp),
                            text = "CREATE A CALL",
                            textColor = Color(0xA3FFFFFF),
                            gradient = createPostGradient,
                            fontSize = 20.sp,
                            image = null,
                            fontWeight = FontWeight.Bold
                        )
                    }
                }
            }
        }
        loading?.let {
            if (it) {
                LoadingScreen(modifier = Modifier.fillMaxSize())
            }
        }
    }
}

@Preview
@Composable
fun HomePreview() {
    HomeBodyContent(navController = rememberNavController(), viewModel = HomeScreenViewModel())
}
