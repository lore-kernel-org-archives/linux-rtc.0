Return-Path: <rtc-linux+bncBDKZNNNLXAHBB2UOWG4QKGQECUGLWSY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id 17si2743349pfw.0.2016.05.06.00.27.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 May 2016 00:27:38 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O6Q002NEVDY9D80@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 06 May 2016 08:27:34 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Richard Purdie <rpurdie@rpsys.net>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, Lee Jones <lee.jones@linaro.org>,
 Sebastian Reichel <sre@kernel.org>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, rtc-linux@googlegroups.com
Cc: r.baldyga@hackerion.com,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [rtc-linux] [PATCH v6 7/9] extcon: max8997: Fix inconsistent indenting
Date: Fri, 06 May 2016 09:27:14 +0200
Message-id: <1462519636-3250-6-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Fix smatch warning:
	max8997_muic_probe() warn: inconsistent indenting

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/extcon/extcon-max8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 0afa3e8b5dc3..cf8de5be2405 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -737,7 +737,7 @@ static int max8997_muic_probe(struct platform_device *pdev)
 	}
 
 	/* Set initial path for UART */
-	 max8997_muic_set_path(info, info->path_uart, true);
+	max8997_muic_set_path(info, info->path_uart, true);
 
 	/* Set ADC debounce time */
 	max8997_muic_set_debounce_time(info, ADC_DEBOUNCE_TIME_25MS);
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
