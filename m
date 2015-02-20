Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: rtc: mc13xxx: fix obfuscated and wrong format string
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-Id: <1424440050-32000-1-git-send-email-linux@rasmusvillemoes.dk>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Date: Fri, 20 Feb 2015 14:47:30 +0100
List-ID: <rtc-linux.googlegroups.com>

According to C99, %2.s means 'print two spaces' (a precision of
. without following digits or * means 0). The kernel's printf
implementation, however, treats that case as if no precision was
given, but relying on that quirk is rather silly. Also, since no -
(aka left-justify) flag is given, the field with of 2 would then cause
the alarm->enabled case to come out as "o n". Deobfuscate it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-mc13xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mc13xxx.c b/drivers/rtc/rtc-mc13xxx.c
index 5bce904b7ee6..c8e78a560de7 100644
--- a/drivers/rtc/rtc-mc13xxx.c
+++ b/drivers/rtc/rtc-mc13xxx.c
@@ -219,7 +219,7 @@ static int mc13xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	if (unlikely(ret))
 		goto out;
 
-	dev_dbg(dev, "%s: o%2.s %lu\n", __func__, alarm->enabled ? "n" : "ff",
+	dev_dbg(dev, "%s: %s %lu\n", __func__, alarm->enabled ? "on" : "off",
 			s1970);
 
 	ret = mc13xxx_rtc_irq_enable_unlocked(dev, alarm->enabled,
