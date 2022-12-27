package com.whatalab.vipspad.util

import androidx.lifecycle.MutableLiveData
import com.whatalab.vipspad.models.User

object Singleton {
    var user: MutableLiveData<User?> = MutableLiveData()

}