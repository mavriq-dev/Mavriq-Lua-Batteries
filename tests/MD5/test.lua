local mv = require("mavriq")

mv.msg("Start MD5 tests.\n")

md5 = require("md5.core")

cmessage = md5.crypt("Marviq is da shiznat", "Mavriq")
mv.printf("Encripted: %s ", cmessage)
dmessage = md5.decrypt(cmessage, "Mavriq")
mv.printf("\nDecripted: %s \n", dmessage)

mv.msg("End MD5 tests.\n\n")