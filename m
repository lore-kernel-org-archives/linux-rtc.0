Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794788712;
	b=VhWIb3eMI8+4pvaPag+buOtwW43IlHBtJBzjLRvV7kcdsyuN4Z9A1ZHDu91oZaY8qedM
	 xtyAfl848QuB9UOu28xX6As+mOwQNBi9OZzNrK2pIh+rg0A7y5V86NnO8cdzImeXHNaDn
	 6Pp1/AtZkZOQvNaqLZeP1kZ6IY9VQMNjmxmxNxaC+zvkXxgjrhooshZKoBEcrPw8ziTov
	 lKuszjI9evEghFhlPzTyz6fBYPor3vINqzn5EiHDkeoecr/ExcVcK3pGAfbTy1KKM2Odr
	 wtoGiiQmkbRM6geQ4i6KaDqiQnXmbpbVCnmMmjgHwiEDNbAlskVGwsR2YOT+MBQdiTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794788712;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XlAQf2Ibtm12b+KZygY6Ji2C7+MB9CbZRz0/L6B68HA=;
	b=TOscBnDgwsDdA1VojDuzj5HYWyDSymstz8MxEeX3HeBvEbT6qHTO2oTM+K+e0qkoVbzg
	 lHnrNaADwXQjsmLs8TqlVC4/6d31un/R3sZgay8M1kUkIjZ4XePSH0VqpqXYJHkjnyOau
	 JUkMPDp9B+oHetvQ2a6FlMARZXORFcZ2sHxiA1uqDe5ZYZJuERjdRDPy6i3k8V1MX0n5c
	 wIyDn2KznG638LrhEC3sg3HhJZ/fxqlZX7zjnlaf8xPbULPvM750DFQdmsbVbe2VnxWpV
	 us5MV9q4E0U30FmkVMKYTw3Pr4mPPOlWbs8Yr+eCWyL4DJ1IKPbTBOutKKhUULi1u5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jr6zdS56;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327F606A333;
	Mon, 16 Nov 2026 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jr6zdS56
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794788712;
	b=SuzaXLX8rwFwh9ofKIaqRcmLITHXW/Eh6tVlr8+qPVfodtFTF74iHFsYTswX5jqBp3V6
	 xmR4t0hLwtpAMFQIIytLeubdXMfA0bIM1bYDfZp+stKBRPen4XQLYvJlIMyNV5fl7jsMs
	 ISF/iwXx1eoXpN8eoslwZ8qt/CL5LcvQpi0d3fnusq9ZJ8ni4eBgMbF2KIL/uKe6XO5nH
	 LGctYghxoQuxwXC+MGGN68ApoxjUvFinh590Eou8r9cmiVys+C/LSLFPT+AtaFMX+UnWF
	 24NxJrfSMtxG73TpQs1shf3a4FB0rUsbMo5yuNNFTFdMuBoKZco6NfwS39SDkjX0HWw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794788712;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XlAQf2Ibtm12b+KZygY6Ji2C7+MB9CbZRz0/L6B68HA=;
	b=fl0f5zKzk314oEkEGC2mJv6V3D/+B0UuHrkHM0wa+X19m983nznwe+ov4/NvWvmvAPvU
	 1F/EA4SB/lDkqpvtp7AbOjrVSRVJmAt/WZ4j90RULRSEQCbxj1D/YOhvuB87AZ7CNaddo
	 e6+sc7sEOUlGQjHh2b9HPF+48LNTggCtc6pTYPpeGxP7FQLrHzk+PGCYPHUTlv0WX7Udx
	 Zzqxx9tmESEHkm5ldm4gS8UrFfb2ngnDnI95u3Qt8m5b19M7e+RWYJ6vYHaVAqS7AymQM
	 j/oqKCsPebl2nc/DzcyrAjbcApuRKxggyIJtS3r0tfAIFLVqX4aldayMF+1jH/B0HyA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6EC491F000C8;
	Mon, 16 Nov 2026 00:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794788712;
	bh=XlAQf2Ibtm12b+KZygY6Ji2C7+MB9CbZRz0/L6B68HA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jr6zdS5683V8li6KGrno4u47AUgJGy6oXHsXQxiHXULJo6c1io5PfYwhFeelYkjXF
	 EZI5l7kPTFBnUjDHAEuu79cz3LXvY9EzKdQmRv6HjGyRaHrMd0otqaxP/Q6+DXn038
	 HdwsLXTaD/dyCA7Z0C475DnNUUQvViOpajJpcC3Xq/ZSPF2mbSBAC22+4Ob5EomxIL
	 N0uHfrAmJHIGPiJhObeX/Xhli8Gieue6xQ5XOt82UkflNArMzJBdlkEYKOUoS0XjH2
	 bPN5iNNmuNXQHs+X1YEOZMUADN2DspBEzw10lik/KabbuLGkcaI7OWqnRwRBn3SVcN
	 UwzWp/7IblE9g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F37E34A29F;
	Mon, 16 Nov 2026 00:25:08 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 16 Nov 2026 00:25:03 +0000
Subject: [PATCH v2 4/8] alarmtimer: Register the platform device without a
 parent
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-b4-alarmtimer-rtc-priority-v2-4-b2c69721e489@iav.lv>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4346; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=tvo0ZSOLDAdXZO/UMf1yW8+MZjzf7553zgNk+6kP7fs=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFm/fBPDJh+4ujz7xBu1Sx3rbbj/Pv9rNcF0cmabp/jr7
 38Zlmxe0lHKwiDGxSArpsgy4ZDGrYwlV//6e5g/gJnDygQyhIGLUwAmUrOakeEbq8eqS3HN0npz
 tfztg3rbpgXHM75vWOZ4mX1DW0PVhPsMv9l5JgWEiPxWWv452OBax6d0e7MCOz/9r79ltGoZvC3
 W8QAA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

alarmtimer registers its platform device as a child of the wakeup RTC, so
the driver core suspends it before the RTC and alarmtimer_suspend() can
program the RTC. A device with one parent cannot be ordered against a
second RTC.

Register the device without a parent once the RTC is taken and add a
device link to the RTC, which keeps the device after the RTC in dpm_list
also when the RTC is moved there later, so it still suspends first.

Add links named after the suspend states, which point to the RTC that
wakes the system from that state. The names are those of
/sys/power/mem_sleep: in /sys/power/state "mem" stands for whichever
state mem_sleep selects, which can be s2idle.

The device moves from under the RTC to /sys/devices/platform, its name
stays alarmtimer.N.auto.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 kernel/time/alarmtimer.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 066d980fa6d5..4f87df95edcd 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 #include <linux/time_namespace.h>
 
 #include "posix-timers.h"
@@ -53,12 +54,14 @@ static struct alarm_base {
 /**
  * struct rtc_wakeup - State for waking the system from suspend on alarms
  * @rtc:		RTC programmed on suspend, NULL if none
+ * @pdev:		Device whose suspend and resume callbacks program the RTC
  * @timer:		RTC timer started on suspend
  * @freezer_expires:	Earliest expiry per alarm type of the clock_nanosleep()
  *			calls which the freezer interrupted, KTIME_MAX if none
  */
 struct rtc_wakeup {
 	struct rtc_device	*rtc;
+	struct platform_device	*pdev;
 	struct rtc_timer	timer;
 	ktime_t			freezer_expires[ALARM_NUMTYPE];
 };
@@ -71,6 +74,16 @@ static DEFINE_SPINLOCK(freezer_lock);
 #endif
 
 #ifdef CONFIG_RTC_CLASS
+/* Suspend state names as in /sys/power/mem_sleep */
+static const char * const alarmtimer_state_names[PM_SUSPEND_MAX] = {
+	[PM_SUSPEND_TO_IDLE]	= "s2idle",
+	[PM_SUSPEND_STANDBY]	= "shallow",
+	[PM_SUSPEND_MEM]	= "deep",
+};
+
+/* Bounds of suspend_state_t as integers for loops, bit masks and indices */
+#define ALARMTIMER_STATE_MIN	((__force int)PM_SUSPEND_MIN)
+#define ALARMTIMER_STATE_MAX	((__force int)PM_SUSPEND_MAX)
 
 /**
  * alarmtimer_has_rtcdev - Check whether an RTC can wake the system for alarms
@@ -83,10 +96,20 @@ bool alarmtimer_has_rtcdev(void)
 }
 EXPORT_SYMBOL_GPL(alarmtimer_has_rtcdev);
 
+/* Show in sysfs which RTC wakes the system from @state */
+static void alarmtimer_link_state(int state, struct device *dev)
+{
+	const char *name = alarmtimer_state_names[state];
+
+	if (sysfs_create_link(&wakeup_ctl.pdev->dev.kobj, &dev->kobj, name))
+		dev_warn(&wakeup_ctl.pdev->dev, "Cannot link %s to %s\n", name, dev_name(dev));
+}
+
 static int alarmtimer_rtc_add_device(struct device *dev)
 {
 	struct rtc_device *rtc = to_rtc_device(dev);
 	struct platform_device *pdev;
+	int state;
 
 	if (wakeup_ctl.rtc)
 		return -EBUSY;
@@ -96,22 +119,30 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 	if (!device_may_wakeup(rtc->dev.parent))
 		return -1;
 
-	pdev = platform_device_register_data(dev, "alarmtimer",
+	if (!try_module_get(rtc->owner))
+		return -1;
+
+	pdev = platform_device_register_data(NULL, "alarmtimer",
 					     PLATFORM_DEVID_AUTO, NULL, 0);
-	if (IS_ERR(pdev))
+	if (IS_ERR(pdev)) {
+		module_put(rtc->owner);
 		return PTR_ERR(pdev);
-
-	device_init_wakeup(&pdev->dev, true);
-
-	if (!try_module_get(rtc->owner)) {
+	}
+	/* Keep the device after the RTC in dpm_list, so it suspends first */
+	if (!device_link_add(&pdev->dev, dev, DL_FLAG_STATELESS)) {
 		platform_device_unregister(pdev);
-		return -1;
+		module_put(rtc->owner);
+		return -ENODEV;
 	}
+	device_init_wakeup(&pdev->dev, true);
+	wakeup_ctl.pdev = pdev;
 
 	WRITE_ONCE(wakeup_ctl.rtc, rtc);
 	/* Hold a reference so it doesn't go away */
 	get_device(dev);
 
+	for (state = ALARMTIMER_STATE_MIN; state < ALARMTIMER_STATE_MAX; state++)
+		alarmtimer_link_state(state, dev);
 	return 0;
 }
 

-- 
2.43.0


