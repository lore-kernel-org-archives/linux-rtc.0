Return-Path: <rtc-linux+bncBDAYD2P3QYGRBVXVWO5QKGQE6FXFURI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com. [2a00:1450:400c:c09::232])
        by gmr-mx.google.com with ESMTPS id f138si95464wmf.3.2016.06.24.02.18.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2016 02:18:14 -0700 (PDT)
Received: by mail-wm0-x232.google.com with SMTP id r201so16677956wme.1
        for <rtc-linux@googlegroups.com>; Fri, 24 Jun 2016 02:18:14 -0700 (PDT)
From: Neil Armstrong <narmstrong@baylibre.com>
To: dmitry.torokhov@gmail.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	lee.jones@linaro.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v2 1/5] mfd: pm8921: Add support for pm8018
Date: Fri, 24 Jun 2016 11:18:03 +0200
Message-Id: <1466759887-25394-2-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1466759887-25394-1-git-send-email-narmstrong@baylibre.com>
References: <1466759887-25394-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

In order to support the Qualcomm MDM9615 PMIC, add support for the
pm8018 in pm8921 mfd driver.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mfd/pm8921-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
index 1b7ec08..0e3a2ea 100644
--- a/drivers/mfd/pm8921-core.c
+++ b/drivers/mfd/pm8921-core.c
@@ -309,6 +309,7 @@ static const struct regmap_config ssbi_regmap_config = {
 };
 
 static const struct of_device_id pm8921_id_table[] = {
+	{ .compatible = "qcom,pm8018", },
 	{ .compatible = "qcom,pm8058", },
 	{ .compatible = "qcom,pm8921", },
 	{ }
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
