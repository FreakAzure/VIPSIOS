package com.whatalab.vipspad.view.postCreation

import android.content.Context
import android.net.Uri
import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.whatalab.vipspad.controllers.retrofit.ApiCalls
import com.whatalab.vipspad.models.Network
import com.whatalab.vipspad.models.RiskIndex
import com.whatalab.vipspad.util.UploadStreamRequestBody
import okhttp3.MultipartBody

class PostCreationViewModel : ViewModel() {

    private val _riskIndexes = MutableLiveData<List<RiskIndex>>()
    private val _networks = MutableLiveData<List<Network>>()
    private val _selectedNetwork = MutableLiveData<Network>()
    private val _selectedRiskIndex = MutableLiveData<RiskIndex>()
    private val _selectedFile1 = MutableLiveData<MultipartBody.Part>()
    private val _selectedFile2 = MutableLiveData<MultipartBody.Part>()
    private val _loading = MutableLiveData<Boolean>()

    val riskIndexes: LiveData<List<RiskIndex>> = _riskIndexes
    val networks: LiveData<List<Network>> = _networks
    val selectedNetwork: LiveData<Network> = _selectedNetwork
    val selectedRiskIndex: LiveData<RiskIndex> = _selectedRiskIndex
    val selectedFile1: LiveData<MultipartBody.Part> = _selectedFile1
    val selectedFile2: LiveData<MultipartBody.Part> = _selectedFile2
    val loading: LiveData<Boolean> = _loading

    fun retrieveNetworks(context: Context) {
        ApiCalls.getNetworks(context) {
            _networks.value = it
        }
    }

    fun retrieveRiskIndexes(context: Context) {
        ApiCalls.getRisks(context) {
            _riskIndexes.value = it
        }
    }

    fun image2Selected(uri: Uri, context: Context) {
        val stream = context.contentResolver.openInputStream(uri) ?: return
        val request = UploadStreamRequestBody("image/*", stream, onUploadProgress = {
            Log.d("MyActivity", "On upload progress $it")
        })
        val filePart = MultipartBody.Part.createFormData(
            "file",
            "image2.jpg",
            request
        )
        _selectedFile2.value = filePart
    }

    fun image1Selected(uri: Uri, context: Context) {
        val stream = context.contentResolver.openInputStream(uri) ?: return
        val request = UploadStreamRequestBody("image/*", stream, onUploadProgress = {
            Log.d("MyActivity", "On upload progress $it")
        })
        val filePart = MultipartBody.Part.createFormData(
            "file",
            "image1.jpg",
            request
        )
        _selectedFile1.value = filePart
    }

    fun onNetworkChanged(network: Network) {
        _selectedNetwork.value = network
    }

    fun onRiskIndexChange(riskIndex: RiskIndex) {
        _selectedRiskIndex.value = riskIndex
    }

    fun createPost(
        context: Context,
        body: String,
        title: String,
        discord_url: String,
        market_url: String,
        callback: () -> Unit
    ) {
        _loading.value = true
        if (_selectedRiskIndex.value != null && _selectedNetwork.value != null && selectedFile1.value != null && selectedFile2.value != null) {
            ApiCalls.createPost(
                context,
                body_text = body,
                title = title,
                discord_url = discord_url,
                market_url = market_url,
                riskIndex = _selectedRiskIndex.value!!,
                network = selectedNetwork.value!!,
                files = listOf(
                    _selectedFile1.value!!, selectedFile2.value!!
                ),
                callback = callback
            )
        }
    }

    fun endLoading() {
        _loading.value = false
    }
}