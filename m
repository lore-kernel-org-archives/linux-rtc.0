Return-Path: <rtc-linux+bncBCL5RYHM6ECRBBWC7XDQKGQEG34ZSWY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com. [2a00:1450:400c:c09::22d])
        by gmr-mx.google.com with ESMTPS id t10si316836wmb.0.2017.04.25.07.45.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 07:45:26 -0700 (PDT)
Received: by mail-wm0-x22d.google.com with SMTP id u65so24782191wmu.1
        for <rtc-linux@googlegroups.com>; Tue, 25 Apr 2017 07:45:26 -0700 (PDT)
From: Gary Bisson <gary.bisson@boundarydevices.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	Gary Bisson <gary.bisson@boundarydevices.com>
Subject: [rtc-linux] [PATCH 1/4] rtc: m41t80: fix SQWE override when setting
 an alarm
Date: Tue, 25 Apr 2017 16:45:14 +0200
Message-Id: <20170425144517.15962-2-gary.bisson@boundarydevices.com>
In-Reply-To: <20170425144517.15962-1-gary.bisson@boundarydevices.com>
References: <20170425144517.15962-1-gary.bisson@boundarydevices.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Currently setting an alarm clears the SQWE bit which means that the
clock output is disabled no matter its previous state.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 drivers/rtc/rtc-m41t80.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 58698d21c2c3..93684ab293f2 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -273,6 +273,9 @@ static int m41t80_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return err;
 	}
 
+	/* Keep SQWE bit value */
+	alarmvals[0] |= (ret & M41T80_ALMON_SQWE);
+
 	ret = i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
 	if (ret < 0)
 		return ret;
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
