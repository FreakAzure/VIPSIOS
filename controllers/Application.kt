package com.whatalab.vipspad.controllers

import android.R
import android.app.Application
import android.util.Log
import android.widget.Toast
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.FirebaseApp
import com.google.firebase.messaging.FirebaseMessaging
import com.google.firebase.messaging.FirebaseMessagingService
import com.whatalab.vipspad.controllers.retrofit.RetroConfig
import com.whatalab.vipspad.util.Constants


class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        RetroConfig.initService(Constants.API_URL)
        val firebase = MyFirebaseMessagingService()

        firebase.registerToTopic(this)
    }
}