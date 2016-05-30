Return-Path: <rtc-linux+bncBDEKVJM7XAHRBPM2WK5AKGQE3ON4ABA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.73])
        by gmr-mx.google.com with ESMTPS id l68si1161827wmd.3.2016.05.30.11.58.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2016 11:58:05 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	deller@gmx.de,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au,
	dalias@libc.org,
	dhowells@redhat.com,
	linux-alpha@vger.kernel.org,
	a.zummo@towertech.it,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	rtc-linux@googlegroups.com,
	linux-arch@vger.kernel.org
Subject: [rtc-linux] [PATCH v4 10/16] rtc: m68k: provide ioctl for q40
Date: Mon, 30 May 2016 20:57:58 +0200
Message-Id: <1464634684-1248135-11-git-send-email-arnd@arndb.de>
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The q40 platform is the only machine in the kernel that provides
RTC_PLL_GET/RTC_PLL_SET ioctl commands in its rtc through the
mach_get_rtc_pll/mach_set_rtc_pll callbacks.

However, this currenctly works only in the old-style genrtc
driver, not the (somewhat) modern rtc-generic driver replacing
it. This adds an ioctl implementation to the m68k generic_rtc_ops
in order to let both drivers provide the same API.

After this, we should be able to remove support for genrtc
from the m68k architecture.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/kernel/time.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index bd6417d38d5a..4e5aa2f4f522 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -100,7 +100,32 @@ static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static int rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct rtc_pll_info pll;
+	struct rtc_pll_info __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case RTC_PLL_GET:
+		if (!mach_get_rtc_pll || mach_get_rtc_pll(&pll))
+			return -EINVAL;
+		return copy_to_user(argp, &pll, sizeof pll) ? -EFAULT : 0;
+
+	case RTC_PLL_SET:
+		if (!mach_set_rtc_pll)
+			return -EINVAL;
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+		if (copy_from_user(&pll, argp, sizeof(pll)))
+			return -EFAULT;
+		return mach_set_rtc_pll(&pll);
+	}
+
+	return -ENOIOCTLCMD;
+}
+
 static const struct rtc_class_ops generic_rtc_ops = {
+	.ioctl = rtc_ioctl,
 	.read_time = rtc_generic_get_time,
 	.set_time = rtc_generic_set_time,
 };
-- 
2.7.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
