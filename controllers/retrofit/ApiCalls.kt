package com.whatalab.vipspad.controllers.retrofit

import android.content.Context
import android.util.Log
import com.whatalab.vipspad.controllers.SharedPreferencesController
import com.whatalab.vipspad.controllers.SharedPreferencesController.Companion.API_KEY
import com.whatalab.vipspad.models.*
import okhttp3.MediaType
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.RequestBody
import okhttp3.RequestBody.Companion.asRequestBody
import okhttp3.RequestBody.Companion.create
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.io.File


object ApiCalls {

    fun getSelfAccount(context: Context, callback: (User) -> Unit) {
        val token = SharedPreferencesController(context)
            .getStringPreference(com.whatalab.vipspad.controllers.SharedPreferencesController.API_KEY)
        if (token != null) {
            val call = RetroConfig.service.getSelfData(
                token
            )
            call.enqueue(object : Callback<User> {
                override fun onResponse(call: Call<User>, response: Response<User>) {
                    val body = response.body()
                    if (response.code() == 200 && body != null) {
                        return callback(body)
                    } else {
                        Log.e("RETROFIT", "GET SELF ACCOUNT ERROR: $body")

                    }
                }

                override fun onFailure(call: Call<User>, t: Throwable) {
                    Log.e("RETROFIT", "GET SELF ACCOUNT ERROR: " + t.localizedMessage)
                }
            })
        } else {
            // Logout
        }
    }

    fun getFeed(context: Context, page: Int, categoryId: Int, callback: (Posts) -> Unit) {
        val token = SharedPreferencesController(context)
            .getStringPreference(com.whatalab.vipspad.controllers.SharedPreferencesController.API_KEY)
        if (token != null) {
            val call = RetroConfig.service.getPostFeed(
                token,
                page,
                categoryId
            )
            call.enqueue(object : Callback<Posts> {
                override fun onResponse(call: Call<Posts>, response: Response<Posts>) {
                    val body = response.body()
                    if (response.code() == 200 && body != null) {
                        return callback(body)
                    } else {
                        Log.e("RETROFIT", "GET FEED ACCOUNT ERROR: $body")

                    }
                }

                override fun onFailure(call: Call<Posts>, t: Throwable) {
                    Log.e("RETROFIT", "GET FEED ACCOUNT ERROR: " + t.localizedMessage)
                }
            })
        } else {
            // Todo: Logout
        }
    }

    fun getCategories(context: Context, callback: (Categories) -> Unit) {
        val token = SharedPreferencesController(context)
            .getStringPreference(SharedPreferencesController.API_KEY)
        if (token != null) {
            val call = RetroConfig.service.getCategories(token)
            call.enqueue(object : Callback<Categories> {
                override fun onResponse(call: Call<Categories>, response: Response<Categories>) {
                    val body = response.body()
                    if (body != null) {
                        return callback(body)
                    }
                }

                override fun onFailure(call: Call<Categories>, t: Throwable) {
                    Log.e("RETROFIT", "GET CATEGORIES ERROR: " + t.localizedMessage)
                }

            })
        }
    }

    fun getNetworks(context: Context, callback: (List<Network>) -> Unit) {
        val token =
            SharedPreferencesController(context).getStringPreference(SharedPreferencesController.API_KEY)
        if (token != null) {
            val call = RetroConfig.service.getNetworks(token)
            call.enqueue(object : Callback<List<Network>> {
                override fun onResponse(
                    call: Call<List<Network>>,
                    response: Response<List<Network>>
                ) {
                    val body = response.body()
                    if (body != null) {
                        callback(body)
                    }
                }

                override fun onFailure(call: Call<List<Network>>, t: Throwable) {
                    Log.e("RETROFIT", "GET NETWORKS ERROR: " + t.localizedMessage)
                }

            })
        }
    }

    fun getRisks(context: Context, callback: (List<RiskIndex>) -> Unit) {
        val token =
            SharedPreferencesController(context).getStringPreference(SharedPreferencesController.API_KEY)
        if (token != null) {
            val call = RetroConfig.service.getRisks(token)
            call.enqueue(object : Callback<List<RiskIndex>> {
                override fun onResponse(
                    call: Call<List<RiskIndex>>,
                    response: Response<List<RiskIndex>>
                ) {
                    val body = response.body()
                    if (body != null) {
                        callback(body)
                    }
                }

                override fun onFailure(call: Call<List<RiskIndex>>, t: Throwable) {
                    Log.e("RETROFIT", "GET NETWORKS ERROR: " + t.localizedMessage)
                }

            })
        }
    }

    fun createPost(
        context: Context,
        title: String,
        body_text: String,
        files: List<MultipartBody.Part>,
        riskIndex: RiskIndex,
        network: Network,
        discord_url: String,
        market_url: String,
        callback: () -> Unit
    ) {

        val token =
            SharedPreferencesController(context).getStringPreference(SharedPreferencesController.API_KEY)
        if (token != null) {
            val call = RetroConfig.service.createPost(
                token,
                body = MultipartBody.Part.createFormData(name = "body", body_text),
                title = MultipartBody.Part.createFormData(name = "title", title),
                risk_index = MultipartBody.Part.createFormData(name = "risk_index", riskIndex.id.toString()),
                network_id = MultipartBody.Part.createFormData(name = "network_id", network.id.toString()),
                discord_url = MultipartBody.Part.createFormData(name = "discord_url", discord_url),
                market_url = MultipartBody.Part.createFormData(name = "market_url", market_url),
                file = files
            )
            call.enqueue(object : Callback<String> {
                override fun onResponse(call: Call<String>, response: Response<String>) {
                    if(response.code() == 200)  {
                        callback()
                    }
                }

                override fun onFailure(call: Call<String>, t: Throwable) {
                    Log.e("RETROFIT", "POST ERROR: " + t.localizedMessage)
                }

            })
        }
    }

    fun deletePosts(context: Context, postId: Int, onSuccess: () -> Unit) {
        val token =
            SharedPreferencesController(context).getStringPreference(API_KEY)
        token?.let { apiToken ->
        val call = RetroConfig.service.deletePost(apiToken, postId)
            call.enqueue(object : Callback<String> {
                override fun onResponse(call: Call<String>, response: Response<String>) {
                    onSuccess()
                }

                override fun onFailure(call: Call<String>, t: Throwable) {
                    t.localizedMessage?.let { Log.e("RETROFIT", it) }
                }
            })
        }
    }
}