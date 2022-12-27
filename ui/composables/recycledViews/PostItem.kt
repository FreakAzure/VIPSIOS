package com.whatalab.vipspad.ui.composables.recycledViews

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.ClickableText
import androidx.compose.material.Card
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.font.FontWeight.Companion.Medium
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.content.res.ResourcesCompat
import androidx.core.graphics.drawable.toBitmap
import coil.compose.rememberAsyncImagePainter
import com.google.accompanist.pager.ExperimentalPagerApi
import com.google.accompanist.pager.HorizontalPager
import com.google.accompanist.pager.rememberPagerState
import com.whatalab.vipspad.R
import com.whatalab.vipspad.models.Post
import com.whatalab.vipspad.ui.composables.DotsIndicator
import com.whatalab.vipspad.ui.composables.GifImage
import com.whatalab.vipspad.ui.theme.OrangeMain
import com.whatalab.vipspad.util.dateToString
import java.net.MalformedURLException
import java.net.URL


@ExperimentalPagerApi
@Composable
fun PostItem(
    post: Post,
    context: Context,
    showDelete: Boolean = false,
    onDeleteClicked: (postId: Int) -> Unit,
    onImageClicked: (image_url: String) -> Unit
) {
    val marketUrl = try {
        URL(post.market_url)
    } catch (error: MalformedURLException) {
        error.printStackTrace()
        null
    }
    val marketBitmap = if (marketUrl != null) {
        //getBitmapFromURL(marketUrl)
        ResourcesCompat.getDrawable(context.resources, R.drawable.ic_explorer, null)?.toBitmap()
    } else {
        ResourcesCompat.getDrawable(context.resources, R.drawable.ic_explorer, null)?.toBitmap()
    }
    val discord_round =
        ResourcesCompat.getDrawable(context.resources, R.drawable.discord_round, null)
            ?.toBitmap()?.asImageBitmap()
    val slideImage = remember { mutableStateOf(post.image_url) }
    val imagePagerState = rememberPagerState()
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .wrapContentHeight()
            .padding(vertical = 10.dp),
        backgroundColor = Color.Transparent,
        border = BorderStroke(2.dp, OrangeMain)
    ) {
        Column(modifier = Modifier.padding(24.dp)) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(
                    text = post.title,
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Black,
                    color = Color.White,
                    modifier = Modifier.fillMaxWidth(0.5f)
                )
                Column(horizontalAlignment = Alignment.End, modifier = Modifier.fillMaxWidth()) {
                    Text(
                        text = post.created_at.dateToString("MMM d, yyyy"),
                        textAlign = TextAlign.End,
                        fontSize = 12.sp,
                        color = Color.White
                    )
                    Text(
                        text = "Call Hoster: @${post.creator.name}",
                        textAlign = TextAlign.End,
                        fontSize = 16.sp,
                        color = Color.White
                    )
                    if (showDelete) {
                        GifImage(
                            resource = R.drawable.ic_delete,
                            modifier = Modifier
                                .size(width = 20.dp, height = 20.dp)
                                .clickable(enabled = true, onClick = {
                                    onDeleteClicked(post.id)
                                })
                        )
                    }
                }
            }
            Row(verticalAlignment = Alignment.CenterVertically) {
                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                    HorizontalPager(count = 2, state = imagePagerState) { page ->
                        when (page) {
                            0 -> {
                                slideImage.value = post.image_url
                                Image(
                                    painter = rememberAsyncImagePainter(post.image_url),
                                    contentDescription = null,
                                    contentScale = ContentScale.Crop,
                                    modifier = Modifier
                                        .fillMaxWidth()
                                        .height(200.dp)
                                        .padding(bottom = 24.dp, top = 8.dp)
                                        .clip(RoundedCornerShape(10.dp))
                                        .clickable {
                                            onImageClicked(post.image_url)
                                        }
                                )
                            }

                            1 -> {
                                slideImage.value = post.image2_url
                                Image(
                                    painter = rememberAsyncImagePainter(post.image2_url),
                                    contentDescription = null,
                                    contentScale = ContentScale.Crop,
                                    modifier = Modifier
                                        .fillMaxWidth()
                                        .height(200.dp)
                                        .padding(bottom = 24.dp, top = 8.dp)
                                        .clip(RoundedCornerShape(10.dp))
                                        .clickable {
                                            onImageClicked(post.image2_url)
                                        }
                                )
                            }
                        }
                    }

                    DotsIndicator(
                        totalDots = 2,
                        selectedIndex = imagePagerState.currentPage,
                        selectedColor = OrangeMain,
                        unSelectedColor = Color.Gray
                    )
                }
            }
            // Here goes the pager
            Text(
                text = "Comment:", fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
                color = Color.White,
                modifier = Modifier.padding(start = 4.dp, bottom = 4.dp)
            )
            Text(
                text = post.body,
                fontSize = 14.sp,
                color = Color.White,
                modifier = Modifier.fillMaxWidth()
            )

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Text(
                    text = "RED: ${post.network.name}",
                    fontSize = 12.sp,
                    fontWeight = Medium,
                    color = Color.White,
                    modifier = Modifier.padding(top = 8.dp)
                )
                Row(verticalAlignment = Alignment.CenterVertically) {
                    ClickableText(
                        onClick = {
                            marketUrl?.let {
                                val browserIntent =
                                    Intent(Intent.ACTION_VIEW, Uri.parse(it.toString()))
                                context.startActivity(browserIntent)
                            }
                        },
                        text = buildAnnotatedString {
                            append("ABRIR EN")
                        },
                        style = TextStyle(
                            fontSize = 12.sp,
                            fontWeight = Medium,
                            color = Color.White,
                        ),
                        modifier = Modifier.padding(top = 8.dp),
                    )
                    marketBitmap?.let {
                        Image(
                            bitmap = marketBitmap.asImageBitmap(),
                            contentDescription = "External Page Icon",
                            modifier = Modifier
                                .size(20.dp)
                                .padding(top = 8.dp, start = 4.dp)
                        )
                    }
                }
                Row() {
                    ClickableText(
                        text = AnnotatedString("ABRIR EN DISCORD"),
                        style = TextStyle(
                            fontSize = 12.sp,
                            fontWeight = Medium,
                            color = Color.White,
                        ),
                        modifier = Modifier.padding(top = 8.dp),
                        onClick = {
                            post.discord_url.let {
                                val browserIntent =
                                    Intent(Intent.ACTION_VIEW, Uri.parse(it))
                                context.startActivity(browserIntent)
                            }
                        }
                    )
                    discord_round?.let { image ->
                        Image(
                            bitmap = image,
                            contentDescription = "External Page Icon",
                            modifier = Modifier
                                .size(20.dp)
                                .padding(top = 8.dp, start = 4.dp)
                        )
                    }

                }

            }
        }
    }
}
