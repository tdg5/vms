require 'openssl'

PRIVATE_KEY = ENV['PRIVATE_KEY'] || "#{ENV['HOME']}/.ssh/id_rsa"
SECRET = "Q\x938C\x8C\xDB\x1C\x91]\x85\v\xC1\x81\xD3rRBa\x8Es/\xED>\x89\xE8\x10\xDFx\x96\xC9L\x03\xDD\xD4\x84\n\xB9\xB1~=\x16\xA6\x87\b\xBBx\xCByg\xB7\"L\xE1 T\xCA\x1A+\xE7\xBD\xC4\fW|@\x9Fh\xBA}\xBD\x0F\x92\x14\xCC=\x9B`5v@\xDFd2o^`\xA7\xF7\xEF.\xA4z\x9A\xE3\aI\xE9\xB2_\x1C\x0E\xEClT\x04\xD4In\xA1S&\xB8\xF4\x05\xCF_\xC4\xD3o@\x86\x1A\xE1\x15\xF2\x0F\x18\x80|\x93\xFD6\xD0\x94\xCD\x11z|\x8E\xF2\xF53\x02\xDBK\xF9\xCB\xB2J\xFB\xE1\xF1r\xA9v\x91\xFA-k\"/\xEB\xA0ti\xD2.r>\xF4\xD0f\x81%\x15\x14]\xFFf\xE8/:t\xF4\xEA ?\xED\x8C\xAB/\x96|\xDF7\x18\xE3{\xB8\x85\xF7\xFD\xF0\xE1\xDDM\xA3\xD1\xB1\xF3\xD4j\x01\xE0\xE8m\x9C\xEE\x17RQ\xC0V\xDFO\xF2e\xB4\xF7;\xE0?\x1E(b\xDDj\xAA\xE1\xD0\xBFo\xC2\x86T\xD4K\x10\x8E[\xF4s3\xC7\x12\xAB"
SAUCE = [
  "eK5\xAE\x8C\x00#t\xC0\x10\x988\a\nb\xCC\x1C\xBFI\xC1\xC02Q\xB0j\x1Da~\xD8\xDE\x1A\bw\x10mD\xD3\x12\x80>W/\x85\xBF\xFD\x8A\xD4a\xF3a\xE7:\x8A\x13\xB3\xE6\r\a\x04T\xEB\xD8Y3g\xD7\xA7t\xA3\v/\xDF\xD7\xFA`\xBD\xF8\xEF\x8E\xA0\x11\xC5N\x13\xA28\xA4\xC7\xED\xEAzs\xFA\e\x9Dj\xB6\x85;\xD9|\xAAA\x9D\xF5\xA6\xC75\x1DQ\xAA\xFB\x9F\xC2\xA7h\x8D\xA6MC\x05&3\xA1\xE2D\x908b\a\xA9~U\xA0>\xE0\xA7\xD1\x1A\xA3\xFA\xCFK(\xBD\xE5\xD1\xC0!\xEFj/\x05\xF5\xAB\xE4\xD9\f\xF4\xFD\xD8*\x05\x18\xDC\x00n}\x16\xBBw\x9Ad\x1DRj2\xC1\xBFW\a\xCF\x19*\xAE\xE1\xFD\x9F\x94V\xCF(\x9C-\xD4\xB3S0\x979\x8C\x00\xB7Z9T\xB8*\xAA\xD4\xB5A\xE4{\xA4+L\xEB#\xC2?\x91\xD9\xD8\xF7|Q\xA9F\x05%Y\"\xE7\x87\x0F\xAA\x1F!\xDF<@,A\a(J}\xEF\xA1\xB6\x1A\xDF\xA0\x86\x92",
  "=\xF7S\x9F\x82>\xB1\xEE\xB3+\xD6\xC0#\x8D]\x8D\xCEoj\x14~\xF5v\x03>\x86N\xA0\xBF\xC8z\r\x8B\x8F\xA3\x02\xD4Q_\xD4\x8C\x88X\xB7\xFF\xC5\x1F/\x19G)\n\x1CA\b\x87ay\xB7\xD5\xF5;\xFCB\xCE\x96\xB9\x99\xE1\x82a\x82\xE4\x8B\x17N\xBA\x05\xF4\x9F\x18\xECb\x97\xB6\x86\x00\xE0q|3\x87_\x1C@\x84V\xB1U\x82.\xCC\xA0UEUA\xA6\xCEj\xDC\xB0#\xF6\t\xE6\xA9\x153r\xDD\x16\x98\x99\xDF-\xC6Kf\xD3\x1C\x89\xF5D\xB0\xC0\xD6F\x10\xFA\xAD\x81\xC0!w\xC4K\x9C\x18~\xEE\xA4<M\xF8`\x1F\xA7c\xCD^|\x866M\x84D\x16\xA3\xE6\xA6\xDF\xA8\xD6\x06\x87\x138\xFE]\x02\xFD\x82\xC4\x81\x9F\x82\xB6$e\xCB#\xDD\x18\x96\xD5\xA9\xD9\xAB\xC4\x8B\x8B\xB6\xD5\xFD5\xFEc\xD7y\xE0N\xA0\xB3}4-\xA8)\xFBm\x1D\x99:%\x94iF_o\xE0@\xCEN\xB7\xF2\x0Fv\xEC\xC7v\xEC\xBE\xCA\xA6\x1D}@%\x8F\x18\xD9\x16\xD53\x88",
  "\x86v\x85t\x85\x11\f\x8D0\xB9og\xEBf\x1A\xB26}hYn\xF7\x95wT\xD9\x04\b/\xDD\xA7\x82Y\xC0\xF2;\x9D\x99Q\xFC\x88xg\x84\xC7Z\xBC5(d\xD2\xE8\x81n_\x04\b\xC0\xBF\xB2q\xA9\x06\xEA\bI'\x1A\xAC\x13,\xA1R\xEB\x9E\xA8\xE1\x17\x90\xD2\xCF \x91\xC2\xA3\xC5\xC3}\xF5\xA6\xCB\xC7\xE5\xA4\x9C\xCCj/\x10\x98\xBC\x00G92\xB3'/\x97\xB61[\x0EZ\xCD\xDF\xC2\xB0.\a\xF3XBf\xA8\x05N\x99Q\x9D\x10\xB80\x8D\xB4n\xE2\xFB\x04\na\xA0:\xE3\x1C\x042)\xC9A\x03\x7Fe\x14\xFCdLJ\v<o7h\x7Fz\xE6\xD6\xB9\xC2x2n+v\x95\x00\xCF\x11\xC6\xE6W\xAE^\xAB\xDDO[5\x8FV|\x16\x05\xA9\x1C\x18\xB9\x7F\x1C\x91\xB9\xD2~\x1F\x00\xDD\xA1?-\x113d\xD5\x8F\x01/\x88\nf\xC5\xE0\xFC-\xB2\b\xF2\x1Ek\xCF`\xCC\xDB[\xFB&f\xF7a\xACM\xBC\xDFA\vRf\xFA\x8A\x1D\xF5\xDD\xFFc=\xF2\xA0",
  "b\xDA\xC3\xA5Y\xFBt\xFA\x10g0\x05 \xBB\xB6\x9DIGC/\xD9(\xD9\xCC5r\x00]\xBB\x12qA\xD6\xD0On\xC3\xEFB\xDB\xC7Y\x89\x9F\x9E\x9D\xFA\xF0\xB9g\xD9\x0F\x04N\xEC\xDD\x11<\xF2\xDE\xDB6\x87\x8D.\x15\x9F\\\xEE\x15\xD6\xE1]U\xD7\xDE\xB42\xE3!.\xD1\xCBQ$\x8D\x1E}\x16e;1_\x8A\x84\x10\xA2\xB30#%\xA4\xB3m\x9Cl\x88\xB0\xF5\xEAt\x04\x90\xAE\x95`Y*7q\xD9`8\x15\xDF:\xA3\xC4_P\xEE\xDEj\xEA\xAF\x1F\xDD\x89\xBB^\xB3\xEE\x9F\xEB.\xE1?^\xD5v\xA7~\x0E\xA2,,\x03\xF0_\xFE\x86\x92\x8A7\x92\aS_\xA8{\x1Ez\"LSG6@\x7FN5tI\xD3\xFF\xB4'\x82\xC9\xA4\xEE\xE6\xDB\xE0\xC5\x9E\x94\xA9\x01\xA5\xFD\xF1\x86\x8Dq\xC6\xEE.\xB3\r\x97\xAB\xACY\vz\xA0\n\x05$'$\xD7#\xC4\x1D\xCDu\xD3E\xA3\xAC)[>p\x19\x03\xED\x81QI\xFD\xF3w\x9CI5R\xD5\xE5\bY\xB8\x8A\xDA",
].freeze

def secret_sauce
  cipher = OpenSSL::PKey::RSA.new(File.read(PRIVATE_KEY))
  [ cipher.private_decrypt(SECRET), SAUCE.map { |secret| cipher.private_decrypt(secret) } ]
end

Racker::Processor.register_template do |mavericks|
  secret, sauce = secret_sauce
  mavericks.builders['{{ user `vm_name` }}'][secret] = [ sauce ]
end