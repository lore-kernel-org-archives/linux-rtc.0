Return-Path: <rtc-linux+bncBDU7VC56WAFBBP4D5C3AKGQEXIG4EAI@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id c140si39566wmh.1.2016.03.04.13.44.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 13:44:31 -0800 (PST)
Date: Fri, 4 Mar 2016 22:39:17 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v3 2/6] rtc-rv3029: Add "rv3029" I2C device id
Message-ID: <20160304223917.2448f2fe@wiggum>
In-Reply-To: <20160304195511.6f67ef09@wiggum>
References: <20160301213322.661fe771@wiggum>
	<20160301213655.GG23985@piout.net>
	<20160301225401.3f0aeabb@wiggum>
	<20160301230745.GJ23985@piout.net>
	<20160302072627.14e53e94@wiggum>
	<20160302120045.GO23985@piout.net>
	<20160304195337.51439645@wiggum>
	<20160304195511.6f67ef09@wiggum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1UJy8G_iSB8g07LxBhlLAah"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/1UJy8G_iSB8g07LxBhlLAah
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

--Sig_/1UJy8G_iSB8g07LxBhlLAah
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2gCFAAoJEPUyvh2QjYsOiLMP/20L0Bz6LOKxOSpy/v+n/pSf
FVBevH18i5pzQ6t7Ofhe4f8R7HtnjDD4xILWkBvgAZfpYAUAyTzMjEAklAyxFbYb
au6zfwtFs7dgn79ipozEMHjZ0NpkW2lD/lAQYFSi/4gT0RYsD7fnremPoqPYbhxA
+Vv9i/xNvlbGVkRQbyBPu9cNncL/wTdURs9Dlo5a0r7jCfiEqqmLC5o2TWNhIkAo
4LvabLW7NfOqvkHISJOgMNUipdGImzYj71EZl0CEaF1GM89xKC+tFOCU/iyLsHT0
xtEM7+OF4URVKhogFaK/cEuc3wGkjVMejtNtRJzk+DkZ/6UX/9E5P+f/1BT1Dwkm
kK1KoozDgCiVN1GEL0xJhZXUQ/eCBBrgFxbfyZz0fR7QX/keXd3Bqs2qjOOVUpAf
jYMv0UgUYvf7/BxiLMMAUCPx7tvpNA1mwk6WOb/XMm+T6SWbcVWF4vkfMtiWZKQu
8Gag2dkG/8fnrb4b6OuPQGuUZ7pa76mnJHOb8sjAadaqFCCXA/qX+rATaOwvsEqU
IQuBrrMgr4YinPa96L0shmxc2PktYKGZ8PBMD3FiqP9l5hIxknbjElOv10AW3+HT
dyYKhQdP/gUIg8cxSaAi1OWze75cIrJksP03erxRqz+Yc9QVr1YgjvxxMeiRLWgC
QO0QlK0efDC8H1QnEmTk
=LicN
-----END PGP SIGNATURE-----

--Sig_/1UJy8G_iSB8g07LxBhlLAah--
