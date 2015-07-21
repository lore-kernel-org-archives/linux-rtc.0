Return-Path: <rtc-linux+bncBAABBNNJXCWQKGQE3WH4XTQ@googlegroups.com>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.105])
        by gmr-mx.google.com with ESMTPS id gt9si511997wib.2.2015.07.21.02.45.24
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 02:45:24 -0700 (PDT)
Message-ID: <38520a1087687db11a1cc542b97075004087da64.1437471790.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1437471790.git.stwiss.opensource@diasemi.com>
References: <cover.1437471790.git.stwiss.opensource@diasemi.com>
From: S Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 21 Jul 2015 10:43:09 +0100
Subject: [rtc-linux] [PATCH V2 1/3] mfd: da9062: Support for the DA9063 RTC in
 the DA9062 core
To: DEVICETREE <devicetree@vger.kernel.org>, LINUXINPUT
	<linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>, RTCLINUX <rtc-linux@googlegroups.com>, S
 Twiss <stwiss.opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, David Dajun Chen
	<david.chen@diasemi.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll
	<pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource
	<support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: S Twiss <stwiss.opensource@diasemi.com>

Add MFD core driver support for a RTC component

- MFD core adds the RTC resources da9062_rtc_resources[] for the RTC
  alarm and tick timer IRQ
- An appropriate mfd_cell has been added into da9062_devs[] to support
  a component .name = "da9062-rtc" and .of_compatible  = "dlg,da9062-rtc"

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
 da9062-core.c             total: 0 errors, 0 warnings, 523 lines checked
This patch applies against linux-next and next-20150708 


 drivers/mfd/da9062-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 4cf0643..b43cd24 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -118,6 +118,11 @@ static struct resource da9062_wdt_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_WDG_WARN, 1, "WD_WARN", IORESOURCE_IRQ),
 };
 
+static struct resource da9062_rtc_resources[] = {
+	DEFINE_RES_NAMED(DA9062_IRQ_ALARM, 1, "ALARM", IORESOURCE_IRQ),
+	DEFINE_RES_NAMED(DA9062_IRQ_TICK, 1, "TICK", IORESOURCE_IRQ),
+};
+
 static const struct mfd_cell da9062_devs[] = {
 	{
 		.name		= "da9062-core",
@@ -141,6 +146,12 @@ static const struct mfd_cell da9062_devs[] = {
 		.resources	= da9062_thermal_resources,
 		.of_compatible  = "dlg,da9062-thermal",
 	},
+	{
+		.name		= "da9062-rtc",
+		.num_resources	= ARRAY_SIZE(da9062_rtc_resources),
+		.resources	= da9062_rtc_resources,
+		.of_compatible  = "dlg,da9062-rtc",
+	},
 };
 
 static int da9062_clear_fault_log(struct da9062 *chip)
-- 
end-of-patch for PATCH V2

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
