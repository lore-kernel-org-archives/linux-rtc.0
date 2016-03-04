Return-Path: <rtc-linux+bncBDU7VC56WAFBBC5Y463AKGQEBHXKLGA@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id v68si14224wmd.1.2016.03.04.11.03.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 11:03:38 -0800 (PST)
Date: Fri, 4 Mar 2016 19:55:44 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 3/6] rtc-rv3029: Add missing register definitions
Message-ID: <20160304195544.6b6297df@wiggum>
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
 boundary="Sig_/=PdhZEQUEXTVCnZD.LUSd5q"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/=PdhZEQUEXTVCnZD.LUSd5q
Content-Type: text/plain; charset=UTF-8

This adds all (according to the data sheet) missing register and bit
definitions.
It also fixes the definition of the trickle charger bit masks.

Signed-off-by: Michael Buesch <m@bues.ch>
---
 drivers/rtc/rtc-rv3029c2.c | 61 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index fc0dbc4..29cc871 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -22,25 +22,42 @@
 /* Register map */
 /* control section */
 #define RV3029_ONOFF_CTRL		0x00
+#define RV3029_ONOFF_CTRL_WE		BIT(0)
+#define RV3029_ONOFF_CTRL_TE		BIT(1)
+#define RV3029_ONOFF_CTRL_TAR		BIT(2)
+#define RV3029_ONOFF_CTRL_EERE		BIT(3)
+#define RV3029_ONOFF_CTRL_SRON		BIT(4)
+#define RV3029_ONOFF_CTRL_TD0		BIT(5)
+#define RV3029_ONOFF_CTRL_TD1		BIT(6)
+#define RV3029_ONOFF_CTRL_CLKINT	BIT(7)
 #define RV3029_IRQ_CTRL			0x01
-#define RV3029_IRQ_CTRL_AIE		(1 << 0)
+#define RV3029_IRQ_CTRL_AIE		BIT(0)
+#define RV3029_IRQ_CTRL_TIE		BIT(1)
+#define RV3029_IRQ_CTRL_V1IE		BIT(2)
+#define RV3029_IRQ_CTRL_V2IE		BIT(3)
+#define RV3029_IRQ_CTRL_SRIE		BIT(4)
 #define RV3029_IRQ_FLAGS		0x02
-#define RV3029_IRQ_FLAGS_AF		(1 << 0)
+#define RV3029_IRQ_FLAGS_AF		BIT(0)
+#define RV3029_IRQ_FLAGS_TF		BIT(1)
+#define RV3029_IRQ_FLAGS_V1IF		BIT(2)
+#define RV3029_IRQ_FLAGS_V2IF		BIT(3)
+#define RV3029_IRQ_FLAGS_SRF		BIT(4)
 #define RV3029_STATUS			0x03
-#define RV3029_STATUS_VLOW1		(1 << 2)
-#define RV3029_STATUS_VLOW2		(1 << 3)
-#define RV3029_STATUS_SR		(1 << 4)
-#define RV3029_STATUS_PON		(1 << 5)
-#define RV3029_STATUS_EEBUSY		(1 << 7)
+#define RV3029_STATUS_VLOW1		BIT(2)
+#define RV3029_STATUS_VLOW2		BIT(3)
+#define RV3029_STATUS_SR		BIT(4)
+#define RV3029_STATUS_PON		BIT(5)
+#define RV3029_STATUS_EEBUSY		BIT(7)
 #define RV3029_RST_CTRL			0x04
+#define RV3029_RST_CTRL_SYSR		BIT(4)
 #define RV3029_CONTROL_SECTION_LEN	0x05
 
 /* watch section */
 #define RV3029_W_SEC			0x08
 #define RV3029_W_MINUTES		0x09
 #define RV3029_W_HOURS			0x0A
-#define RV3029_REG_HR_12_24		(1<<6)  /* 24h/12h mode */
-#define RV3029_REG_HR_PM		(1<<5)  /* PM/AM bit in 12h mode */
+#define RV3029_REG_HR_12_24		BIT(6) /* 24h/12h mode */
+#define RV3029_REG_HR_PM		BIT(5) /* PM/AM bit in 12h mode */
 #define RV3029_W_DATE			0x0B
 #define RV3029_W_DAYS			0x0C
 #define RV3029_W_MONTHS			0x0D
@@ -67,16 +84,28 @@
 /* eeprom data section */
 #define RV3029_E2P_EEDATA1		0x28
 #define RV3029_E2P_EEDATA2		0x29
+#define RV3029_E2PDATA_SECTION_LEN	0x02
 
 /* eeprom control section */
 #define RV3029_CONTROL_E2P_EECTRL	0x30
-#define RV3029_TRICKLE_1K		(1<<0)  /*  1K resistance */
-#define RV3029_TRICKLE_5K		(1<<1)  /*  5K resistance */
-#define RV3029_TRICKLE_20K		(1<<2)  /* 20K resistance */
-#define RV3029_TRICKLE_80K		(1<<3)  /* 80K resistance */
-#define RV3029_CONTROL_E2P_XTALOFFSET	0x31
-#define RV3029_CONTROL_E2P_QCOEF	0x32
-#define RV3029_CONTROL_E2P_TURNOVER	0x33
+#define RV3029_EECTRL_THP		BIT(0) /* temp scan interval */
+#define RV3029_EECTRL_THE		BIT(1) /* thermometer enable */
+#define RV3029_EECTRL_FD0		BIT(2) /* CLKOUT */
+#define RV3029_EECTRL_FD1		BIT(3) /* CLKOUT */
+#define RV3029_TRICKLE_1K		BIT(4) /* 1.5K resistance */
+#define RV3029_TRICKLE_5K		BIT(5) /* 5K   resistance */
+#define RV3029_TRICKLE_20K		BIT(6) /* 20K  resistance */
+#define RV3029_TRICKLE_80K		BIT(7) /* 80K  resistance */
+#define RV3029_TRICKLE_MASK		(RV3029_TRICKLE_1K |\
+					 RV3029_TRICKLE_5K |\
+					 RV3029_TRICKLE_20K |\
+					 RV3029_TRICKLE_80K)
+#define RV3029_TRICKLE_SHIFT		4
+#define RV3029_CONTROL_E2P_XOFFS	0x31 /* XTAL offset */
+#define RV3029_CONTROL_E2P_XOFFS_SIGN	BIT(7) /* Sign: 1->pos, 0->neg */
+#define RV3029_CONTROL_E2P_QCOEF	0x32 /* XTAL temp drift coef */
+#define RV3029_CONTROL_E2P_TURNOVER	0x33 /* XTAL turnover temp (in *C) */
+#define RV3029_CONTROL_E2P_TOV_MASK	0x3F /* XTAL turnover temp mask */
 
 /* user ram section */
 #define RV3029_USR1_RAM_PAGE		0x38
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

--Sig_/=PdhZEQUEXTVCnZD.LUSd5q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2dowAAoJEPUyvh2QjYsOWOwP/1BvUu6XXNwlVS8CxJ2IIuJx
w6OhJ9rkaX/TEdz/gEidUPInjZMnnFJWRHI++EUVgMoSJs09reEvBX2zac2fGFkz
8ApxN2ShCw1v7bLSMAkEgcUEN4oHSK5p/b3h/nffe3rcD2M3LRKRIV1vr5qQihHW
9an7Sf8Cv0N1f5CG0FBk5LUTjLQCOuE5rLchAnlX1fW4iH4NZPkjutR3OwKefxPV
Abk4+o6LogUxt2CQHJ3b/sbd7vEoZ6dPUa9caAjs8fhgRDbeovPjDCBr1M1iwNQl
Oo4o4IyyHUX/9gAkfHgbgAnOU1OENCOpdig7yXFdRYtla5l2s1XlyB584IEv/7zk
s/85NXJiuNDLwphEtZbbYxiBJxYRJMJGFtuF9uu0ENTaGfkqKVu+AhQsEIhnDZub
MSEt86lBLckWGfdwidloc0uduscOItKIjZGtlEpajqTmwNPDwFHxLSqNXRgxUszA
7KYS9bK2wnPXjGIAcyFufh+zayWLAXx5y6+ni1Hpmlym9SMT6PeCJJuvp1Ot/M0q
BADu24eZWQwru7qv9nXgZ740WIFLI8Urj1Kugp8sPEocOw31I3287ra/vOfXoAJ2
MmG+YpjWyW1vlfzwRhqpY439CZtqyQDVMoUgv00cid73RpJtR4wy4dp+0O++QeMk
Vvf99m0Tcc9poQ9Wt1/q
=6qEv
-----END PGP SIGNATURE-----

--Sig_/=PdhZEQUEXTVCnZD.LUSd5q--
