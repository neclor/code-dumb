package com.example.testempty

import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview

@Preview(showBackground = true)
@Composable
fun Content(modifier: Modifier = Modifier) {

	LazyVerticalGrid(
		columns = GridCells.Fixed(7),
		modifier = modifier
	) {





	}

}



@Preview(showBackground = true)
@Composable
fun Square(modifier: Modifier = Modifier) {


	val b = remember{mutableStateOf(10)}

}

