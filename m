Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9E3DA5B9;
	Tue, 31 Mar 2026 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774985959; cv=none; b=fSvL0il9753iav7SZvsI3wJhWIYwMrdKCCn4DvcAtABKnF5A7KA0UiexuQNoNdOPkF4luoa2AQR1ujhFAs5GWNUK5h32NuV4IMmyQNatAR77X0oM4ZSXBVB4EpMVxLMfv35xoQlq2VaUnsAF2Kk5ausWAlbsXy5sjYo64TRMdKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774985959; c=relaxed/simple;
	bh=YvurszLvPDMVP72P36RPxOuz5Oy7cq1WNQnYabSads0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAxWprNmlurjg7lC9vJAJsQUdC5MjsecUIIt8h1iDW3rSZUwOyo3DSm/XQOXOkqYfxsN+EdokuR5ccUlWsXJ9OI7xHF7DEb3jWgWFa7if8u/HJjlvDjEjgCpGxQcSRLCikeTfXFvRIODoAV64cVjXq3gqrvHfPtekHevcOJY91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbNajO/n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbNajO/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1992C19423;
	Tue, 31 Mar 2026 19:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774985958;
	bh=YvurszLvPDMVP72P36RPxOuz5Oy7cq1WNQnYabSads0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbNajO/nRg2arvH2fzRdexY7bvafvHPSt2wu2Fv7qVko9fGg7jF7I/yN+R1LHqq7+
	 o1wiUzGwl4iUKr85EAB6xjdB1apv4E2IhvK25zjvPNm9KdFFRh5q5RZ7Nt6uBVMFf7
	 +hpo+Y4oX4BFHjVoi6XutlH9dEMxj6ma84pPmUWIOdX1rVL3monapFHdXTPw364Dhp
	 vYbMdoYGhpYvRAJILe46hCnMS3mTukCrH4xqS6GjOi5SnLSNmDfhv30FFTLamLnvl2
	 mBJGXCcxVZG2SAj4zQVMYpMzmg1WININUWxYYjkNQ5xF3j2cZWVQ+gyhsdKZ7/VrLa
	 MB6gW/HVdwzsw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject:
 [PATCH v1 1/4] ACPI: TAD: Split three functions to untangle runtime PM
 handling
Date: Tue, 31 Mar 2026 21:24:44 +0200
Message-ID: <23076728.EfDdHjke4D@rafael.j.wysocki>
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

Move the core functionality of acpi_tad_get_real_time(),
acpi_tad_wake_set(), and acpi_tad_wake_read() into separate functions
called __acpi_tad_get_real_time(), __acpi_tad_wake_set(), and
__acpi_tad_wake_read(), respectively, which can be called from
code blocks following a single runtime resume of the device.

This will facilitate adding alarm support to the RTC class device
interface of the driver going forward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   57 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 17 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -151,14 +151,10 @@ out_free:
 	return ret;
 }
 
-static int acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
+static int __acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
 {
 	int ret;
 
-	PM_RUNTIME_ACQUIRE(dev, pm);
-	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
-		return -ENXIO;
-
 	ret = acpi_tad_evaluate_grt(dev, rt);
 	if (ret)
 		return ret;
@@ -169,6 +165,15 @@ static int acpi_tad_get_real_time(struct
 	return 0;
 }
 
+static int acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
+{
+	PM_RUNTIME_ACQUIRE(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	return __acpi_tad_get_real_time(dev, rt);
+}
+
 /* sysfs interface */
 
 static char *acpi_tad_rt_next_field(char *s, int *val)
@@ -268,8 +273,8 @@ static ssize_t time_show(struct device *
 
 static DEVICE_ATTR_RW(time);
 
-static int acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
-			     u32 value)
+static int __acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
+			       u32 value)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
 	union acpi_object args[] = {
@@ -286,10 +291,6 @@ static int acpi_tad_wake_set(struct devi
 	args[0].integer.value = timer_id;
 	args[1].integer.value = value;
 
-	PM_RUNTIME_ACQUIRE(dev, pm);
-	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
-		return -ENXIO;
-
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
@@ -297,6 +298,16 @@ static int acpi_tad_wake_set(struct devi
 	return 0;
 }
 
+static int acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
+			     u32 value)
+{
+	PM_RUNTIME_ACQUIRE(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	return __acpi_tad_wake_set(dev, method, timer_id, value);
+}
+
 static int acpi_tad_wake_write(struct device *dev, const char *buf, char *method,
 			       u32 timer_id, const char *specval)
 {
@@ -317,8 +328,8 @@ static int acpi_tad_wake_write(struct de
 	return acpi_tad_wake_set(dev, method, timer_id, value);
 }
 
-static ssize_t acpi_tad_wake_read(struct device *dev, char *buf, char *method,
-				  u32 timer_id, const char *specval)
+static int __acpi_tad_wake_read(struct device *dev, char *method, u32 timer_id,
+				unsigned long long *retval)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
 	union acpi_object args[] = {
@@ -328,18 +339,30 @@ static ssize_t acpi_tad_wake_read(struct
 		.pointer = args,
 		.count = ARRAY_SIZE(args),
 	};
-	unsigned long long retval;
 	acpi_status status;
 
 	args[0].integer.value = timer_id;
 
+	status = acpi_evaluate_integer(handle, method, &arg_list, retval);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+
+static ssize_t acpi_tad_wake_read(struct device *dev, char *buf, char *method,
+				  u32 timer_id, const char *specval)
+{
+	unsigned long long retval;
+	int ret;
+
 	PM_RUNTIME_ACQUIRE(dev, pm);
 	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
-	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
-	if (ACPI_FAILURE(status))
-		return -EIO;
+	ret = __acpi_tad_wake_read(dev, method, timer_id, &retval);
+	if (ret)
+		return ret;
 
 	if ((u32)retval == ACPI_TAD_WAKE_DISABLED)
 		return sprintf(buf, "%s\n", specval);



