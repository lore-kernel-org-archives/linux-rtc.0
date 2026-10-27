Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138764;
	b=L4taPPkjix2gMeLWYkYyNXy5v7cgwXNwVQTdUHJiSy+I2m01ZCmDA6GzpmWUX3Mu3wuo
	 VG7EfUKxCrvQ3OsxK82BsqbaaAdy/RksEWKksEfT47yfy7bdR5ExvkS4ivWjeb353Gils
	 HVyTPp1lEzr8UZZvAZPAED8Fq0FwyRkpeTLm3l6ZLhMGd60sZ77OSWBNXcfBlhvsDksVn
	 37UO24MD4PQObXXxEihOiwSamyIEWfY0mYgzWYdIYl8osc5BzByESGU02Fmsr5zPIVSA/
	 5bIs49ByaC5b6o7EP/mFSYYUfxXxyWXM+11aPVBUCa24FaUBo8x+C6caDDtQ/YEbTNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138764;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vySLIQQrOpRA/y5UBuyEyI6yVPpsYFavFBurV9vS+EM=;
	b=UB91gI335HMe6WS6oekbGK0ijD8RnUvw8PAqpqkdvVEupY1pnLdJLbQVeUcKIvAPgEW2
	 /aoNDDrofwJAoBhFlNnrk5kz+XD9Ck7d6CGO8brdZNfgtkF4O00dx5ojZJf3YAAaubOhC
	 VAvGscsiB0nIFVIQFua0ghWri9xw+fwNQkTY/N2O08j1fryPxE2HwZpHJtpjohnTqHKju
	 63DcYfJuOyX173vXYKbvUQ2lPz/asy7kuXPHw1i6r7njWxnBMa+42GlChZZzFgWU/vV7z
	 OS0OSeh+W/tjVg+C0kO4AE0PEhIux8YWnlCIhFIx0ZMFOMq1AJcS6jS6eKa/VR6F20A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=DF3QAxMp;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AE0606A31A;
	Tue, 27 Oct 2026 22:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5AE0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=DF3QAxMp
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id A60F620B7167; Tue, 27 Oct 2026 15:05:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A60F620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793138752;
	bh=vySLIQQrOpRA/y5UBuyEyI6yVPpsYFavFBurV9vS+EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DF3QAxMp0/D36bfmk6H5BrtWgkH6wJgWDEKu7XxzbMFe8TtG42fJrz+wFK12odAN/
	 1qpaDuPG6KNuHHUDr7nlUVQvIwhc+y5n9zeozRY52vVgQUyyeIcwaXKA4QrJhLPHvr
	 3RYWc/Ujb3bpu/5QJx0PXmInwq/VoKN//Cwbjm4U=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-acpi@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH v4 1/2] ACPI: TAD: introduce acpi_has_rtc()
Date: Tue, 27 Oct 2026 18:05:35 -0400
Message-ID: <20261027220537.3443104-2-hamzamahfooz@linux.microsoft.com>
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
Reviewed-by: Ard Biesheuvel <ardb@kernel.org> (v3)
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/acpi/acpi_tad.c | 48 ++++++++++++++++++++++++++++++++++++-----
 include/linux/acpi.h    |  6 ++++++
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 45459a4ca..a07f4f4fd 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -622,9 +622,52 @@ static const struct attribute_group acpi_tad_group = {
 
 __ATTRIBUTE_GROUPS(acpi_tad);
 
+static const struct acpi_device_id acpi_tad_ids[] = {
+	{"ACPI000E", 0},
+	{}
+};
+
 #ifdef CONFIG_RTC_CLASS
 /* RTC class device interface */
 
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
+	if (acpi_disabled)
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
 static void acpi_tad_rt_to_tm(struct acpi_tad_rt *rt, struct rtc_time *tm)
 {
 	tm->tm_year = rt->year - 1900;
@@ -894,11 +937,6 @@ static int acpi_tad_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct acpi_device_id acpi_tad_ids[] = {
-	{"ACPI000E", 0},
-	{}
-};
-
 static struct platform_driver acpi_tad_driver = {
 	.driver = {
 		.name = "acpi-tad",
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddacac812..74c60b8e8 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1553,6 +1553,12 @@ extern bool acpi_has_watchdog(void);
 static inline bool acpi_has_watchdog(void) { return false; }
 #endif
 
+#if IS_REACHABLE(CONFIG_ACPI_TAD) && IS_ENABLED(CONFIG_RTC_CLASS)
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

