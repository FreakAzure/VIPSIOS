package com.whatalab.vipspad.view.postFeed

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.Surface
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.google.accompanist.pager.ExperimentalPagerApi
import com.whatalab.vipspad.models.Posts
import com.whatalab.vipspad.navigation.AppScreens
import com.whatalab.vipspad.ui.composables.TopBar
import com.whatalab.vipspad.ui.composables.recycledViews.PostItem
import com.whatalab.vipspad.util.Singleton
import java.net.URLEncoder
import java.nio.charset.StandardCharsets

@ExperimentalPagerApi
@Composable
fun PostFeed(navController: NavController, viewModel: PostFeedViewModel, category_id: Int) {
    val backgroundGradient =
        Brush.horizontalGradient(listOf(Color(0xFF000000), Color(0xFF090909), Color(0xFF212121)))
    val listState = rememberLazyListState()
    val posts: Posts? by viewModel.posts.observeAsState()
    viewModel.retrievePosts(0, navController.context, category_id)
    Surface(
        modifier = Modifier
            .fillMaxSize()
            .background(backgroundGradient),
        color = Color.Transparent
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .background(Color.Transparent),
            verticalArrangement = Arrangement.Top,
            horizontalAlignment = Alignment.CenterHorizontally

        ) {
            Row() {
                TopBar(screenName = "CALL TIMELINE", posts?.get(0)?.title ?: "", true, {
                    navController.popBackStack()
                })
            }
            Row() {
                posts?.let { posts ->
                    LazyColumn(
                        modifier = Modifier
                            .padding(horizontal = 16.dp)
                            .background(Color.Transparent),
                        state = listState
                    ) {
                        items(posts) { post ->
                            PostItem(post, navController.context, showDelete = (Singleton.user.value?.is_admin ?: false && posts.size > 1), onImageClicked = {
                                val encodedUrl = URLEncoder.encode(it, StandardCharsets.UTF_8.toString())
                                navController.navigate(AppScreens.PhotoViewer.route + "/${encodedUrl}")
                            }, onDeleteClicked = {
                                viewModel.deletePost(it, navController.context)
                            })
                        }
                    }
                }
            }
        }
    }
}