Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B3493D4B
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994331; cv=none; b=SykDaUo43OHJ1Xt1FmyBFm/SeHZvwXLjTydouPuNVdrvJOsdSSClX+LT/FctQRfDrtnUVTVEySv15hOd+yMOx/R2BI33j0kfhHj4bcWJwziLnEGQZQG7ZLiiOFfduAojz0Ge4DX5Jfv14rpZOGAKiYRAR6oqD3g0vQPz1Me5pHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994331; c=relaxed/simple;
	bh=aZ9zAg2uTuv7/FU+ETarYrAHc8sT3sPRPWW8umE51eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOwZdfmNLhFsbLeApUqEtuK25GdxW2bbYKq0R33q37gwwVvL7c+fSa4hWx8hC43aYsnXl4ky7jiz5VFaIrNiL+9iB+TXlOPVr1g+wXTxaG5AoHm9BeMDyblO48MfQ9BDEECk2HNHciTBWGw0pXyt0/MGrO9rZyGpiVCGHDlRGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uqy8A0Db; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uqy8A0Db"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90cd8e45460so87070476d6.1
        for <linux-rtc@vger.kernel.org>; Wed, 09 Sep 2026 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788994314; x=1789599114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2wLUzaidHv+rgjS9Vme7RZj9pjhzoFdoBFIa4TcM6o=;
        b=uqy8A0DbftwZBrWJiYGzrATABjjiIKlS6aSJD9aiT6NbesX+TXF8ZujUA8vpxNqPio
         kMyg7Yr1NjXJNAIgYl+6aq0Zz0GtX28fdYt0hTpNnBekb7scQyXYMdrfEmWUd5nmbSpt
         9kO2oR1F+L9522L+zOMwWrVBM4QFbYehSXuLXGPu5gZhlCzUwjzrIj69j66hhvtHXAF9
         a+JZtcCPv639D6YMDqwjAK556wd+/f0l0nR//J8Q/QeLJrxnFj8urFuGRqJaZQoVW2T7
         B5J5Ra3RcIgcbAGoJwZ6UoyJU+H5cbFDIllh8JGhU/bPjf3JWqwoVVl3P6A3bGNydXRT
         VM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788994314; x=1789599114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l2wLUzaidHv+rgjS9Vme7RZj9pjhzoFdoBFIa4TcM6o=;
        b=RYsKukFYbiZ2HzmcGiLnDeTDDgkFCX1Y9hjA4tjcOtx65jDfxjgt52Pg5HscO3WfVF
         mssEXc7Oy4/8tyP7d7B8wyiGpdIDQ9Wzu4u7wRBp35Z6UoIb7pXxYhoygQdatN3Svpcf
         Bkhq7jHyNIFDUUL01nPcEXFlOdAwoUecDTxj5hXvZP9DSlfbJs9rRxDAGBF1NFt+s//s
         bIp4TmOiNfFpetJVNJtfx62wm2EZFzKoqaxZSistJlXwcwkRvvT6ChYparz1dPYbu49w
         S6PU8Z32XZf9dVqN7Xmc50kCsdGiZRI/EAMbqFqt8eC1H+bm80A0JckqTHdRv94kDn4p
         JeaA==
X-Gm-Message-State: AFuF++lfHSrMfFa7XLFXfttGf4udHadgRTHqK8DP4wW9600jRUBwWaJD
	ccf8aPPt27jc2RXiFObsG1ucJxFeffH0ZXWxP2WeugtjWIPlbDM4zXsRFY6gR0s98yYq00t6XKa
	V8+96
X-Gm-Gg: AYBFou2pX6R3p+elwrADeLPGX2MINoMQm3mQLdAbDrXzXd+H2OI3BkiutaENcznMvK1
	3b4D3C8Ityq4LiuSqQNcM24kMiFbPR3j0AF2++n6Wni2pX6awfaoNuMKjFXD3qItQcgouURYyFW
	Z9D7SA9DwiBNp49dh/Wu4cMbBsjtghNgNyYNpIGlGR8khEgbdBVBPa7FVCxXUctjbqzKX2QX/pN
	ts3DlkFrVMo5CHNgZPvdf56ptVUx0b4qfzYm7/8X77DrOMt2B8+UIUO0bNd4j7VLe8JjZnrDsBG
	s0FyLe6qyzHU4H6z1JqbDF2OwYAWio3CH20kjbP8941wr/6eYmTnfiobk2TCZ86atRXla6G3Qd5
	WMrCB1HI7Mne99M0ncjBVhvpVMN4CpfpgOJFr8mcrT86RPmytvBedGOApEBNII1Yb0p2uvcxRg4
	ceYscr55yB3q9m6pvcx838iFUkznaBKdGmNy2ziemaxQSEqM3fagwcI9Fve36J+GY3CxfNoUuVS
	4NhiX4Gq1sI1dP78rPkVEae+KrN/J2FRvlli8H4uLwYf1NnOpm8Gim9rttF
X-Received: by 2002:a05:6214:daa:b0:910:4b24:a936 with SMTP id 6a1803df08f44-9104b24aa14mr352805826d6.6.1788994313808;
        Wed, 09 Sep 2026 15:51:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm59976696d6.20.2026.09.09.15.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:51:52 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	alexandre.belloni@bootlin.com,
	rui.zhang@intel.com,
	stable@vger.kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [PATCH 2/2] rtc: cmos: Honor explicit use_acpi_alarm parameter value
Date: Wed,  9 Sep 2026 18:51:32 -0400
Message-ID: <20260909225132.1392883-3-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909225132.1392883-1-gourry@gourry.net>
References: <20260909225132.1392883-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An explicit rtc_cmos.use_acpi_alarm=0 command-line argument is ignored
on systems where use_acpi_alarm_quirks() enables ACPI RTC alarms. The
argument appears in /proc/cmdline, but the read-only parameter reports Y.

The boolean parameter defaults to false, so the driver cannot distinguish
an omitted argument from an explicit false value. Use a custom setter to
record whether parsing occurred and skip automatic selection when it did.
Preserve the bool parameter type metadata. Automatic selection remains
unchanged when the parameter is omitted.

On the affected system, the explicit false value reports N after this
change. The HPET-emulated path completed 100 test runs without a failure
while the ACPI RTC event counter remained at zero.

Fixes: 36d91a4d401c ("rtc: cmos: introduce quirks to enable use_acpi_alarm mode")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/rtc/rtc-cmos.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 462799667aa18..536bdcb79ea1c 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -57,7 +57,28 @@
  */
 
 static bool use_acpi_alarm;
-module_param(use_acpi_alarm, bool, 0444);
+static bool use_acpi_alarm_explicit;
+
+static int set_use_acpi_alarm(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_bool(val, kp);
+	if (!ret)
+		use_acpi_alarm_explicit = true;
+
+	return ret;
+}
+
+static const struct kernel_param_ops use_acpi_alarm_ops = {
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = set_use_acpi_alarm,
+	.get = param_get_bool,
+};
+
+param_check_bool(use_acpi_alarm, &use_acpi_alarm);
+module_param_cb(use_acpi_alarm, &use_acpi_alarm_ops, &use_acpi_alarm, 0444);
+__MODULE_PARM_TYPE(use_acpi_alarm, "bool");
 
 static inline int cmos_use_acpi_alarm(void)
 {
@@ -822,6 +843,9 @@ static void rtc_wake_off(struct device *dev)
 #ifdef CONFIG_X86
 static void use_acpi_alarm_quirks(void)
 {
+	if (use_acpi_alarm_explicit)
+		return;
+
 	if (acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)
 		return;
 
-- 
2.53.0-Meta

