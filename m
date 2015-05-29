Return-Path: <rtc-linux+bncBD2OLRXW4ABBBGVRUGVQKGQEC6FT74Y@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id xv6si564607pab.2.2015.05.29.05.16.26
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 29 May 2015 05:16:26 -0700 (PDT)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
	<akpm@linux-foundation.org>
CC: <rtc-linux@googlegroups.com>, <linux-kernel@vger.kernel.org>, Laxman
 Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH] rtc: palmas: Initialise bb_charging flag before
 using it
Date: Fri, 29 May 2015 17:44:05 +0530
Message-ID: <1432901645-17478-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Initialise the variable high_bb_charging before using it to avoid
configuring wrong value and fix following compilation warning:

/*
rtc-palmas.c: In function =E2=80=98palmas_rtc_probe=E2=80=99:
rtc-palmas.c:242:7: warning: =E2=80=98high_bb_charging=E2=80=99 may be used
uninitialized in this function
*/

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/rtc/rtc-palmas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-palmas.c b/drivers/rtc/rtc-palmas.c
index 3b01d56..7ea2c47 100644
--- a/drivers/rtc/rtc-palmas.c
+++ b/drivers/rtc/rtc-palmas.c
@@ -239,7 +239,7 @@ static int palmas_rtc_probe(struct platform_device *pde=
v)
 	struct palmas_rtc *palmas_rtc =3D NULL;
 	int ret;
 	bool enable_bb_charging =3D false;
-	bool high_bb_charging;
+	bool high_bb_charging =3D false;
=20
 	if (pdev->dev.of_node) {
 		enable_bb_charging =3D of_property_read_bool(pdev->dev.of_node,
--=20
2.1.4

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
