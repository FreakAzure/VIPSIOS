package com.whatalab.vipspad.util

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.FileUtils
import android.provider.MediaStore
import okhttp3.MediaType
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.RequestBody
import okio.BufferedSink
import java.io.File
import java.io.IOException
import java.io.InputStream
import java.net.HttpURLConnection
import java.net.URL
import java.text.SimpleDateFormat
import java.util.*


fun getBitmapFromURL(src: URL): Bitmap? {
    return try {
        val url: URL = src
        val connection: HttpURLConnection = url.openConnection() as HttpURLConnection
        connection.doInput = true
        connection.connect()
        val input: InputStream = connection.inputStream
        BitmapFactory.decodeStream(input)
    } catch (e: IOException) {
        e.printStackTrace()
        null
    }
}

fun Date.dateToString(format: String): String {
    //simple date formatter
    val dateFormatter = SimpleDateFormat(format, Locale.getDefault())

    //return the formatted date string
    return dateFormatter.format(this)
}

class UploadStreamRequestBody(
    private val mediaType: String,
    private val inputStream: InputStream,
    private val onUploadProgress: (Int) -> Unit,
) : RequestBody() {

    override fun contentLength(): Long = inputStream.available().toLong()

    override fun contentType(): MediaType? = mediaType.toMediaTypeOrNull()

    override fun writeTo(sink: BufferedSink) {
        val contentLength = inputStream.available().toFloat()
        val buffer = ByteArray(DEFAULT_BUFFER_SIZE) // DEFAULT_BUFFER_SIZE constant from kotlin.io.ConstantsKt
        inputStream.use { inputStream ->
            var uploaded = 0
            var read: Int
            while (inputStream.read(buffer).also { read = it } != -1) { // Reads the stream until the content ends
                sink.write(buffer, 0, read)
                uploaded += read
                onUploadProgress((100*uploaded/contentLength).toInt())
            }
        }
    }
}