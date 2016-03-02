Return-Path: <rtc-linux+bncBDEKVJM7XAHRBGPO3K3AKGQEYJ67NBA@googlegroups.com>
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.187])
        by gmr-mx.google.com with ESMTPS id ui7si5056003pab.0.2016.03.02.01.49.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2016 01:49:13 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 2/2] char: genrtc: replace blacklist with whitelist
Date: Wed,  2 Mar 2016 10:48:51 +0100
Message-Id: <1456912137-1578635-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Every new architecture has to add itself to the growing list of those
that do not support the old "generic" RTC driver.

This replaces the long list of architectures that don't support it
with a shorter list of those that do.

The list is taken from those architectures that have a non-empty
asm/rtc.h header file and were not explicitly blacklisted.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 9716bc36495a..629f1ff389b6 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -327,7 +327,8 @@ config JS_RTC
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !MIPS && !SPARC && !FRV && !S390 && !SUPERH && !AVR32 && !BLACKFIN && !UML
+	depends on RTC!=y
+	depends on ALPHA || M68K || MN10300 || PARISC || PPC || X86
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.7.0

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
