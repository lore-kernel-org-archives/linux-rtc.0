Return-Path: <rtc-linux+bncBDF63NFOVEMBBR6WZWVAKGQED5AFXEI@googlegroups.com>
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [93.93.135.160])
        by gmr-mx.google.com with ESMTPS id k2si307446wif.0.2015.05.13.08.18.31
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 08:18:31 -0700 (PDT)
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Olof Johansson <olof@lixom.net>,
	Doug Anderson <dianders@chromium.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	rtc-linux@googlegroups.com,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [rtc-linux] [PATCH 2/2] rtc: max77802: Report platform modalias to
 fix module autoload
Date: Wed, 13 May 2015 17:18:02 +0200
Message-Id: <1431530282-10672-3-git-send-email-javier.martinez@collabora.co.uk>
In-Reply-To: <1431530282-10672-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1431530282-10672-1-git-send-email-javier.martinez@collabora.co.uk>
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

If the rtc-max77802 driver is built as a module, modalias information is
not filled so the module is not autoloaded. Use the MODULE_DEVICE_TABLE()
macro to export the platform ID table so the module contains that data.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/rtc/rtc-max77802.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-max77802.c b/drivers/rtc/rtc-max77802.c
index 7f8adf8d6feb..82ffcc5a5345 100644
--- a/drivers/rtc/rtc-max77802.c
+++ b/drivers/rtc/rtc-max77802.c
@@ -484,6 +484,7 @@ static const struct platform_device_id rtc_id[] = {
 	{ "max77802-rtc", 0 },
 	{},
 };
+MODULE_DEVICE_TABLE(platform, rtc_id);
 
 static struct platform_driver max77802_rtc_driver = {
 	.driver		= {
-- 
2.1.4

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
