Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8218FDBD;
	Mon, 23 Feb 2026 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860848; cv=none; b=DMAjv+/TNdKLSBVAd3zM49O+8sahWRIwgLnWQxjcmBRL24JthJ27IroygnwfTlo6ZND67I0dby63qkdGBajAjgQAthR4lL2mAOeaGLNmp30N9aeo7/U/s9U6gM6DW4wtZbV4Bw9NBBSO/J/6BYlwb1Jhxvi5F9QC/KoCyI3sw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860848; c=relaxed/simple;
	bh=ZA0boE6qtemyVmA9NXSmN2YpHL0KV9TUebxR3N6eSYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CID258+M2Bv58ZMJiHDGrf/G5ZnFebkxE03W+nlHJ4jDTRVWM6mVyKx7YzoAunt3Xw3nZGQT4ymQ8qkJgPGhEs7nGaJuJHg+AonOseTfnInS/CZcF/+LluFlEPjxmfsv2bkjwR4l1XpsqK+Z9osPElF+eF9nc/PlYj6kxJafv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOf/YELa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOf/YELa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91BAC116C6;
	Mon, 23 Feb 2026 15:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860848;
	bh=ZA0boE6qtemyVmA9NXSmN2YpHL0KV9TUebxR3N6eSYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GOf/YELa6xisCZM1DqPSGYJKFCbqc/xhoTmtVinqFj5e5WzcoqsNnsIhcMfdy0rEh
	 7ySu/ERMAWQnfkQ7Yd+Bmf/jsTsR/iFgyeYcZ3jBMmvxM3N9SIDksSDm466Wvafmrm
	 kopP8+oiAA4dLOW+P2aB/eKmc/jBF0UBaKqIba3CT9qYccbtRZE5Fay4XUjV1Jbkfm
	 WfQ1kOnvQ8sKM9n99ql3fG4mjzQweS6vr4kJG0K7hRF/Q1AyX6gJJCrHbnqHx0wdOJ
	 nN5sJStOrYZBsTYcKS7VdpafUadzMguHxB6sPwhHwpEn/IUPW5jJnT0BDrxSZRAcsW
	 nfeMjdbOG2XZw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject:
 [PATCH v1 2/8] ACPI: x86: cmos_rtc: Improve coordination with ACPI TAD driver
Date: Mon, 23 Feb 2026 16:28:57 +0100
Message-ID: <2415111.ElGaqSPkdT@rafael.j.wysocki>
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

If a CMOS RTC (PNP0B00/PNP0B01/PNP0B02) device coexists with an ACPI
TAD (timer and event alarm device, ACPI000E), the ACPI TAD driver will
attempt to install the CMOS RTC address space hanlder that has been
installed already and the TAD probing will fail.

Avoid that by changing acpi_install_cmos_rtc_space_handler() to return
zero and acpi_remove_cmos_rtc_space_handler() to do nothing if the CMOS
RTC address space handler has been installed already.

Fixes: 596ca52a56da ("ACPI: TAD: Install SystemCMOS address space handler for ACPI000E")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/cmos_rtc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
index 977234da9fc1..45db7e51cbe6 100644
--- a/drivers/acpi/x86/cmos_rtc.c
+++ b/drivers/acpi/x86/cmos_rtc.c
@@ -24,6 +24,8 @@ static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
 	{}
 };
 
+static bool cmos_rtc_space_handler_present __read_mostly;
+
 static acpi_status acpi_cmos_rtc_space_handler(u32 function,
 					       acpi_physical_address address,
 					       u32 bits, u64 *value64,
@@ -59,6 +61,9 @@ int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 {
 	acpi_status status;
 
+	if (cmos_rtc_space_handler_present)
+		return 0;
+
 	status = acpi_install_address_space_handler(handle,
 						    ACPI_ADR_SPACE_CMOS,
 						    acpi_cmos_rtc_space_handler,
@@ -68,6 +73,8 @@ int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 		return -ENODEV;
 	}
 
+	cmos_rtc_space_handler_present = true;
+
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_install_cmos_rtc_space_handler);
@@ -76,6 +83,9 @@ void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
 {
 	acpi_status status;
 
+	if (cmos_rtc_space_handler_present)
+		return;
+
 	status = acpi_remove_address_space_handler(handle,
 						   ACPI_ADR_SPACE_CMOS,
 						   acpi_cmos_rtc_space_handler);
@@ -87,7 +97,13 @@ EXPORT_SYMBOL_GPL(acpi_remove_cmos_rtc_space_handler);
 static int acpi_cmos_rtc_attach(struct acpi_device *adev,
 				const struct acpi_device_id *id)
 {
-	return acpi_install_cmos_rtc_space_handler(adev->handle);
+	int ret;
+
+	ret = acpi_install_cmos_rtc_space_handler(adev->handle);
+	if (ret < 0)
+		return ret;
+
+	return 1;
 }
 
 static struct acpi_scan_handler cmos_rtc_handler = {
-- 
2.51.0




