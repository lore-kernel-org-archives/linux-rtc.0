Return-Path: <rtc-linux+bncBDU7VC56WAFBBCVY463AKGQEES4YGQY@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id c140si17777wmh.1.2016.03.04.11.03.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 11:03:38 -0800 (PST)
Date: Fri, 4 Mar 2016 19:55:11 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 2/6] rtc-rv3029: Add "rv3029" I2C device id
Message-ID: <20160304195511.6f67ef09@wiggum>
In-Reply-To: <20160304195337.51439645@wiggum>
References: <20160301213322.661fe771@wiggum>
	<20160301213655.GG23985@piout.net>
	<20160301225401.3f0aeabb@wiggum>
	<20160301230745.GJ23985@piout.net>
	<20160302072627.14e53e94@wiggum>
	<20160302120045.GO23985@piout.net>
	<20160304195337.51439645@wiggum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6GkMuN6nV_zlj8XYXkWji8="; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/6GkMuN6nV_zlj8XYXkWji8=
Content-Type: text/plain; charset=UTF-8

The C2 suffix does not appear in the latest datasheet, so add
a device ID without it.

Signed-off-by: Michael Buesch <m@bues.ch>
---
 drivers/rtc/rtc-rv3029c2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 3083ace..fc0dbc4 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -381,6 +381,7 @@ static const struct rtc_class_ops rv3029_rtc_ops = {
 };
 
 static struct i2c_device_id rv3029_id[] = {
+	{ "rv3029", 0 },
 	{ "rv3029c2", 0 },
 	{ }
 };
-- 
2.7.0

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

--Sig_/6GkMuN6nV_zlj8XYXkWji8=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2doPAAoJEPUyvh2QjYsO7MUP/2OVMpEQ5S/pnFdCGtPo2vtd
IGcqlV2KP1onm+trEKM9+FPsY99iBYAcR1oQyIbGA+m+Om+1k0Bb5s36UdPZuSiH
0CKfAI3yNrpbPlJVFYkBm6WJn1u5Jk6ac4owTgZe/eJwuK3lSA0lPNlcAGQXbObF
ykKKGxLj+fFAJKQ08MQXmPA8HWoaefUyJtXBRzvhzzL9SHJdwkA0u1HwXgrHr9U/
oAi1IYPCltPcKl4EvQ0CeMyS+NQ2lHp4ZwGgwwzLvrkYYd85wOFng/2hiLqMUr5E
IYWyCHfk2pzxEf7Qc5gDV9v3jJuT370mOzmMCU+3/xY2Rc6R7AkXMAOkwn8vL6B1
eY4TN41g+tBJ3pgx6DvA/mpuhEgVTlWbf25vdTC1Bqg0YBSL3LK1SBE5G9CMEgyF
bmjhQa9TJpMhUDxaBcaugM9yhvljullw8eEFCf4bUDrBeyMXOmmhG1OqROPz6CAU
9cEeD9ZM49IlGHt6QNKoG5g8HWIefUIcCh9i/7S6z195aLuJrwB5BUUT0Wks9EPZ
QQLF/E61PRT2J8fQBIX9gYeZFvDDX1p9QXGleToJm8B6/IywbFrtjd3YgCtX1NLo
TcjNNFlKcgcS4vfEsMdCm5Jcgvm9oLk0/HrT8XMlhsU5iQwxBkmnGPnuY7TKBogO
hFX1u/bOwCEaR+2sT4AJ
=y+g2
-----END PGP SIGNATURE-----

--Sig_/6GkMuN6nV_zlj8XYXkWji8=--
