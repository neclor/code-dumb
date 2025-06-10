package site.neclor

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Application.configureRouting() {
    routing {
        route("/bit") {
            post("/start") {
                call.respondText("")
                // Logic to start Bitcoin server
            }
            post("/stop") {
                call.respondText("")
                // Logic to stop Bitcoin server
            }
            get("/amount") {
                call.respondText("TODO: add amount")
            }
        }
    }
}
