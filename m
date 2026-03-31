Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0AD38BF70;
	Tue, 31 Mar 2026 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774985949; cv=none; b=qNP71uqCYd9v3G6sc1XzMQLJ04FpRpnM4LtsPVLBhbw4Vj4Wz1A083WQRJlJaLSCiWyCYP+oMJO4jEZjrX9TJg0mi2gGfM6TkvbOGo3fqf1H9j+VNjYNpR540OJ1UnltwjXXoWQUdj46Zy8AgaM6thYSVeYUwQNVlxItNvLJTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774985949; c=relaxed/simple;
	bh=1dZWLCLTqRn4kT22XtcWM27dvqDrG6ZgNQNmZWjQR50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcoXxRk2otkFdXpar+TJQ8X/F7+eE0wyyeJvpAXWXWYof7si/RB6TMsUXMGbQsvzTsOsjixn+qC+8JlrZ3W35bVTse7xqJy8a/PyXaLQP4/bW9J+CPIHTxO1mCaxdamxIcmyUY4WM4B/9nKuMYPNlxJQ2x9U3jFLgGaM0K26N7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLX3joYc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLX3joYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F385AC19423;
	Tue, 31 Mar 2026 19:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774985949;
	bh=1dZWLCLTqRn4kT22XtcWM27dvqDrG6ZgNQNmZWjQR50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLX3joYcgDmxp8j1gAlGAsP4fSTijdZFWruaDvwHVNL9KwN103Vz0BqxECHxCEgdX
	 j4Y1dlcrjOyBZ2fQBpWfoLMJedC1wC8i8SF4j2AnoqVSqaRzYrprk4PeijGrumQK4Z
	 UNsClVF1ZnfzLmr4YfLYxmZppw5BwyUw8i//effCRydUa4M6jPWYzsHb8C/AMlnfd4
	 v5B5MkXycpv7SY6x3nwZ1QrDLMlZ+DJU3YnwSUqo06+bBzzXL6spAKBat+HmoHSGUp
	 JrBTRq7zFeyZMwb2+pI8FhG50Pc94Dwwc83PgVg77n7ns7NT5FE+vvSNJotsceWWnb
	 A3rZfK0q53lOA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject:
 [PATCH v1 4/4] ACPI: TAD: Add alarm support to the RTC class device interface
Date: Tue, 31 Mar 2026 21:38:52 +0200
Message-ID: <2076980.usQuhbGJ8B@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2366642.iZASKD2KPV@rafael.j.wysocki>
References: <2366642.iZASKD2KPV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add alarm support, based on Section 9.17 of ACPI 6.6 [1], to the RTC
class device interface of the driver.

The ACPI time and alarm device (TAD) can support two separate alarm
timers, one for waking up the system when it is on AC power, and one
for waking it up when it is on DC power.  In principle, each of them
can be set to a different value representing the number of seconds
till the given alarm timer expires.

However, the RTC class device can only set one alarm, so it will set
both the alarm timers of the ACPI TAD (if the DC one is supported) to
the same value.  That is somewhat cumbersome because there is no way in
the ACPI TAD firmware interface to set both timers in one go, so they
need to be set sequentially, but that's how it goes.

On the alarm read side, the driver assumes that both timers have been
set to the same value, so it is sufficient to access one of them (the
AC one specifically).

Link: https://uefi.org/specs/ACPI/6.6/09_ACPI_Defined_Devices_and_Device_Specific_Objects.html#time-and-alarm-device [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 3 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -25,6 +25,7 @@
 
 #include <linux/acpi.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -658,12 +659,113 @@ static int acpi_tad_rtc_read_time(struct
 	return 0;
 }
 
+static int acpi_tad_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct acpi_tad_driver_data *dd = dev_get_drvdata(dev);
+	s64 value = ACPI_TAD_WAKE_DISABLED;
+	struct rtc_time tm_now;
+	struct acpi_tad_rt rt;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	if (t->enabled) {
+		/*
+		 * The value to pass to _STV is expected to be the number of
+		 * seconds between the time when the timer is programmed and the
+		 * time when it expires represented as a 32-bit integer.
+		 */
+		ret = __acpi_tad_get_real_time(dev, &rt);
+		if (ret)
+			return ret;
+
+		acpi_tad_rt_to_tm(&rt, &tm_now);
+
+		value = ktime_divns(ktime_sub(rtc_tm_to_ktime(t->time),
+					      rtc_tm_to_ktime(tm_now)), NSEC_PER_SEC);
+		if (value <= 0 || value > U32_MAX)
+			return -EINVAL;
+	}
+
+	ret = __acpi_tad_wake_set(dev, "_STV", ACPI_TAD_AC_TIMER, value);
+	if (ret && t->enabled)
+		return ret;
+
+	/*
+	 * If a separate DC alarm timer is supported, set it to the same value
+	 * as the AC alarm timer.
+	 */
+	if (dd->capabilities & ACPI_TAD_DC_WAKE) {
+		ret = __acpi_tad_wake_set(dev, "_STV", ACPI_TAD_DC_TIMER, value);
+		if (ret && t->enabled) {
+			__acpi_tad_wake_set(dev, "_STV", ACPI_TAD_AC_TIMER,
+					    ACPI_TAD_WAKE_DISABLED);
+			return ret;
+		}
+	}
+
+	/* Assume success if the alarm is being disabled. */
+	return 0;
+}
+
+static int acpi_tad_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	unsigned long long retval;
+	struct rtc_time tm_now;
+	struct acpi_tad_rt rt;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	ret = __acpi_tad_get_real_time(dev, &rt);
+	if (ret)
+		return ret;
+
+	acpi_tad_rt_to_tm(&rt, &tm_now);
+
+	/*
+	 * Assume that the alarm was set by acpi_tad_rtc_set_alarm(), so the AC
+	 * and DC alarm timer settings are the same and it is sufficient to read
+	 * the former.
+	 *
+	 * The value returned by _TIV should be the number of seconds till the
+	 * expiration of the timer, represented as a 32-bit integer, or the
+	 * special ACPI_TAD_WAKE_DISABLED value meaning that the timer has
+	 * been disabled.
+	 */
+	ret = __acpi_tad_wake_read(dev, "_TIV", ACPI_TAD_AC_TIMER, &retval);
+	if (ret)
+		return ret;
+
+	if (retval > U32_MAX)
+		return -ENODATA;
+
+	t->pending = 0;
+
+	if (retval != ACPI_TAD_WAKE_DISABLED) {
+		t->enabled = 1;
+		t->time = rtc_ktime_to_tm(ktime_add_ns(rtc_tm_to_ktime(tm_now),
+						       (u64)retval * NSEC_PER_SEC));
+	} else {
+		t->enabled = 0;
+		t->time = tm_now;
+	}
+
+	return 0;
+}
+
 static const struct rtc_class_ops acpi_tad_rtc_ops = {
 	.read_time = acpi_tad_rtc_read_time,
 	.set_time = acpi_tad_rtc_set_time,
+	.set_alarm = acpi_tad_rtc_set_alarm,
+	.read_alarm = acpi_tad_rtc_read_alarm,
 };
 
-static void acpi_tad_register_rtc(struct device *dev)
+static void acpi_tad_register_rtc(struct device *dev, unsigned long long caps)
 {
 	struct rtc_device *rtc;
 
@@ -676,10 +778,14 @@ static void acpi_tad_register_rtc(struct
 
 	rtc->ops = &acpi_tad_rtc_ops;
 
+	if (!(caps & ACPI_TAD_AC_WAKE))
+		clear_bit(RTC_FEATURE_ALARM, rtc->features);
+
 	devm_rtc_register_device(rtc);
 }
 #else /* !CONFIG_RTC_CLASS */
-static inline void acpi_tad_register_rtc(struct device *dev) {}
+static inline void acpi_tad_register_rtc(struct device *dev,
+					 unsigned long long caps) {}
 #endif /* !CONFIG_RTC_CLASS */
 
 /* Platform driver interface */
@@ -765,7 +871,7 @@ static int acpi_tad_probe(struct platfor
 	pm_runtime_suspend(dev);
 
 	if (caps & ACPI_TAD_RT)
-		acpi_tad_register_rtc(dev);
+		acpi_tad_register_rtc(dev, caps);
 
 	return 0;
 }



