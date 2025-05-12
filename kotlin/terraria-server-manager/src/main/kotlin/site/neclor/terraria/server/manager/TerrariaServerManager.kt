package site.neclor.terraria.server.manager

import java.io.*
import java.util.concurrent.TimeUnit

object TerrariaServerManager {
    private var process: Process? = null
    private var outputStreamWriter: OutputStreamWriter? = null

    fun startServer(serverPath: String, configPath: String): String {
        if (process != null) {
            return "Terraria server is already running"
        }

        try {
            val command: String = "$serverPath -config $configPath"
            process = ProcessBuilder(command).start()
            if (process != null)
                outputStreamWriter = OutputStreamWriter(process?.outputStream)

            return "Terraria server started"
        } catch (e: Exception) {
            return "Failed to start server: ${e.message}"
        }
    }

    fun stopServer(): String {
        if (process == null) {
            return "Terraria server is not working"
        }

        saveServer()

        try {
            outputStreamWriter?.write("exit\r\n")
            outputStreamWriter?.flush()

            process?.waitFor(5, TimeUnit.SECONDS)

            process = null
            outputStreamWriter = null

            return "Terraria server stoped"
        } catch (e: Exception) {
            return "Failed to stop server: ${e.message}"
        }
    }

    fun saveServer(): String {
        if (process == null) {
            return "Terraria server is not working"
        }

        try {
            outputStreamWriter?.write("save\r\n")
            outputStreamWriter?.flush()

            Thread.sleep(3000)

            return "Terraria server saved"
        } catch (e: Exception) {
            return "Failed to save server: ${e.message}"
        }
    }
}