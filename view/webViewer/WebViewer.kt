package com.whatalab.vipspad.view.webViewer

import android.graphics.Bitmap
import android.net.Uri
import android.util.Log
import android.view.ViewGroup
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.compose.runtime.Composable
import androidx.compose.ui.viewinterop.AndroidView
import androidx.navigation.NavController
import com.whatalab.vipspad.controllers.SharedPreferencesController
import com.whatalab.vipspad.navigation.AppScreens
import com.whatalab.vipspad.ui.theme.VipsPadTheme

@Composable
fun WebViewer(navController: NavController) {
    VipsPadTheme {
        WebViewerBodyContent(navController)
    }
}

@Composable
fun WebViewerBodyContent(navController: NavController) {
    // Declare a string that contains a url
    val discordUrl =
        "https://discord.com/api/oauth2/authorize?client_id=1035144996917092392&redirect_uri=https%3A%2F%2Fv1psend-production.up.railway.app%2Fapi%2Fv1%2Fauth%2Fdiscord%2Fredirect%2F&response_type=code&scope=identify%20email%20connections%20guilds%20guilds.members.read"
    val client = object : WebViewClient() {
        override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
            super.onPageStarted(view, url, favicon)
            url?.let { it ->
                if (it.startsWith("https://v1psend-production.up.railway.app/")) {
                    val uri = Uri.parse(it)
                    val tokenRegex =
                        ("^([a-zA-Z0-9_=]+)\\.([a-zA-Z0-9_=]+)\\.([a-zA-Z0-9_\\-\\+\\/=]*)").toRegex()
                    val code = uri.getQueryParameter("code")
                    Log.v("CODE", "Discord Code: $code")
                    view?.evaluateJavascript(
                        "(function() { return (document.getElementsByTagName('body')[0].innerHTML); })();"
                    ) { key ->
                        val text = key.removePrefix("\"").removeSuffix("\"")
                        if (text == "User must be holder") {
                            navController.navigate(AppScreens.LoginScreen.route + "/${true}")
                            {
                                popUpTo(0) {
                                    inclusive = true
                                }
                            }
                        } else if (tokenRegex.containsMatchIn(text)) {
                            SharedPreferencesController(navController.context)
                                .setStringPreference(SharedPreferencesController.API_KEY, text, "")
                            navController.navigate(AppScreens.HomeScreen.route) {
                                popUpTo(0) {
                                    inclusive = true
                                }
                            }
                        } else {
                            navController.navigate(AppScreens.LoginScreen.route + "/${false}")
                            {
                                popUpTo(0) {
                                    inclusive = true
                                }
                            }
                        }
                    };
                }
            }
        }
    }
    // Adding a WebView inside AndroidView
    // with layout as full screen
    AndroidView(factory = {
        WebView(it).apply {
            layoutParams = ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
            webViewClient = client
            loadUrl(discordUrl)
            settings.apply {
                javaScriptEnabled = true
                setSupportMultipleWindows(true)
                loadWithOverviewMode = true
                domStorageEnabled = true
                displayZoomControls = true
            }
        }
    }, update = {
        it.loadUrl(discordUrl)
    })
}
