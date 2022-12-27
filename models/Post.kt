package com.whatalab.vipspad.models

import java.util.*

data class Post(
    val body: String,
    val category: Category,
    val category_id: Int,
    val created_at: Date,
    val creator: Creator,
    val creator_id: Int,
    val discord_url: String,
    val id: Int,
    val image2_url: String,
    val image_url: String,
    val market_url: String,
    val network: Network,
    val network_id: Int,
    val risk_id: Int,
    val risk_index: RiskIndex,
    val title: String
)
