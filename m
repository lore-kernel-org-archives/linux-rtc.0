Return-Path: <rtc-linux+bncBCMNZUWXYYORBC6NUOVQKGQEXFRRSGY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com. [209.85.192.180])
        by gmr-mx.google.com with ESMTPS id ei3si737230pdb.1.2015.05.29.15.22.02
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2015 15:22:02 -0700 (PDT)
Received: by pdfh10 with SMTP id h10so62913376pdf.3
        for <rtc-linux@googlegroups.com>; Fri, 29 May 2015 15:22:02 -0700 (PDT)
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	sameo@linux.intel.com,
	lee.jones@linaro.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	Vaibhav Hiremath <vaibhav.hiremath@linaro.org>,
	Chao Xie <chao.xie@marvell.com>
Subject: [rtc-linux] [PATCH 4/4] mfd: 88pm800: allocate pdata->rtc if not
 allocated earlier
Date: Sat, 30 May 2015 03:49:22 +0530
Message-Id: <1432937962-4537-5-git-send-email-vaibhav.hiremath@linaro.org>
In-Reply-To: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

RTC in pmic 88PM800 can run even the core is powered off, and user
can set alarm in RTC. When the alarm is timed out, the PMIC will power up
the core, and the whole system will boot up. And during PMIC driver probe,
it will read some register to find out whether this boot is caused by RTC
timeout or not, and pass on this information to the RTC driver.

So we need rtc platform data to be existed in PMIC driver to pass this
information.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mfd/88pm800.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 8ea4467..34546a1 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -586,6 +586,25 @@ static int pm800_probe(struct i2c_client *client,
 			return ret;
 	}
 
+	/*
+	 * RTC in pmic can run even the core is powered off, and user can set
+	 * alarm in RTC. When the alarm is time out, the PMIC will power up
+	 * the core, and the whole system will boot up. When PMIC driver is
+	 * probed, it will read out some register to find out whether this
+	 * boot is caused by RTC timeout or not, and it need pass this
+	 * information to RTC driver.
+	 * So we need rtc platform data to be existed to pass this information.
+	 */
+	if (!pdata->rtc) {
+		pdata->rtc = devm_kzalloc(&client->dev,
+					  sizeof(*(pdata->rtc)), GFP_KERNEL);
+		if (!pdata->rtc) {
+			dev_err(&client->dev,
+					"failed to allocate memory for rtc\n");
+			return -ENOMEM;
+		}
+	}
+
 	ret = pm80x_init(client);
 	if (ret) {
 		dev_err(&client->dev, "pm800_init fail\n");
-- 
1.9.1

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
