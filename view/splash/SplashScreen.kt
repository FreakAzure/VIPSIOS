package com.whatalab.vipspad.view.splash

import android.os.Handler
import android.os.Looper
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.size
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.navigation.NavController
import com.whatalab.vipspad.R
import com.whatalab.vipspad.controllers.SharedPreferencesController
import com.whatalab.vipspad.navigation.AppScreens
import com.whatalab.vipspad.ui.composables.GifImage
import java.util.*
import kotlin.concurrent.schedule

@Composable
fun SplashScreen(navController: NavController) {
    Surface {
        GifImage(resource = R.drawable.vips_animated, modifier = Modifier.fillMaxSize())
        ConstraintLayout(modifier = Modifier.fillMaxSize()) {
            val (vipsLogo, wellcomeText) = createRefs()
            val painter = painterResource(id = R.drawable.vips_logo)
            Image(
                painter = painter,
                contentDescription = "",
                contentScale = ContentScale.Fit,
                modifier = Modifier
                    .size(130.dp)
                    .constrainAs(vipsLogo) {
                        start.linkTo(parent.start)
                        end.linkTo(parent.end)
                        top.linkTo(parent.top, margin = 150.dp)
                        bottom.linkTo(parent.bottom)
                    }
            )
            Text(
                "HELLO V1P$",
                color = Color.White,
                fontSize = 40.sp,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.constrainAs(wellcomeText) {
                    start.linkTo(parent.start)
                    end.linkTo(parent.end)
                    top.linkTo(vipsLogo.bottom, margin = 10.dp)
                })
        }
    }

    Timer("Splash switch", false).schedule(2000) {
        Handler(Looper.getMainLooper()).post {
            if (SharedPreferencesController(navController.context).checkPreference(
                    SharedPreferencesController.API_KEY
                )
            ) {
                navController.popBackStack()
                navController.navigate(AppScreens.HomeScreen.route)
            } else {
                navController.popBackStack()
                navController.navigate(AppScreens.LoginScreen.route + "/${false}")
            }
        }
    }
}