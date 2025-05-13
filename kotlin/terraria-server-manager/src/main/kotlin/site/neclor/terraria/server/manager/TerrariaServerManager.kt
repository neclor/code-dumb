package site.neclor.terraria.server.manager

import java.io.*
import java.util.concurrent.TimeUnit

object TerrariaServerManager {
    private var process: Process? = null
    private var outputStreamWriter: OutputStreamWriter? = null

    fun startServer(serverPath: String, configPath: String): String {
        if (process != null) {
            println("Terraria server is already running")
            return "Terraria server is already running"
        }

        try {
            process = ProcessBuilder(serverPath, "-config", configPath).start()
            if (process != null)
                outputStreamWriter = OutputStreamWriter(process?.outputStream)

            println("Terraria server started")
            return "Terraria server started"
        } catch (e: Exception) {
            println("Failed to start server: ${e.message}")
            return "Failed to start server: ${e.message}"
        }
    }

    fun stopServer(): String {
        if (process == null) {
            println("Terraria server is not working")
            return "Terraria server is not working"
        }

        saveServer()

        try {
            outputStreamWriter?.write("exit\r\n")
            outputStreamWriter?.flush()

            process?.waitFor(5, TimeUnit.SECONDS)

            process = null
            outputStreamWriter = null

            println("Terraria server stoped")
            return "Terraria server stoped"
        } catch (e: Exception) {
            println("Failed to stop server: ${e.message}")
            return "Failed to stop server: ${e.message}"
        }
    }

    fun saveServer(): String {
        if (process == null) {
            println("Terraria server is not working")
            return "Terraria server is not working"
        }

        try {
            outputStreamWriter?.write("save\r\n")
            outputStreamWriter?.flush()

            Thread.sleep(3000)

            println("Terraria server saved")
            return "Terraria server saved"
        } catch (e: Exception) {
            println("Failed to save server: ${e.message}")
            return "Failed to save server: ${e.message}"
        }
    }
}