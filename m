Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028085;
	b=fMrvAhHjrXL4gBuqdEIr/9Oq7XroSEOlPX9UGvLSvU9hwTfI8MAqAh3Z+erlrUbMM6+w
	 y1TjiAv5Na2yp/yw83zzMhYiR8l6Rp22wizK+lA2vA4KjMxz8cE3QQGOMDobEBc7nmiX7
	 ptx4UfIM4PWSj1UpnVZHqyvw/zULymOAkIskYojMslhuGqFNxaJegW9c94PGlDOoVhe1Z
	 Of1NDqg4PuGYvGragKJ88LycgC/XQABiMWCTDVg9LCLANG2ekdBm3VOCFx1RzRgFxviW0
	 GmqA9IM2dotpBiYNOxVinMzHYKyf5LTIE01LtFST7C1tA6YMm470y63DDdNkUqCfd2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028085;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wnqWoArvApXsZcTquK3G7lUG6iX/ZxNajVnIGNzRhE8=;
	b=p1DFyCsL5bDsn203KuEx9oiUgnA8OLv0Se7Vj9ALoLGO5iNxSWmmE9e9xYyKe2G00v5F
	 WokxvLbzAUQ2T9AShS809Lg5kT6jYXZrbFLYnhzZnkLfckRYfKiDm8XValknsua4r+SvG
	 XDvChMj1qFJ0iyCuXnkxin2Y0fPYurfPDynixIuvnkJse4u0I2bLb0tWoNDRu4480B1Nx
	 iSERfovm+6AUexPxAsyaTIpbzta3SHHbNjawT2Y5Z6oLWvi0P+fkWnsoaezCOCI5NjlJq
	 zcAofZj+RMNz565P/umEz4NnbVLYpubjtpgilxwvUWhgHWXMydjvi059HkFz243uDhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="hMG/mlMH";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366C3606A31B;
	Mon, 26 Oct 2026 15:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 366C3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hMG/mlMH
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id A2E9D20B7166; Mon, 26 Oct 2026 08:21:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A2E9D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793028074;
	bh=wnqWoArvApXsZcTquK3G7lUG6iX/ZxNajVnIGNzRhE8=;
	h=From:To:Cc:Subject:Date:From;
	b=hMG/mlMHOxO6A+UMV4jv7vORveV+tH0P60V8TkhxDxYtvSbTxuflQfnQiALNGXt7o
	 hPzhY02YV9IqB7bM48ESof8RWpt/i9NFIJX44Pv7swxq3SLMxEEFKQNG3Z/7A1kuqB
	 fTpHC8xT9t2D0mogoh4LCCNmyxpSxscvF30w5gaU=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-acpi@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 1/2] ACPI: TAD: introduce acpi_has_rtc()
Date: Mon, 26 Oct 2026 11:21:02 -0400
Message-ID: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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

The same RTC may also be accessible by other means, like the EFI
GetTime() and SetTime() runtime services used by rtc-efi, which are best
avoided if there is a native ACPI interface to the RTC.

To allow other RTC drivers to stand down in that case, add an exported
helper, acpi_has_rtc(), that returns true if there is a TAD the driver
will register an RTC class device for.

The helper looks for a platform device matching the driver's ID table
whose _GCP indicates real time support, like acpi_tad_probe() checks,
instead of checking whether the driver has bound to such a device, so
that callers need not depend on the order in which drivers are probed.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v1: https://lore.kernel.org/r/20261022211304.2285792-1-hamzamahfooz@linux.microsoft.com/
v2:
- Rename acpi_tad_rtc_available() to acpi_has_rtc(), move it to within
  acpi-tad (which allows us to simplify it quite a bit) and declare it
  in linux/acpi.h. (Ard)
- Add acpi_disabled check. (Ard)
---
 drivers/acpi/acpi_tad.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h    |  6 ++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 45459a4ca..eea4d2123 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -899,6 +899,44 @@ static const struct acpi_device_id acpi_tad_ids[] = {
 	{}
 };
 
+static int acpi_tad_rtc_match(struct device *dev, const void *data)
+{
+	unsigned long long caps;
+	acpi_status status;
+
+	if (!acpi_match_device(acpi_tad_ids, dev))
+		return 0;
+
+	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_GCP", NULL, &caps);
+
+	return ACPI_SUCCESS(status) && (caps & ACPI_TAD_RT);
+}
+
+/**
+ * acpi_has_rtc - Check if the RTC should be driven via the ACPI TAD
+ *
+ * Check if there is a TAD implementing the real time methods that this driver
+ * will register an RTC class device for.
+ *
+ * Return: %true if the RTC should be driven via the ACPI TAD, %false otherwise.
+ */
+bool acpi_has_rtc(void)
+{
+	struct device *dev;
+
+	if (acpi_disabled || !IS_ENABLED(CONFIG_RTC_CLASS))
+		return false;
+
+	dev = bus_find_device(&platform_bus_type, NULL, NULL,
+			      acpi_tad_rtc_match);
+	if (!dev)
+		return false;
+
+	put_device(dev);
+	return true;
+}
+EXPORT_SYMBOL_GPL(acpi_has_rtc);
+
 static struct platform_driver acpi_tad_driver = {
 	.driver = {
 		.name = "acpi-tad",
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddacac812..71524a821 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1553,6 +1553,12 @@ extern bool acpi_has_watchdog(void);
 static inline bool acpi_has_watchdog(void) { return false; }
 #endif
 
+#if IS_REACHABLE(CONFIG_ACPI_TAD)
+bool acpi_has_rtc(void);
+#else
+static inline bool acpi_has_rtc(void) { return false; }
+#endif
+
 #ifdef CONFIG_ACPI_SPCR_TABLE
 extern bool qdf2400_e44_present;
 int acpi_parse_spcr(bool enable_earlycon, bool enable_console);
-- 
2.56.0

