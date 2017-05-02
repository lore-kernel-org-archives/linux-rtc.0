Return-Path: <rtc-linux+bncBCSIDSUM5MNRBOMRUHEAKGQE6JOVT3A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com. [216.82.243.198])
        by gmr-mx.google.com with ESMTPS id f9si1891581ywh.6.2017.05.02.01.52.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2017 01:52:08 -0700 (PDT)
From: Ocean HY1 He <hehy1@lenovo.com>
To: "matt.fleming@intel.com" <matt.fleming@intel.com>, "a.zummo@towertech.it"
	<a.zummo@towertech.it>, "alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>, "msalter@redhat.com"
	<msalter@redhat.com>
CC: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ocean HY1 He
	<hehy1@lenovo.com>
Subject: [rtc-linux] [PATCH] rtc: rtc-efi: Add an enable parameter and make it
 false for X86 by default
Date: Tue, 2 May 2017 08:51:47 +0000
Message-ID: <1493715444-79142-1-git-send-email-hehy1@lenovo.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The commit 7efe665903d0 ("rtc: Disable EFI rtc for x86") turns off rtc-efi
option completely for x86 in rtc/Kconfig, to avoid possible crash caused by
buggy implementations of the time-related EFI runtime services.

In fact, there are more and more UEFI firmware has time-related EFI runtime
services well done. To meet EFI rtc request for X86, here adds an enable
parameter which could be explicitly set as true when load rtc-efi module.
To keep consistency, make this enable parameter false for X86 by default.

The test passes on Lenovo ThinkServer RD350 while the UEFI/BIOS version is
VB3TS424 and processor is Intel(R) Xeon(R) CPU E5-2660 v3.
#modprobe rtc_efi enable=1
#cat /sys/class/rtc/rtc1/name
rtc-efi
#hwclock --rtc=/dev/rtc1 -w
#hwclock --rtc=/dev/rtc1 -r

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/rtc/Kconfig   |  2 +-
 drivers/rtc/rtc-efi.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index ee1b0e9..482200a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1037,7 +1037,7 @@ config RTC_DRV_DA9063
 
 config RTC_DRV_EFI
 	tristate "EFI RTC"
-	depends on EFI && !X86
+	depends on EFI
 	help
 	  If you say yes here you will get support for the EFI
 	  Real Time Clock.
diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index 0130afd..5a8427f 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -23,6 +23,14 @@
 #include <linux/rtc.h>
 #include <linux/efi.h>
 
+/*
+ * Disable the use of rtc-efi as a RTC for X86 by default. This setting can be
+ * overridden using this module's enable parameter.
+ */
+static bool efi_rtc_enable = !IS_ENABLED(CONFIG_X86);
+
+module_param_named(enable, efi_rtc_enable, bool, 0644);
+
 #define EFI_ISDST (EFI_TIME_ADJUST_DAYLIGHT|EFI_TIME_IN_DAYLIGHT)
 
 /*
@@ -262,6 +270,9 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 	efi_time_t eft;
 	efi_time_cap_t cap;
 
+	if (!efi_rtc_enable)
+		return -ENODEV;
+
 	/* First check if the RTC is usable */
 	if (efi.get_time(&eft, &cap) != EFI_SUCCESS)
 		return -ENODEV;
-- 
1.8.3.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
