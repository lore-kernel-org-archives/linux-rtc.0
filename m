Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD72EDD7D;
	Mon, 23 Feb 2026 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860844; cv=none; b=GJtM6yAeGQ+xDQZ3CJp/+NKoLou3VGznJobHVjbEfaXJzC+lTJk61alD2ijJ7yUdYe9uFgE+/kBZqUfC6THqwR3oGWWSJTGmHZCYcrpp3/oNbiEWPr1dung6JpId3q2EoI257fGkUhNyNqxpwD0ZAxg9djvX+3MJSayEJ9e75M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860844; c=relaxed/simple;
	bh=1P6a0/lYu7VTCktfcaeO7oH0q+boqRyuVN3mhuLyv+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgBys7D1llGht0zoPp/HCSEpG9v+OjpIvDX8oFju4/nZN+uSKZ0Y2kQ89uSNr0K5ShjkdrUuZOTZXzy3QsFCwMsS78WF2PGX/xraee/Nyh22VVfAjrFx/VOFpLSKHE7HBI5QnF552d7bdz6Zg/44siRorXFAJkLbRfKOnpsvjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a831mw6W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a831mw6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EF5C116C6;
	Mon, 23 Feb 2026 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860844;
	bh=1P6a0/lYu7VTCktfcaeO7oH0q+boqRyuVN3mhuLyv+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a831mw6WaD/pMWsKssEfBVdLc/R1uo593RErJsmy8AvGBcIUd4Bc4guKmGHu5JE3o
	 gRhOXb9jOiBMvYNIwbbwD8t6//0xfoxPMr8PInGHbdOHG/bsHG7jrxiiwUJbaJPmKb
	 fDcOcwD8bau0YVyBq6crCmGTMBjf8P6L1MtjttlNDH2uVqDeErq1tOPfzM13JTmcrl
	 B9q/1qW3jn9LgJT52NpJ/qo5DYzDTSkkCx1MbyT5kyjWSlFftNnNOtKW5gpjIueYXS
	 scOwmGqmTrx0evx3oY1mOt1zWyCYj9QkgDkfkKhz1g5q71j0CVMXgthbPg//OWBiOY
	 CFzPxZ5fVtA5g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 3/8] ACPI: x86: cmos_rtc: Create a CMOS RTC platform device
Date: Mon, 23 Feb 2026 16:29:37 +0100
Message-ID: <1962427.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5983325.DvuYhMxLoT@rafael.j.wysocki>
References: <5983325.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Make the CMOS RTC ACPI scan handler create a platform device that will
be used subsequently by rtc-cmos for driver binding on x86 systems with
ACPI and update add_rtc_cmos() to skip registering a fallback platform
device for the CMOS RTC when the above one has been registered.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/rtc.c       | 4 ++++
 drivers/acpi/x86/cmos_rtc.c | 8 ++++++++
 include/linux/acpi.h        | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 51a849a79c98..b112178e8185 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -2,6 +2,7 @@
 /*
  * RTC related functions
  */
+#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/mc146818rtc.h>
 #include <linux/export.h>
@@ -146,6 +147,9 @@ static __init int add_rtc_cmos(void)
 		}
 	}
 #endif
+	if (cmos_rtc_platform_device_present)
+		return 0;
+
 	if (!x86_platform.legacy.rtc)
 		return -ENODEV;
 
diff --git a/drivers/acpi/x86/cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
index 45db7e51cbe6..bdd66dfd4a44 100644
--- a/drivers/acpi/x86/cmos_rtc.c
+++ b/drivers/acpi/x86/cmos_rtc.c
@@ -24,6 +24,8 @@ static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
 	{}
 };
 
+bool cmos_rtc_platform_device_present;
+
 static bool cmos_rtc_space_handler_present __read_mostly;
 
 static acpi_status acpi_cmos_rtc_space_handler(u32 function,
@@ -103,6 +105,12 @@ static int acpi_cmos_rtc_attach(struct acpi_device *adev,
 	if (ret < 0)
 		return ret;
 
+	if (IS_ERR_OR_NULL(acpi_create_platform_device(adev, NULL))) {
+		pr_err("Failed to create CMOS-RTC platform device\n");
+		return 0;
+	} else {
+		cmos_rtc_platform_device_present = true;
+	}
 	return 1;
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d2f0bed7a06..2bdb801cee01 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -791,6 +791,8 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 int acpi_mrrm_max_mem_region(void);
 #endif
 
+extern bool cmos_rtc_platform_device_present;
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
@@ -1116,6 +1118,8 @@ static inline int acpi_mrrm_max_mem_region(void)
 	return 1;
 }
 
+#define cmos_rtc_platform_device_present	false
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HMAT
-- 
2.51.0




