Return-Path: <rtc-linux+bncBAABBMOO5C3QKGQEEAMNZRY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 185si580760wml.0.2016.03.28.23.56.49
        for <rtc-linux@googlegroups.com>;
        Mon, 28 Mar 2016 23:56:49 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 7/8] rtc: m41t80: add wakealarm functionality
Date: Tue, 29 Mar 2016 08:56:04 +0200
Message-Id: <df094cfdf29dcbe0eb0716dbb3b20441dbc35f74.1459233897.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1459188215.git.mylene.josserand@free-electrons.com>
References: <cover.1459188215.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1459233897.git.mylene.josserand@free-electrons.com>
References: <cover.1459233897.git.mylene.josserand@free-electrons.com>
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

To enable the wakealarm, the device must be able to wakeup.
This is done by setting the device wakeup capability to true with
'device_init_wakeup' function.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-m41t80.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 4255449..660a734 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -754,6 +754,8 @@ static int m41t80_probe(struct i2c_client *client,
 			m41t80_rtc_ops.read_alarm =3D m41t80_read_alarm;
 			m41t80_rtc_ops.set_alarm =3D m41t80_set_alarm;
 			m41t80_rtc_ops.alarm_irq_enable =3D m41t80_alarm_irq_enable;
+			/* Enable the wakealarm */
+			device_init_wakeup(&client->dev, true);
 		}
 	}
=20
--=20
2.8.0.rc3

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
