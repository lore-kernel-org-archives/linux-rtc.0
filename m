Return-Path: <rtc-linux+bncBDSJR27JS4DBB7GNYK6AKGQEH3S74VQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from authsmtp.register.it (authsmtp91.register.it. [195.110.122.176])
        by gmr-mx.google.com with ESMTPS id i198si139430wmd.2.2016.07.21.03.42.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jul 2016 03:42:04 -0700 (PDT)
From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	=?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
Subject: [rtc-linux] [PATCH 6/6] rtc: rv8803: Clear V1F when setting the time
Date: Thu, 21 Jul 2016 12:41:32 +0200
Message-Id: <1469097692-103146-6-git-send-email-benoit@wsystem.com>
In-Reply-To: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
References: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

V1F indicates that the time accuracy may have been compromised because
of a voltage drop (possibly only temporary) below VLOW1, which stops the
temperature compensation. When the time is set, the accuracy is
restored, so V1F should be cleared in order to indicate this and to be
able to detect the next temperature compensation loss. This is the same
principle as for V2F, which is cleared when the time is set to indicate
that the time is no longer invalid and to be able to detect the next
data loss.

Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
---
 drivers/rtc/rtc-rv8803.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 24c688e..9a2f6a9 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -265,7 +265,7 @@ static int rv8803_set_time(struct device *dev, struct r=
tc_time *tm)
 	}
=20
 	ret =3D rv8803_write_reg(rv8803->client, RV8803_FLAG,
-			       flags & ~RV8803_FLAG_V2F);
+			       flags & ~(RV8803_FLAG_V1F | RV8803_FLAG_V2F));
=20
 	mutex_unlock(&rv8803->flags_lock);
=20
--=20
2.5.0

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
