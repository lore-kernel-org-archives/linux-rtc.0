Return-Path: <rtc-linux+bncBDAYD2P3QYGRBRPVWG6QKGQEDZHR45Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com. [2a00:1450:400c:c09::22d])
        by gmr-mx.google.com with ESMTPS id r74si1633wme.3.2016.08.11.06.16.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2016 06:16:52 -0700 (PDT)
Received: by mail-wm0-x22d.google.com with SMTP id q128so4558577wma.1
        for <rtc-linux@googlegroups.com>; Thu, 11 Aug 2016 06:16:52 -0700 (PDT)
From: Neil Armstrong <narmstrong@baylibre.com>
To: andy.gross@linaro.org,
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
Subject: [rtc-linux] [PATCH v4 2/4] rtc: rtc-pm8xxx: Add support for pm8018 rtc
Date: Thu, 11 Aug 2016 15:16:44 +0200
Message-Id: <1470921406-18468-3-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1470921406-18468-1-git-send-email-narmstrong@baylibre.com>
References: <1470921406-18468-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

In order to support RTC on Qualcomm MDM9615 SoC, add support for
the pm8018 rtc in rtc-pm8xxx driver.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt | 1 +
 drivers/rtc/rtc-pm8xxx.c                              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
index f24f334..37a088f 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
@@ -62,6 +62,7 @@ The below bindings specify the set of valid subnodes.
 		    "qcom,pm8058-rtc"
 		    "qcom,pm8921-rtc"
 		    "qcom,pm8941-rtc"
+		    "qcom,pm8018-rtc"
 
 - reg:
 	Usage: required
diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 795fcbd..fac8355 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -428,6 +428,7 @@ static const struct pm8xxx_rtc_regs pm8941_regs = {
  */
 static const struct of_device_id pm8xxx_id_table[] = {
 	{ .compatible = "qcom,pm8921-rtc", .data = &pm8921_regs },
+	{ .compatible = "qcom,pm8018-rtc", .data = &pm8921_regs },
 	{ .compatible = "qcom,pm8058-rtc", .data = &pm8058_regs },
 	{ .compatible = "qcom,pm8941-rtc", .data = &pm8941_regs },
 	{ },
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
