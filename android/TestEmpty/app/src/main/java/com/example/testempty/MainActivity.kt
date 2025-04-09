package com.example.testempty

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import com.example.testempty.ui.theme.Theme

class MainActivity : ComponentActivity() {
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		enableEdgeToEdge()
		setContent {
			Main()
		}
	}
}

@Preview(showBackground = true)
@Composable
fun Main() {
	Theme {
		val navController = rememberNavController()
		Scaffold(
			topBar = { MyTopBar() },
			bottomBar = { MyBottomBar(navController) }
		) { padding ->
			NavHost(
				navController = navController,
				startDestination = "home",
				modifier = Modifier.padding(padding)
			) {
				composable("home") { HomeScreen(navController) }
				composable("profile") { ProfileScreen(navController) }
			}
		}
	}
}
