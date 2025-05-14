package site.neclor.app

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform