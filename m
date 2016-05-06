Return-Path: <rtc-linux+bncBDKZNNNLXAHBB24OWG4QKGQEIWBU6LQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id 17si2743349pfw.0.2016.05.06.00.27.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 May 2016 00:27:39 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O6Q002NGVE09D80@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 06 May 2016 08:27:36 +0100 (BST)
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
Cc: r.baldyga@hackerion.com, stable@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [rtc-linux] [PATCH v6 9/9] ARM: dts: exynos: Add interrupt line to
 MAX8997 PMIC on exynos4210-trats
Date: Fri, 06 May 2016 09:27:16 +0200
Message-id: <1462519636-3250-8-git-send-email-k.kozlowski@samsung.com>
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

From: Marek Szyprowski <m.szyprowski@samsung.com>

MAX8997 PMIC requires interrupt and fails probing without it.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: d105f0b1215d ("ARM: dts: Add basic dts file for Samsung Trats board")
Cc: <stable@vger.kernel.org>
[k.kozlowski: Write commit message, add CC-stable]
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index fed5847410d3..79d983036560 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -298,6 +298,8 @@
 		compatible = "maxim,max8997-pmic";
 
 		reg = <0x66>;
+		interrupt-parent = <&gpx0>;
+		interrupts = <7 0>;
 
 		max8997,pmic-buck1-uses-gpio-dvs;
 		max8997,pmic-buck2-uses-gpio-dvs;
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
