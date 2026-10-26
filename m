Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028087;
	b=d7HRL7V8CkcPkfjbdvoPgNCmUUGqpOqZFle5C7HIWGv5B/7+Yzxt61KC4spjpVsmi1y7
	 wXLUA4LKds1SBjLfRicW3vQVBSfWts4MimxYS5qEC+Jwh9H9OTyubDCEh/Yx7SbbTFKBC
	 Ui3yhyYW6Mr1avzFLkKP2nEzw4PGVoU5Cxhils7/+zhHpymDuGXutUKVGjbiO1ssFdkae
	 blK5zS6HixbiqMLGl6amjt2PelKdDZekTjuNCrei/X7rPCG4PlFaJ3spNdRK/x064S/FV
	 Rda4uzM0ZpxIasCwFyHKcRcIXDP0a9vrNiyExvpdGk/K+7b0HZXEMQmzI8sRft32tSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028087;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6VDvLoZWuvgN2OYRMxTZqzvsa3WKKpFqAuaBLVuQc8c=;
	b=Jpaay1Yy97PSXLGPSUwA8r6jMdw4epy0sHcEb2dOSUiRUek9/E3SLjW3nUJFsBdkpLAm
	 IlAOmvY85aj+34/mbgrbQSAVWbA8oUQumzdU4g2E7MQNDCZfAGlRis9oF5oR23M7kIF9a
	 vW7xe5zdg2c6Yede4wOYjaYnYXl+MlyafjajWofDTUaPwLD7edgpaNymVWElzpAuDXh1/
	 ue7vvE9k5Ii0hcIYEKLfpCpLt8j5dbCgdD3uPEDPyPyefu2MmgE0w57DZlAv9rJm75tem
	 HLPkAhnhxCLqgU41l5GjFQf1mX8b+46EoeABcW3h91C4Rqdafq6V4XnYMWaYFRmoRJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=PMviRRDc;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14C606A31B;
	Mon, 26 Oct 2026 15:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B14C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=PMviRRDc
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 88B2220B7167; Mon, 26 Oct 2026 08:21:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88B2220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793028076;
	bh=6VDvLoZWuvgN2OYRMxTZqzvsa3WKKpFqAuaBLVuQc8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMviRRDcfp0HaWvyYWj9Ck2TPs9/InB+6s+jEaHRrBOdiHqk22mulfMNVIDNKy9o3
	 C3BJveAqltndEJ9fC0UtNQjxv5Fjwk9KtDUT20MOg0TcLzSLdvZ6tzNWQLvnM7xnG9
	 aWO+Lp8ZFTHtYGBBsTrmB6xadCghPtcW7Xy7eEK0=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-acpi@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 2/2] rtc: efi: defer to the ACPI TAD if it can drive the RTC
Date: Mon, 26 Oct 2026 11:21:03 -0400
Message-ID: <20261026152103.3109313-2-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
References: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
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
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v1: https://lore.kernel.org/all/20261022211304.2285792-2-hamzamahfooz@linux.microsoft.com/
v2:
- Make rtc-efi decline to probe instead of not registering the device in
  efisubsys_init(). (Ard)
- Make RTC_DRV_EFI depend on !ACPI || ACPI_TAD. (Ard)
v3: Make RTC_DRV_EFI depend on ACPI_TAD || !ACPI_TAD. (Sashiko)
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

