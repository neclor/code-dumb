package site.neclor.terraria.server.manager

import java.io.OutputStream

object TerrariaServerManager {
    private var process: Process? = null

    fun startServer(serverPath: String, configFile: String) {
        if (process != null) {
            println("Server is already running")
            return
        }

        try {
            val command: String = serverPath + "-config" + configFile
            process = ProcessBuilder(command).inheritIO().start()
            println("Terraria server started")
        } catch (e: Exception) {
            println("Failed to start server: ${e.message}")
        }
    }

    fun stopServer() {
        saveServer()
        process?.destroy()
        process = null
    }

    fun saveServer() {
        // Обычно Terraria имеет команду для сохранения состояния сервера
        // В этом примере предполагаем, что сервер запущен в процессе

        try {
            val outputStream: OutputStream


            process?.outputStream?.write("save\n".toByteArray())
            println("Terraria server started")
        } catch (e: Exception) {
            println("Failed to start server: ${e.message}")
        }

        process?.outputStream?.write("save\n".toByteArray())
        return "Server saved."
    }
}