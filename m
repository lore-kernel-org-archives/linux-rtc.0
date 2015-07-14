Return-Path: <rtc-linux+bncBAABB2MVSSWQKGQEYULN5SQ@googlegroups.com>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com. [193.109.254.116])
        by gmr-mx.google.com with ESMTPS id bk2si81974wib.1.2015.07.14.06.13.13
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:13:13 -0700 (PDT)
Message-ID: <70bb99452b0b38623ab1c25b2912eafa92d1826d.1436879270.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1436879270.git.stwiss.opensource@diasemi.com>
References: <cover.1436879270.git.stwiss.opensource@diasemi.com>
From: S Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 14 Jul 2015 14:07:50 +0100
Subject: [rtc-linux] [PATCH RFC V1 1/3] mfd: da9062: Support for the DA9063
 OnKey in the DA9062 core
To: DEVICETREE <devicetree@vger.kernel.org>, LINUXINPUT
	<linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>, RTCLINUX <rtc-linux@googlegroups.com>, "S
 Twiss" <stwiss.opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>
CC: David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel
 Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support
 Opensource <support.opensource@diasemi.com>
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

Add MFD core driver support for a OnKey component

- MFD core adds the resource da9062_onkey_resources[] for the OnKey
- An appropriate value has been added into mfd_cell da9062_devs[] to
  support component .name = "da9062-onkey" and
  .of_compatible  = "dlg,da9062-onkey"

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
 da9062-core.c             total: 0 errors, 0 warnings, 523 lines checked
This patch applies against linux-next and next-20150708 


 drivers/mfd/da9062-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 4cf0643..0732977 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -118,6 +118,10 @@ static struct resource da9062_wdt_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_WDG_WARN, 1, "WD_WARN", IORESOURCE_IRQ),
 };
 
+static struct resource da9062_onkey_resources[] = {
+	DEFINE_RES_NAMED(DA9062_IRQ_ONKEY, 1, "ONKEY", IORESOURCE_IRQ),
+};
+
 static const struct mfd_cell da9062_devs[] = {
 	{
 		.name		= "da9062-core",
@@ -141,6 +145,13 @@ static const struct mfd_cell da9062_devs[] = {
 		.resources	= da9062_thermal_resources,
 		.of_compatible  = "dlg,da9062-thermal",
 	},
+	{
+		.name		= "da9062-onkey",
+		.num_resources	= ARRAY_SIZE(da9062_onkey_resources),
+		.resources	= da9062_onkey_resources,
+		.of_compatible = "dlg,da9062-onkey",
+	},
+
 };
 
 static int da9062_clear_fault_log(struct da9062 *chip)
-- 
end-of-patch for PATCH RFC V1

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
