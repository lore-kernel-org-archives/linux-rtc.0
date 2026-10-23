Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790564;
	b=sYuOpZ0Nl2lZD/OhRrWV5Z4UZjnRiDwiuTkRyhdNjar/YIPReC2H4/uVrksw8OdLH9We
	 3CYusckFrVj0yDB32uIrBQOSntZrP8cxzjSapd15a3STEpqtkdBeFNsrF6Qyhrg/pDxSJ
	 mWhXg+XD+g3QVfLDUQaQWo2A4QjCYdG5WE0TVl0Js2Zx8OPc3XKeFdV+z3/sH7gRw2P+z
	 WPUrtEgnHIR4SHPZ3bYj+A1LZOANoEWsMgm+PEa/kX+PD9QwZ9HAKM35+1qsiwlf8gsJ6
	 u86ZXqSeaffArGwBHof4Uz09DkpXYB8Ar+tyzurNQc/+oUanXYwhfDST4tmN8McbtQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790564;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ke0XSiZ4oYSlaCCW2Fthf7wat5z6FbusnAW3kB6VH78=;
	b=FrmQEljHZ8uvQBOrSr5X3TU0lTRY8aZKJhjOZ3Poh6GV+9l9KMo/64tTZwJiljbW4QT3
	 l6Fq8817HXblQ6ExrEdlJot/K5IVk8uVJgUnm3ckjDUai8BVkaX77Voq+vOCYyQVrljlR
	 7AuSNfoC4YO+m1D1zCezw4KqzqzBER/f1+xMnuLkh1QRfoV+fRzCXavpj+u4Mk0e9uCR8
	 XcgWg08YAtrDfaR/aUPFXa+Z/A+50t8DHd8QZ6lNlavor5hFpbu+q50Hn6Io/Gh6XrN5A
	 JKf2f4nwZq2EBbhkSGt/yNqWkQZC0QK+Ye/Oe/RIzeJSX5beZo/Xh2goGbDYEUKVaGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="dn/UjKYP";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FC8606A31A;
	Fri, 23 Oct 2026 21:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6FC8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=dn/UjKYP
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 97E8820B7166; Fri, 23 Oct 2026 14:22:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 97E8820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792790554;
	bh=ke0XSiZ4oYSlaCCW2Fthf7wat5z6FbusnAW3kB6VH78=;
	h=From:To:Cc:Subject:Date:From;
	b=dn/UjKYPl4TfT1qzxKnwayzRTwujFj4EKyMeXZU91Wp/YmB/TerV6SELC554+vxGK
	 hvMvXO+gRnjEHpycN0LzPv+P/s+s4JJPT6JHy6vE1rhDeKqamV7LJBmztKqQDm+nHw
	 8gR5MOYeWjwNoZHQblgzY6uvR/+kXTmpHVFLVVgg=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-acpi@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 1/2] ACPI: TAD: introduce acpi_has_rtc()
Date: Fri, 23 Oct 2026 17:22:17 -0400
Message-ID: <20261023212218.2568858-1-hamzamahfooz@linux.microsoft.com>
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
index 9d3f039eb..636e5218c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1548,6 +1548,12 @@ extern bool acpi_has_watchdog(void);
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

