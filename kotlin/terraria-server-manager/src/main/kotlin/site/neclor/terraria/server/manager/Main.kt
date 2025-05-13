package site.neclor.terraria.server.manager

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import io.ktor.server.response.respondText
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import io.ktor.server.routing.route
import io.ktor.server.routing.routing

const val SERVER_PATH: String = "/home/neclor/game-servers/terraria/TerrariaServer.bin.x86_64"
const val CONFIG_PATH: String = "/home/neclor/game-servers/terraria/serverconfig.txt"

fun main() {
    embeddedServer(
        Netty,
        port = 8080,
        host = "0.0.0.0",
        module = Application::module
    ).start(wait = true)
}

fun Application.module() {
    routing {
        route("/terraria") {
            post("/start") {
                println("POST /terraria/start")
                val response: String = TerrariaServerManager.startServer(SERVER_PATH, CONFIG_PATH)
                call.respondText(response)
            }

            post("/stop") {
                println("POST /terraria/stop")
                val response: String = TerrariaServerManager.stopServer()
                call.respondText(response)
            }

            post("/save") {
                println("POST /terraria/save")
                val response: String = TerrariaServerManager.saveServer()
                call.respondText(response)
            }
        }
    }
}
