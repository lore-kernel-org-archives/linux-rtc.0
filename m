Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790564;
	b=44C94O3iv2foGUZSUUd39bofH2wH1SSn4pRObKkW+SSEv9H2YowWY0gtKO5b170eFtu3
	 aWs4MkNXwLWOgdOxABgiYiWs2e6EZKLGSvlYKt5j5jiaZFWHy1udKv53aM63vOiLppoT2
	 2uK/hXBA3rp1bw9OFS9+AFcn0MlsZepTdBMAFx43O958nxUvPS8voTB2jEt10sdgxjsBS
	 3f3KLO3fn26na6h3mlc/ODTWcJD6wvzzK/Mg+d/2giVnC81nDwUHXT34GXlWcS3Hw9U2D
	 ZGVr3CY3YwJKLjxFykH7+aTbd1W2QDI/Aomr7U5HYmwYh5fLpX2MC/XddFhhoW/7mPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790564;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DWB7Q9AGkHFXEvrl+JFV7Yws8hWXExYTFNUP8bCWHAg=;
	b=QfyhUAxWH8A0qiSPkdGYI2AIbd1LfqlwRZjEa9rStHBJjxY1i5NAHcxF3h1P0MvDNmQL
	 ahTv+xXix+T766VHkBmZ+xy1MtkhlhCCU7bUC0a3hgEAmLS9q+ZzpmFGl3qfmukPfmQYJ
	 yJA9ZYbVx4xNWTPFe/a7OZSs0O+lg2IOvFNwUJzAMwvVVTuuL7pUOYTOMB2UMjdgl6EuV
	 MgoUmKOpfoDyK+G3SDKJKWfy/1YJWLDCxBbzP+yY68DIvft+2iaA0sFXgL5o7SAIuLNIp
	 nVBcayShw6/I2Nt3gRQeiEoVwOrESDb449iXiV9HQc5ZMupJalRKziwE8WhQvgHF9oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=kq06C8Sz;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B711C606A31B;
	Fri, 23 Oct 2026 21:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B711C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=kq06C8Sz
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id A51A320B7167; Fri, 23 Oct 2026 14:22:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A51A320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792790554;
	bh=DWB7Q9AGkHFXEvrl+JFV7Yws8hWXExYTFNUP8bCWHAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kq06C8SzB9xiYSaFfUy8O45Jml0g7hMTr7Stdd6zKv/E7Ys107hOVPx6ll92QiP5t
	 d2BCWUWLXgVr4mpNcNWfvE/6NvySAcsDzUjZZ9RHyMJ+M7HbdvG3d9Hi4T1OA8kEyY
	 wSVHjWnpYgPTiJqf8vgS/A3aCbhxwuhEh/CnJB5Y=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-acpi@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 2/2] rtc: efi: defer to the ACPI TAD if it can drive the RTC
Date: Fri, 23 Oct 2026 17:22:18 -0400
Message-ID: <20261023212218.2568858-2-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023212218.2568858-1-hamzamahfooz@linux.microsoft.com>
References: <20261023212218.2568858-1-hamzamahfooz@linux.microsoft.com>
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
when ACPI is enabled, make RTC_DRV_EFI depend on ACPI_TAD.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v1: https://lore.kernel.org/all/20261022211304.2285792-2-hamzamahfooz@linux.microsoft.com/
v2:
- Make rtc-efi decline to probe instead of not registering the device in
  efisubsys_init(). (Ard)
- Make RTC_DRV_EFI depend on !ACPI || ACPI_TAD. (Ard)
---
 drivers/rtc/Kconfig   | 4 ++++
 drivers/rtc/rtc-efi.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 1e863f1d3..26f057f52 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1262,10 +1262,14 @@ config RTC_DRV_DA9063
 config RTC_DRV_EFI
 	tristate "EFI RTC"
 	depends on EFI && !X86
+	depends on !ACPI || ACPI_TAD
 	help
 	  If you say yes here you will get support for the EFI
 	  Real Time Clock.
 
+	  On ACPI systems, the ACPI Time and Alarm Device (TAD) driver
+	  is used instead of this one if the TAD can drive the RTC.
+
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-efi.
 
diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index a8c18ebc5..de4821c9b 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -252,6 +253,9 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 	efi_time_cap_t cap;
 	efi_bool_t enabled, pending;
 
+	if (acpi_has_rtc())
+		return -ENODEV;
+
 	/* First check if the RTC is usable */
 	if (efi.get_time(&eft, &cap) != EFI_SUCCESS)
 		return -ENODEV;
-- 
2.56.0

