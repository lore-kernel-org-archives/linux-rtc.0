Return-Path: <rtc-linux+bncBDF63NFOVEMBBRGWZWVAKGQE6HZUNVA@googlegroups.com>
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [93.93.135.160])
        by gmr-mx.google.com with ESMTPS id g5si301609wix.1.2015.05.13.08.18.27
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 08:18:27 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 1/2] rtc: max77686: Report platform modalias to
 fix module autoload
Date: Wed, 13 May 2015 17:18:01 +0200
Message-Id: <1431530282-10672-2-git-send-email-javier.martinez@collabora.co.uk>
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

If the rtc-max77686 driver is built as a module, modalias information is
not filled so the module is not autoloaded. Use the MODULE_DEVICE_TABLE()
macro to export the platform ID table so the module contains that data.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/rtc/rtc-max77686.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 7632a87784c3..7184a0eda793 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -511,6 +511,7 @@ static const struct platform_device_id rtc_id[] = {
 	{ "max77686-rtc", 0 },
 	{},
 };
+MODULE_DEVICE_TABLE(platform, rtc_id);
 
 static struct platform_driver max77686_rtc_driver = {
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
