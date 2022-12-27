package com.whatalab.vipspad.models

data class User(
    val created_at: String,
    val discord_refresh_token: String,
    val discord_token: String,
    val email: String,
    val id: Int,
    val is_admin: Boolean,
    val name: String,
    val photo_url: String
)