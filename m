Return-Path: <rtc-linux+bncBD5O5IWPJMIKVL64VQCRUBBPAYI7G@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-x229.google.com (mail-wi0-x229.google.com. [2a00:1450:400c:c05::229])
        by gmr-mx.google.com with ESMTPS id fj7si183836wib.3.2015.07.03.16.15.53
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2015 16:15:53 -0700 (PDT)
Received: by mail-wi0-x229.google.com with SMTP id l6so238114143wiw.0
        for <rtc-linux@googlegroups.com>; Fri, 03 Jul 2015 16:15:53 -0700 (PDT)
From: Philippe Reynes <tremyfr@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	shawn.guo@linaro.org,
	kernel@pengutronix.de,
	linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Philippe Reynes <tremyfr@gmail.com>
Subject: [rtc-linux] [PATCH v4 7/7] apf27: dt: enable support of internal rtc
Date: Sat,  4 Jul 2015 01:15:20 +0200
Message-Id: <1435965320-1478-8-git-send-email-tremyfr@gmail.com>
In-Reply-To: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
References: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
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

Enable support of internal rtc on armadeus apf27.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 arch/arm/boot/dts/imx27-apf27.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index 73aae4f..590d37a 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -122,3 +122,7 @@
 		reg = <0x800000 0xf800000>;
 	};
 };
+
+&rtc {
+	status = "okay";
+};
-- 
1.7.4.4

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
