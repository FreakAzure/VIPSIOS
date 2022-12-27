package com.whatalab.vipspad.ui.composables

import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.TileMode
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight.Companion.Bold
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.constraintlayout.compose.ConstraintLayout
import coil.compose.rememberAsyncImagePainter
import com.whatalab.vipspad.R
import com.whatalab.vipspad.models.User
import com.whatalab.vipspad.ui.theme.GradientButton
import com.whatalab.vipspad.util.Singleton
import kotlin.math.log

@Composable
fun TopBar(
    screenName: String,
    topText: String,
    backButton: Boolean,
    backPressedCallback: () -> Unit,
    logoutPressedCallback: (() -> Unit)? =  null
) {
    val user: User? by Singleton.user.observeAsState()
    val gradient =
        Brush.verticalGradient(
            listOf(Color(0xFFFFCD82), Color(0xFF845C21), Color(0x00000000)),
            tileMode = TileMode.Decal
        )
    Surface(color = Color.Black) {
        ConstraintLayout(
            modifier = Modifier
                .fillMaxWidth()
                .height(150.dp)
                .padding(top = 10.dp, bottom = 10.dp)
        ) {
            val (userNameText, vipsImage, screenText, bottomText) = createRefs()
            if (backButton) {
                IconButton(onClick = { backPressedCallback() },
                    modifier = Modifier
                        .constrainAs(screenText) {
                            start.linkTo(parent.start)
                            top.linkTo(parent.top)
                            bottom.linkTo(bottomText.top)
                        }
                ) {
                    val painter = painterResource(id = R.drawable.ic_back_button)
                    Image(painter, "Back", modifier = Modifier.size(35.dp))
                }
            } else {
                Text(
                    text = topText,
                    fontSize = 24.sp,
                    color = Color.White,
                    fontWeight = Bold,
                    modifier = Modifier
                        .constrainAs(screenText) {
                            start.linkTo(parent.start)
                            top.linkTo(parent.top)
                            bottom.linkTo(bottomText.top)
                            end.linkTo(vipsImage.start)
                        },
                )
            }

            val painter = painterResource(id = R.drawable.vips_logo)
            Image(
                painter = painter,
                contentDescription = "",
                contentScale = ContentScale.Fit,
                modifier = Modifier
                    .size(40.dp)
                    .constrainAs(vipsImage) {
                        top.linkTo(parent.top)
                        start.linkTo(parent.start)
                        end.linkTo(parent.end)
                        bottom.linkTo(bottomText.top)
                    }
            )
            Column(
                modifier = Modifier
                    .padding(end = 32.dp)
                    .constrainAs(userNameText) {
                        end.linkTo(parent.end)
                        top.linkTo(parent.top)
                        bottom.linkTo(bottomText.top)
                    }
                    .fillMaxHeight(),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                Image(
                    painter = rememberAsyncImagePainter(user?.photo_url ?: ""),
                    contentDescription = null,
                    contentScale = ContentScale.Crop,
                    modifier = Modifier
                        .size(42.dp)
                        .clip(RoundedCornerShape(31.dp))
                        .clickable(enabled = true, onClick = {
                            //Logout message
                            logoutPressedCallback?.invoke()
                        })
                )

                Text(
                    text = user?.name ?: "",
                    fontSize = 16.sp,
                    color = Color.White,
                    fontWeight = Bold,
                )
            }
            GradientButton(
                onClick = {
                },
                modifier = Modifier
                    .fillMaxWidth()
                    .height(50.dp)
                    .padding(top = 10.dp)
                    .constrainAs(bottomText) {
                        start.linkTo(parent.start)
                        end.linkTo(parent.end)
                        bottom.linkTo(parent.bottom)
                    },
                text = screenName,
                textColor = Color(0xA3FFFFFF),
                gradient = gradient,
                fontSize = 20.sp,
                image = null,
                fontWeight = Bold
            )

        }
    }
}

@Preview
@Composable
fun TopBarPreview() {
    TopBar("Home", "Home", true, {})
}