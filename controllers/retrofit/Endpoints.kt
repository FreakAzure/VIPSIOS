package com.whatalab.vipspad.controllers.retrofit

import com.whatalab.vipspad.models.*
import okhttp3.MultipartBody
import retrofit2.Call
import retrofit2.http.*

interface Endpoints {
    @GET("auth/discord/me")
    fun getSelfData(
        @Header("Authorization") token: String
    ): Call<User>

    @GET("post/category")
    fun getPostFeed(
        @Header("Authorization") token: String,
        @Query("page") page: Int,
        @Query("category_id") category_id: Int
    ): Call<Posts>

    @GET("category/")
    fun getCategories(
        @Header("Authorization") token: String,
    ): Call<Categories>

    @GET("network/")
    fun getNetworks(
        @Header("Authorization") token: String,
    ): Call<List<Network>>

    @GET("risks/")
    fun getRisks(
        @Header("Authorization") token: String,
    ): Call<List<RiskIndex>>

    @Multipart
    @POST("post/create")
    fun createPost(
        @Header("Authorization") token: String,
        @Part file: List<MultipartBody.Part>,
        @Part title: MultipartBody.Part,
        @Part body: MultipartBody.Part,
        @Part risk_index: MultipartBody.Part,
        @Part discord_url: MultipartBody.Part,
        @Part market_url: MultipartBody.Part,
        @Part network_id: MultipartBody.Part,
    ): Call<String>

    @GET("post/delete")
    fun deletePost(
        @Header("Authorization") token: String,
        @Query("post_id") post_id: Int
    ): Call<String>
}