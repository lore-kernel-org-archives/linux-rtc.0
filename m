Return-Path: <rtc-linux+bncBDQNTZVC44FBBZMGQG4AKGQEQCFY2NI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailhost.home (mailhost.ilcode.fr. [2a01:240:fe87:2::2])
        by gmr-mx.google.com with ESMTPS id c7si103992wmf.2.2016.04.02.15.10.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 15:10:45 -0700 (PDT)
Date: Sun, 3 Apr 2016 00:10:37 +0200
From: Nicolas Boullis <nboullis@debian.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 1/2] rtc: ds1307: fix ds1307_native_smbus_read_block_data
 function
Message-ID: <20160402221037.GA3600@haddock.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

The i2c_smbus_read_i2c_block_data function returns 0 on success, not the 
number of bytes written.

Hence, when there are 32 bytes or less to send, the 
ds1307_native_smbus_write_block_data function returns 0 on success, 
while it returns the number of bytes when there are more than 32.

The ds1307_write_block_data always returns the number of bytes on 
success.

Signed-off-by: Nicolas Boullis <nboullis@debian.org>

---

Should the behavior of the i2c_smbus_write_i2c_block_data function be 
changed to be consistant with that of the i2c_smbus_read_i2c_block_data 
function?

It might be more consistent, but the impact is certainly much larger, 
and that's far beyond the scope of the RTC subsystem.

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index b2156ee..19e7353 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -275,9 +275,13 @@ static s32 ds1307_native_smbus_write_block_data(const struct i2c_client *client,
 {
 	u8 suboffset = 0;
 
-	if (length <= I2C_SMBUS_BLOCK_MAX)
-		return i2c_smbus_write_i2c_block_data(client,
+	if (length <= I2C_SMBUS_BLOCK_MAX) {
+		s32 retval = i2c_smbus_write_i2c_block_data(client,
 					command, length, values);
+		if (retval < 0)
+			return retval;
+		return length;
+	}
 
 	while (suboffset < length) {
 		s32 retval = i2c_smbus_write_i2c_block_data(client,

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJXAENYAAoJEHnxj5DMK4Q12W8QALmUsbyosjnqoq/qRphx412s
3IVuSdiL3ujvRusFU96F4cXW0RoTyWTUt/Fhcwk5HqmKTj5FrpKkuV7wOjfIrg3O
OML2IH08J2HjYHmo12xHv1QeZ5IfOHlQkLMs/gnkaOZpyynOP0Odzd+kh3qQmd2T
YLLc21FFRinOZBVuavbTGjDAJ/lX0eepeQ4RsdgJi2nP4/Gmry975oH0fpcPcnrm
hUhZ9uXInujTtZkdRH6Dsy9481/pUqCSA463fyHgOE1WCQkWHK66O1Jijd87hUZI
k9vmhj/bvgXHFTLyoyHizBX5UE3c7Lm7foQtP3PxKQrPYjc5w1O3A4IUsitpQHa2
OlIH0oQ8ZX+93GRT8qAnnvOp3CqBWbE9cumSYofhbr/KH8yYwCQPSje1XTjpM/GR
VfohhT9hgamFHRv9zzHe1NSjEhH1zIC9E19u1iJ5GdWMcxNVRI28vZo4iBtZ3AqD
QwG6cZxrubH3BKwMpo6yfps659p2x55l/aaCRdUZxvYr+sVRDVoEbEIIWzBeW1pw
2vSLLenLQMK9JtAuwek3VIj0qyD2sgRn3MFxw5k1n6dqlwurwPYGJd+CMqGZI0yo
Ft2zEZ4g7DhZF7d/3SH2yE6dt405NpyZxmUDNy/8mnRKjyxWbr/gIzsIJlWOXYMK
aeKvOXAvkpTk85UB+AWS
=zcKr
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
