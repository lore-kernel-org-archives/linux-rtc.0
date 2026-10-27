Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138765;
	b=wuRHucHiWvxsdK/RtprvFoDnUKPlVs3JR6beVQlc4NXBI9iSRIXG66YwgzgPfZgLFz8q
	 6Vl010BQzjRPpav3XdlIQxthAtxJwDREaLkXHz7VKvuxp0EYOrgJGyRuOnO6ge62ypDp7
	 diWTRnZCObIt0Jpgt4q6XNVFMGlc6N3eifw3I4XGDkd+89jDGb7iWtSqjYzTEe+/PmW6h
	 /X8i5Vu89Fzylm6YOF9gOQreCqOxYOO2QFvVcksDXA72Z0LFb+xWxf5jQYIu8iQe4HPPl
	 l1vFQRb++2reHUVxaviEl7giH1Rv9F68fsBijqsQbrfrf0WMpr1TK+fdwrGAa9USuYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138765;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EdTGR0aS5MtrIn073ZxWN4yoNDx+hkXtcxsXCc7onhI=;
	b=DRCMzZVZ844087Xy6UaX5iqXZuKT6TzIiYfOmQKEigokyA/8yxr+eVx0i5KRrZgdKMsf
	 Snl+goxxlbdIOCxjOrSmVoCzQLkD47M5eIYzlBQD5H1RGDtV04uP8imIOJTItWU/dCjLm
	 Q0IVk2w/X7dnJG62Lz3Bc9+umL153leaWjV1B1BV2KHSLooOPU4QOoXQcqdwsV5RVSdgq
	 YsuFlrh+5WPBkFHMaSRIeoqqwTaR7UEpotXfR6Jxge0adVXrcpmmO1G4xS5MkCYHaZyG1
	 9jg9NkS3D9kk+6NiuZBbPkhiKQ8bPdlGTOYzwD7ux/0t6FyN2iLz4fuZvbhnAqVj/1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=UrwHp2UG;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C22606A31E;
	Tue, 27 Oct 2026 22:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5C22606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=UrwHp2UG
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id B2BFA20B7168; Tue, 27 Oct 2026 15:05:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2BFA20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793138752;
	bh=EdTGR0aS5MtrIn073ZxWN4yoNDx+hkXtcxsXCc7onhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UrwHp2UG5iy5ntvyM2xpfRPvREqNWE+uC9uNjupp5m3W6eUnqUZemg0Wyf/LAkyYu
	 pB9rSMn/ZKHomr2l+jBxkgqU5E1MqWsNnqfDlPmWfcaPKHqzjwU2Y3Bv9yHoEN9+kY
	 /LpjQi/FXBEXq2sSeNapgpOsR1S0wrbJRKktKXss=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-acpi@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH v4 2/2] rtc: efi: defer to the ACPI TAD if it can drive the RTC
Date: Tue, 27 Oct 2026 18:05:36 -0400
Message-ID: <20261027220537.3443104-3-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261027220537.3443104-1-hamzamahfooz@linux.microsoft.com>
References: <20261027220537.3443104-1-hamzamahfooz@linux.microsoft.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EFI runtime services are best avoided where possible, and ACPI defines a
standard interface to the RTC in the form of the Time and Alarm Device
(TAD), which the acpi-tad driver has been exposing as an RTC class
device since commit 8a1e7f4b1764 ("ACPI: TAD: Add RTC class device
interface").

So, make rtc-efi decline to probe, before calling GetTime(), if
acpi_has_rtc() says that the RTC can be driven via the TAD.

Also, to ensure that acpi_has_rtc() is always reachable from rtc-efi
when ACPI_TAD is enabled, make RTC_DRV_EFI depend on
ACPI_TAD || !ACPI_TAD.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/rtc/Kconfig   | 5 +++++
 drivers/rtc/rtc-efi.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 1e863f1d3..5b7e9d2a8 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1262,10 +1262,15 @@ config RTC_DRV_DA9063
 config RTC_DRV_EFI
 	tristate "EFI RTC"
 	depends on EFI && !X86
+	depends on ACPI_TAD || !ACPI_TAD
 	help
 	  If you say yes here you will get support for the EFI
 	  Real Time Clock.
 
+	  On ACPI systems, the ACPI Time and Alarm Device (TAD) driver
+	  is used instead of this one if the TAD can drive the RTC (assuming
+	  it's enabled).
+
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-efi.
 
diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index b4f44999e..545b21b17 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -192,6 +193,9 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 	efi_time_t eft;
 	efi_time_cap_t cap;
 
+	if (acpi_has_rtc())
+		return -ENODEV;
+
 	/* First check if the RTC is usable */
 	if (efi.get_time(&eft, &cap) != EFI_SUCCESS)
 		return -ENODEV;
-- 
2.56.0

