package site.neclor.myapplication

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform