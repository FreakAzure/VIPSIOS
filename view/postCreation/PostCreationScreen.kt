package com.whatalab.vipspad.view.postCreation

import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import androidx.navigation.compose.rememberNavController
import com.whatalab.vipspad.ui.composables.LoadingScreen
import com.whatalab.vipspad.ui.composables.SpinnerCustom
import com.whatalab.vipspad.ui.composables.TopBar
import com.whatalab.vipspad.ui.theme.GradientButton
import com.whatalab.vipspad.ui.theme.OrangeMain

@Composable
fun PostCreationScreen(navController: NavController, viewModel: PostCreationViewModel) {
    val backgroundGradient =
        Brush.horizontalGradient(listOf(Color(0xFF000000), Color(0xFF090909), Color(0xFF212121)))
    val postGradient = Brush.verticalGradient(listOf(Color(0xFFFFCD82), Color(0xFF845C21)))
    var title by remember { mutableStateOf(TextFieldValue()) }
    var body by remember { mutableStateOf(TextFieldValue()) }
    var discordUrl by remember { mutableStateOf(TextFieldValue()) }
    var externalUrl by remember { mutableStateOf(TextFieldValue()) }
    val riskIndexes by viewModel.riskIndexes.observeAsState()
    val networks by viewModel.networks.observeAsState()
    val loading by viewModel.loading.observeAsState(false)
    val selectedFile1 by viewModel.selectedFile1.observeAsState()
    val selectedFile2 by viewModel.selectedFile2.observeAsState()
    val pickImageText = if (selectedFile1 != null) {
        "Imagen cargada"
    } else {
        "Cargar Imagen"
    }
    val pickImage2Text = if (selectedFile2!= null) {
        "Imagen cargada"
    } else {
        "Cargar Imagen"
    }
    val galleryLauncher1 = rememberLauncherForActivityResult(
        contract = ActivityResultContracts.GetContent(),
        onResult = {
            viewModel.endLoading()
            it?.let { uri ->
                viewModel.image1Selected(uri, navController.context)
            }
        })
    val scrollState = rememberScrollState()
    val galleryLauncher2 = rememberLauncherForActivityResult(
        contract = ActivityResultContracts.GetContent(),
        onResult = {
            viewModel.endLoading()
            it?.let { uri ->
                viewModel.image2Selected(uri, navController.context)
            }
        })
    riskIndexes?.let {
        viewModel.onRiskIndexChange(it[0])
    }
    networks?.let {
        viewModel.onNetworkChanged(it[0])
    }
    viewModel.retrieveNetworks(navController.context)
    viewModel.retrieveRiskIndexes(navController.context)
    Surface(
        modifier = Modifier
            .fillMaxSize()
            .background(backgroundGradient),
        color = Color.Transparent
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()

        ) {
            Column {
                TopBar(screenName = "CREATE A CALL", "", true, {navController.popBackStack()}) {
                    navController.popBackStack()
                }
            }
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier
                    .padding(horizontal = 40.dp)
                    .fillMaxHeight()
                    .verticalScroll(
                        state = scrollState
                    )
            ) {
                Text(
                    text = "FILL IN WITH THE CALL INFO",
                    modifier = Modifier.padding(top = 32.dp, bottom = 32.dp),
                    color = Color.White,
                    fontWeight = FontWeight.Medium
                )
                Row(
                    horizontalArrangement = Arrangement.SpaceBetween,
                    modifier = Modifier.fillMaxWidth()
                ) {
                    Button(
                        modifier = Modifier
                            .border(1.dp, OrangeMain)
                            .background(Color.Transparent),
                        onClick = { galleryLauncher1.launch("image/*") },
                        colors = ButtonDefaults.buttonColors(backgroundColor = Color.Transparent)
                    ) {
                        Text(
                            pickImageText, color = Color.White,
                            fontWeight = FontWeight.Medium
                        )
                    }
                    Button(
                        modifier = Modifier
                            .border(1.dp, OrangeMain)
                            .background(Color.Transparent),
                        onClick = { galleryLauncher2.launch("image/*") },
                        colors = ButtonDefaults.buttonColors(backgroundColor = Color.Transparent)
                    ) {
                        Text(
                            pickImage2Text, color = Color.White,
                            fontWeight = FontWeight.Medium
                        )
                    }
                }
                riskIndexes?.map { Pair(it.id, it.name) }?.let {
                    Text(
                        "Risk Index:",
                        color = OrangeMain,
                        modifier = Modifier
                            .align(Alignment.Start)
                            .padding(top = 16.dp)
                    )
                    SpinnerCustom(
                        list = it, preselected = it[0], onSelectionChanged = { pair ->
                            riskIndexes?.find { network -> network.id == pair.first }
                                ?.let { riskFound ->
                                    viewModel.onRiskIndexChange(riskFound)
                                }
                        }, modifier = Modifier
                            .padding(top = 8.dp)
                            .border(0.1.dp, OrangeMain)
                            .fillMaxWidth()
                    )
                }
                networks?.map { Pair(it.id, it.name) }?.let {
                    Text(
                        "Network:",
                        color = OrangeMain,
                        modifier = Modifier
                            .align(Alignment.Start)
                            .padding(top = 16.dp)
                    )
                    SpinnerCustom(
                        list = it, preselected = it[0], onSelectionChanged = { pair ->
                            networks?.find { network -> network.id == pair.first }
                                ?.let { networkFound ->
                                    viewModel.onNetworkChanged(networkFound)
                                }
                        }, modifier = Modifier
                            .padding(top = 8.dp)
                            .border(0.1.dp, OrangeMain)
                            .fillMaxWidth()
                    )
                }
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 24.dp)
                ) {
                    TextField(
                        value = title,
                        onValueChange = { title = it },
                        placeholder = { Text("Call title", color = Color.Gray) },
                        modifier = Modifier
                            .border(0.1.dp, OrangeMain)
                            .fillMaxWidth(),
                        keyboardOptions = KeyboardOptions(
                            capitalization = KeyboardCapitalization.Characters,
                            imeAction = ImeAction.Next
                        ),
                        textStyle = TextStyle(color = Color.White)
                    )
                }
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 24.dp)
                ) {
                    TextField(
                        value = body,
                        onValueChange = { body = it },
                        placeholder = { Text("Call body", color = Color.Gray) },
                        modifier = Modifier
                            .border(0.1.dp, OrangeMain)
                            .fillMaxWidth(),
                        textStyle = TextStyle(color = Color.White),
                        keyboardOptions = KeyboardOptions(imeAction = ImeAction.Next)
                    )
                }
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 24.dp)
                ) {
                    TextField(
                        value = discordUrl,
                        onValueChange = { discordUrl = it },
                        placeholder = { Text("Discord Url", color = Color.Gray) },
                        modifier = Modifier
                            .border(0.1.dp, OrangeMain)
                            .fillMaxWidth(),
                        textStyle = TextStyle(color = Color.White),
                        keyboardOptions = KeyboardOptions(imeAction = ImeAction.Next)
                    )
                }
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 24.dp)
                ) {
                    TextField(
                        value = externalUrl,
                        onValueChange = { externalUrl = it },
                        placeholder = { Text("External Url", color = Color.Gray) },
                        modifier = Modifier
                            .border(0.1.dp, OrangeMain)
                            .fillMaxWidth(),
                        textStyle = TextStyle(color = Color.White),
                        keyboardOptions = KeyboardOptions(imeAction = ImeAction.Next)
                    )
                }
                Column(
                    modifier = Modifier
                        .fillMaxHeight()
                        .padding(top = 42.dp),
                    verticalArrangement = Arrangement.Bottom
                ) {
                    GradientButton(
                        onClick = {
                            if (!loading) {
                                viewModel.createPost(
                                    navController.context,
                                    body.text,
                                    title.text,
                                    discord_url = discordUrl.text,
                                    market_url = externalUrl.text
                                ) {
                                    navController.popBackStack()
                                }
                            }

                        },
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(40.dp),
                        text = "POST A CALL",
                        textColor = Color(0xFFFFFFFF),
                        gradient = postGradient,
                        fontSize = 20.sp,
                        image = null,
                        fontWeight = FontWeight.Bold
                    )
                }
            }
        }
        if (loading) {
            LoadingScreen(modifier = Modifier.fillMaxSize())
        }
    }
}

@Preview
@Composable
private fun postPreview() {
    PostCreationScreen(
        navController = rememberNavController(),
        viewModel = PostCreationViewModel()
    )
}
