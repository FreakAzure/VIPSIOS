package com.whatalab.vipspad.ui.composables

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.ArrowDropDown
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.runtime.getValue
import androidx.compose.runtime.setValue
import androidx.compose.ui.tooling.preview.Preview

@Composable
fun SpinnerCustom(
    list: List<Pair<Int, String>>,
    preselected: Pair<Int, String>,
    onSelectionChanged: (myData: Pair<Int, String>) -> Unit,
    modifier: Modifier = Modifier
) {

    var selected by remember { mutableStateOf(preselected) }
    var expanded by remember { mutableStateOf(false) }

    Card(
        modifier = modifier.clickable {
            expanded = !expanded
        }
    ) {
        Row(
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.Top,
        ) {

            Text(
                text = selected.second,
                modifier = Modifier
                    .weight(1f)
                    .padding(horizontal = 16.dp, vertical = 8.dp)
            )
            Icon(Icons.Outlined.ArrowDropDown, null, modifier = Modifier.padding(8.dp))

            DropdownMenu(
                expanded = expanded,
                onDismissRequest = { expanded = false },
                modifier = Modifier.fillMaxWidth()   // delete this modifier and use .wrapContentWidth() if you would like to wrap the dropdown menu around the content
            ) {
                list.forEach { listEntry ->

                    DropdownMenuItem(
                        onClick = {
                            selected = listEntry
                            expanded = false
                            onSelectionChanged(selected)
                        },
                        content = {
                            Text(
                                text = listEntry.second,
                                modifier = Modifier
                                    //.wrapContentWidth()  //optional instad of fillMaxWidth
                                    .fillMaxWidth()
                            )
                        },
                    )
                }
            }

        }
    }
}


@Preview(showBackground = true)
@Composable
fun SpinnerSample_Preview() {
    MaterialTheme {
        val myData = listOf<Pair<Int, String>>(Pair(0, "Apples"), Pair(1, "Bananas"), Pair(2, "Kiwis"))

        SpinnerCustom(
            myData,
            preselected = myData.first(),
            onSelectionChanged = { },
            modifier = Modifier.fillMaxWidth()
        )
    }
}
