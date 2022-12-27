package com.whatalab.vipspad.view.loginScreen

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.vectorResource
import androidx.compose.ui.unit.dp
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.navigation.NavController
import com.whatalab.vipspad.R
import com.whatalab.vipspad.navigation.AppScreens
import com.whatalab.vipspad.ui.composables.GifImage
import com.whatalab.vipspad.ui.composables.alertDialog
import com.whatalab.vipspad.ui.theme.GradientButton
import com.whatalab.vipspad.ui.theme.VipsPadTheme

@Composable
fun LoginScreen(navController: NavController, loginScreenViewModel: LoginScreenViewModel, showAlert: Boolean) {
    VipsPadTheme() {
        LoginBodyContent(navController, showAlert)
    }
}

@Composable
fun LoginBodyContent(navController: NavController, showAlert: Boolean) {
    val gradient =
        Brush.verticalGradient(listOf(Color(0xFFEFC047), Color(0xC9FFA100)))
    Surface(
        modifier = Modifier.fillMaxSize()
    ) {
        if(showAlert) {
            alertDialog(
                title = "Error de rol",
                subtitle = "Debes ser holder y tener el rol correspondiente para usar la app",
                onAcceptRequest = {},
                onDismissRequest = null
            )
        }
        GifImage(modifier = Modifier.fillMaxSize(), R.drawable.vips_login_background)
        ConstraintLayout(modifier = Modifier.fillMaxSize()) {
            val (gradientButton) = createRefs()
            GradientButton(
                onClick = {
                    navController.navigate(AppScreens.WebViewer.route)
                },
                text = "LOGIN WITH DISCORD",
                gradient = gradient,
                image = ImageVector.vectorResource(id = R.drawable.discord_round),
                modifier = Modifier
                    .fillMaxWidth()
                    .height(55.dp)
                    .padding(horizontal = 32.dp, vertical = 8.dp)
                    .constrainAs(gradientButton) {
                        bottom.linkTo(parent.bottom, margin = 64.dp)
                        start.linkTo(parent.start)
                        end.linkTo(parent.end)
                    },
            )
        }
    }
}