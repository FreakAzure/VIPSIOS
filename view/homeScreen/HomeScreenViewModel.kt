package com.whatalab.vipspad.view.homeScreen

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.whatalab.vipspad.controllers.retrofit.ApiCalls
import com.whatalab.vipspad.models.Categories
import com.whatalab.vipspad.models.Posts
import com.whatalab.vipspad.models.User
import com.whatalab.vipspad.util.Singleton

class HomeScreenViewModel : ViewModel() {

    private val _userData = MutableLiveData<User>()
    private val _categories = MutableLiveData<Categories>()
    private val _loading = MutableLiveData<Boolean>()

    val loading: LiveData<Boolean> = _loading
    val userData: LiveData<User> = _userData
    val categories: LiveData<Categories> = _categories


    fun retrieveUserData(context: Context) {
       _loading.value = true
        ApiCalls.getSelfAccount(context) {
            _loading.value = false
            Singleton.user.postValue(it)
        }
    }

    fun retrieveCategories(page: Int = 0, context: Context) {
        _loading.value = true
        ApiCalls.getCategories(context) {
            _loading.value = false
            _categories.postValue(it)
        }
    }

    fun finishLoading() {
        _loading.value = false
    }
}