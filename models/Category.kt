package com.whatalab.vipspad.models

data class Category(
    val id: Int,
    val image: String,
    val name: String,
    val risk_index: RiskIndex,
    val network: Network
)