package com.whatalab.vipspad.controllers

import android.content.Context
import android.content.SharedPreferences
import androidx.preference.PreferenceManager

class SharedPreferencesController (private val context: Context) {

    private var preferences: SharedPreferences? = PreferenceManager.getDefaultSharedPreferences(context)


    fun getStringPreference(key: String): String? {
        if(preferences == null){
            instantiatePreferences()
        }
        return preferences?.getString(key, null)
    }
    fun getIntPreference(key: String): Int? {
        return preferences?.getInt(key, 0)
    }

    fun getBooleanPreference(key: String): Boolean {
        if(preferences == null){
            instantiatePreferences()
        }
        return preferences!!.getBoolean(key, false)
    }

    fun setStringPreference(key: String, value: String?, default: String? = "") { // setPreference
        if(preferences == null){
            instantiatePreferences()
        }
        val editedPreference = preferences!!.edit()
        if (!default.isNullOrBlank())
            preferences!!.getString(key, default)

        if (!value.isNullOrBlank())
            editedPreference.putString(key, value)

        editedPreference.apply()
    }

    fun setIntPreference(key: String, value: Int?, default: Int? = 0) { // setPreference
        val editedPreference = preferences?.edit()
        if (default != null)
            preferences?.getInt(key, default)

        if (value != null)
            editedPreference?.putInt(key, value)

        editedPreference?.apply()
    }

    fun setBooleanPreference(
        key: String,
        value: Boolean,
        default: Boolean = false
    ) { // setPreference
        if(preferences == null){
            instantiatePreferences()
        }
        val editedPreference = preferences!!.edit()
        preferences!!.getBoolean(key, default)
        editedPreference.putBoolean(key, value)
        editedPreference.apply()
    }

    fun deletePreference(key: String) {
        preferences!!.edit().remove(key).apply()
    }

    fun checkPreference(key: String): Boolean {
        return !getStringPreference(key).isNullOrBlank()
    }

    private fun instantiatePreferences(){
        preferences =
            PreferenceManager.getDefaultSharedPreferences(context)
    }

    companion object {
        val API_KEY = "API_KEY"
    }

}