Return-Path: <rtc-linux+bncBC57DJ5R4ECBBSGB6XAQKGQEHCGFRRA@googlegroups.com>
Received: from mailout1.samsung.com (mailout1.samsung.com. [203.254.224.24])
        by gmr-mx.google.com with ESMTPS id p14si542033pfl.0.2016.11.29.03.04.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Nov 2016 03:04:40 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHE0207VHFQSIE0@mailout1.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 29 Nov 2016 20:04:38 +0900 (KST)
MIME-version: 1.0
Subject: [rtc-linux] [PATCH] rtc: ds1374: Merge conditional + WARN_ON()
Reply-to: rtc-linux@googlegroups.com
Sender: =?UTF-8?B?U3Jpa2FudCBSaXRvbGlh?= <s.ritolia@samsung.com>
From: =?UTF-8?B?U3Jpa2FudCBSaXRvbGlh?= <s.ritolia@samsung.com>
To: =?UTF-8?B?YS56dW1tb0B0b3dlcnRlY2guaXQ=?= <a.zummo@towertech.it>,
 =?UTF-8?B?YWxleGFuZHJlLmJlbGxvbmlAZnJlZS1lbGVjdHJvbnMuY29t?=
 <alexandre.belloni@free-electrons.com>
Cc: =?UTF-8?B?cnRjLWxpbnV4QGdvb2dsZWdyb3Vwcy5jb20=?=
 <rtc-linux@googlegroups.com>, =?UTF-8?B?UmFtIFJlZGR5?= <ram.r@samsung.com>,
 =?UTF-8?B?QXNoaXNoIEthbHJh?= <ashish.kalra@samsung.com>
Message-id: <20161129110437epcms5p3214f832f54aedeed6d0d8e1c32109ce1@epcms5p3>
Date: Tue, 29 Nov 2016 11:04:37 +0000
Content-type: multipart/related;
 boundary="----=_Part_139760_2117590721.1480417477913"
References: <CGME20161129110437epcms5p3214f832f54aedeed6d0d8e1c32109ce1@epcms5p3>
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

------=_Part_139760_2117590721.1480417477913
Content-Type: text/plain; charset=UTF-8

WARN_ON does both these things in one statement.
Using a better pattern with WARN_ON().

Signed-off-by: Srikant Ritolia <s.ritolia@samsung.com>
---
 drivers/rtc/rtc-ds1374.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 3b3049c..52429f0 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -89,10 +89,8 @@ static int ds1374_read_rtc(struct i2c_client *client, u32 *time,
 	int ret;
 	int i;
 
-	if (nbytes > 4) {
-		WARN_ON(1);
+	if (WARN_ON(nbytes > 4))
 		return -EINVAL;
-	}
 
 	ret = i2c_smbus_read_i2c_block_data(client, reg, nbytes, buf);
 
-- 
2.10.2.windows.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

------=_Part_139760_2117590721.1480417477913--
