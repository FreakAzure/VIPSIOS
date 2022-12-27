package com.whatalab.vipspad.ui.composables

import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

@Composable
fun alertDialog(title: String, subtitle: String, onDismissRequest: (() -> Unit)?, onAcceptRequest: (() -> Unit)?) {
    val openDialog = remember { mutableStateOf(true) }

    if (openDialog.value) {
        AlertDialog(
            onDismissRequest = {
                openDialog.value = false
                onDismissRequest?.invoke()
            },
            title = {
                Text(text = title)
            },
            text = {
                Column() {
                    Text(subtitle)
                }
            },
            buttons = {
                Column(
                    modifier = Modifier.padding(all = 8.dp),
                    verticalArrangement = Arrangement.Center
                ) {
                    if (onDismissRequest != null) {
                        Button(
                            modifier = Modifier.fillMaxWidth(),
                            onClick = {
                                onDismissRequest()
                                openDialog.value = false
                            }
                        ) {
                            Text("Cancel")
                        }
                    }
                    Button(
                        modifier = Modifier.fillMaxWidth(),
                        onClick = {
                            onAcceptRequest?.invoke()
                            openDialog.value = false
                        }
                    ) {
                        Text("Accept")
                    }

                }
            }
        )
    }
}

@Preview
@Composable
fun alertDialogPreview() {
    alertDialog(title = "Titulon", subtitle = "Subtitulon", {}, {})
}