package site.neclor

import org.bitcoinj.core.*
import org.bitcoinj.params.MainNetParams
import org.bitcoinj.wallet.DeterministicSeed
import java.security.SecureRandom


object BitcoinManager {
    private val params = MainNetParams.get()



    fun generateMnemonic(): List<String> {
        val seed = DeterministicSeed(SecureRandom(), 128, "")

    }




}



