package com.whatalab.vipspad.ui.composables.recycledViews

import android.content.Context
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.ClickableText
import androidx.compose.material.Card
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.TileMode
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import coil.compose.rememberAsyncImagePainter
import com.whatalab.vipspad.models.Category
import com.whatalab.vipspad.navigation.AppScreens
import com.whatalab.vipspad.ui.theme.OrangeMain


@Composable
fun CategoryItem(category: Category, context: Context, navController: NavController) {
    val backgroundGradient = Brush.horizontalGradient(
        listOf(Color(0x43212121), Color(0xFF000000)),
        tileMode = TileMode.Clamp
    )
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 10.dp)
            .background(backgroundGradient),
        backgroundColor = Color.Transparent
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier
                .padding(4.dp)
        ) {
            Image(
                painter = rememberAsyncImagePainter(category.image),
                contentDescription = null,
                contentScale = ContentScale.Crop,
                modifier = Modifier
                    .width(80.dp)
                    .height(80.dp)
                    .clip(RoundedCornerShape(10.dp))
            )
            Column(modifier = Modifier.padding(start = 16.dp), verticalArrangement = Arrangement.SpaceEvenly) {
                Row() {
                    Text(
                        category.name,
                        fontSize = 20.sp,
                        fontWeight = FontWeight.Black,
                        color = Color.White,
                        modifier = Modifier
                            .fillMaxWidth(0.7f)
                    )
                }
                Row(
                    horizontalArrangement = Arrangement.SpaceBetween, modifier = Modifier
                        .padding(top = 8.dp, bottom = 8.dp)
                ) {
                    Text(
                        text = "RED: ${category.network.name}",
                        fontSize = 12.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color.White,
                    )

                    Text(
                        text = "${category.risk_index.name} RISK CALL",
                        fontSize = 12.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color.Gray,
                        modifier = Modifier.padding(start = 32.dp)
                    )
                }
            }
            ClickableText(
                text = AnnotatedString("VER MÁS"),
                onClick = {
                    navController.navigate(AppScreens.PostsScreen.route + "/${category.id}")
                },
                style = TextStyle(
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Medium,
                    color = OrangeMain,
                ),
                modifier = Modifier.padding(start = 8.dp)
            )
        }
    }

}
