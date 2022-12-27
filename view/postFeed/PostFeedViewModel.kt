package com.whatalab.vipspad.view.postFeed

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.whatalab.vipspad.controllers.retrofit.ApiCalls
import com.whatalab.vipspad.models.Categories
import com.whatalab.vipspad.models.Posts
import com.whatalab.vipspad.models.User
import com.whatalab.vipspad.util.Singleton

class PostFeedViewModel: ViewModel() {

    private val _posts = MutableLiveData<Posts>()
    val posts: LiveData<Posts> = _posts
    var categoryId = 0

    fun retrievePosts(page: Int = 0, context: Context, categoryId: Int) {
        this.categoryId = categoryId
        ApiCalls.getFeed(context, page, categoryId) {
            _posts.postValue(it)
        }
    }

    fun deletePost(postId: Int, context: Context) {
        ApiCalls.deletePosts(context, postId, onSuccess = {
            retrievePosts(0, context, categoryId)
        })
    }
}