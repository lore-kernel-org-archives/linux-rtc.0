Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE73E559B
	for <linux-rtc@vger.kernel.org>; Thu, 15 Oct 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085449; cv=none; b=soo0CWTcwjqJ0kRv/xFeJPHj7TylFlnvdA4lYTJDX4g8V5ZLQ9vrpqGlZjBL1vsBnURkCGrx41y9beRgLkHAglRgjd4mx1ZrKhGxnqUfTZ01hvSiS4G2wpoSaovpV0lc48wMvCJe8JmZhCuhfGfkuAnVcsRYqhm9nDd+57gu2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085449; c=relaxed/simple;
	bh=9g9zSq074iPd7lmg87fsZCRtxqvQNuxb1lPXVSTpQjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2aNuDPJCBO/dZM4DGagc6tBZSN91GUBjCSCPJgD0J2g9i/QX8QqV7Adu7DJ5kbxL/SvGwQA+0JG3X2IMpiot3mcfurn2rVRxXjzvPOdivuf3/sibvowHHrznysOcGSaAfPHbrDljJjzZ08J1FdbjYvEjOql+eXpGa6A6scO4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mpy/S1Hd; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mpy/S1Hd"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533778ab0bdso62627761cf.3
        for <linux-rtc@vger.kernel.org>; Thu, 15 Oct 2026 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792085440; x=1792690240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NYdLOSjrNOs+xotfPTGhWGTNQmq7/MP7sLOby3eu2kk=;
        b=mpy/S1HdS9xrCkKQCXlvabsfjOdtGZIKXRuKOyy/eEUJFm1IjYzL3QdQ1qgFhDTM1m
         ajdFWvnZ33Am2nuDKYISqzSewbbYIUI/BbrB3GbxLGGclpBPzcB5D4hZRzrI4peLwv8O
         CR57msEQ29Sksmz60azbaperTi/6+zeXU/he1BkcOExXWNxdfZUe0oNHjgnuMTg/MFOS
         2fVqXRUUgWk3kYO1vmMfcV5sRztLYOvCB9v86sfBjyK08oK0aIUMThQE/GLjJSPPKDBc
         Cm02Dpyr4qmcvBMGdfaEBSYg62vF8vk8g6G4D8GoUyDrHHvXQcbFxM0yVGtYLsePGATP
         m7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085440; x=1792690240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NYdLOSjrNOs+xotfPTGhWGTNQmq7/MP7sLOby3eu2kk=;
        b=B+v3atPJ3oT9CL/zYQ8bBDyWx62KqrbiQVoG5tFoT3JIGak7XkWHpVPm0zwmXQAGEI
         cOJUc5YqmQR1P9t0OvdQWcqF4Hj6Wk9Ns+Z/J7k2GskbSeYJKx1M3uWcResIqt61J7TI
         +l00rq0uNTVv9j1ovurCSjwQnE+4CBxs88yQJhtD2E9K1Z4I8/ZE8ZlYeNqTbrBrHFkm
         hS36j8SyiI4EyUw/wYeyVnCaZ7xwWLTKhEtTl831vK164M7ZHYup7rW4Yvs8XL7GYKsd
         vlWBzPJ610iFayq4Cd8kYtJQSsJa+HaCNqcHNbQfdK94rtwKn077d3OD8dBXRWSJVNvK
         8Xhg==
X-Gm-Message-State: AFq9FYIq4Pj8snWJl+9ULyoQtA4BJBHnA4xUaT8u1veORAMqCIahg9iX
	KPB3/lJwHWaKDRm1EQVECdsO4YPAc6Hjy7Cj3X+u3sUWSsH2eeY/bM8bW3FiMflY2Vb9kJ8djNM
	NRBmPgWI=
X-Gm-Gg: AYBFou0Fm6f2tnbIwvdX9kixntu3hbphLJQ2OJw4Vlc9jXV1iScOyQFOMdpzhjSbCu/
	4E+whJ6fC1GD69ZlXR6v4ret6SkvGt5T39aNB25MUYr67511L1Nn6sMfN18oRR1S84ZiDCBDVCy
	MtIAcjsiy6HI8IOaxs/h4BhGX8GrXprNHiVvHe9P24IuJGVRABldZYXn8AsPmKETk2vcCl4E2SL
	+V/MmYwGbbbTcPJwkZTnKd+WUB0LxCdbpmfyha7Ehnv1hvXJJohQjgaktAFh92hWD9KqT9gjj8d
	ENCd5dc1iMJlL+6WLolFlSe1yPVSq/q9+JU19UZ4GpNVtEWf8xVwBFJ8yrf9Sg+WYQB9D87Jtqz
	GsjsWhx6s7a8kpGWVzMD/poWrHswqrC4rT/fiz8M13k95Iw0v/ENCV/LCKCHOB+cpH6Y2IH1Ocl
	ELJvmgPZdUxFMQ8L7yx7p/140yOdfzF/YI+v1uD2ent5NdgNCu5NpCBkEgCXTOP73j2XFHsPGnC
	gqJciznQBNfxqABJr4jw9DR64lJS5AT/A2AgaWyutk/8Q59ztrF7VgV/D0a
X-Received: by 2002:a05:620a:2781:b0:93c:5951:38e9 with SMTP id af79cd13be357-93ebd28cae1mr3125418185a.52.1792085440261;
        Thu, 15 Oct 2026 10:30:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50095bbsm825062485a.9.2026.10.15.10.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:30:39 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-rtc@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	alexandre.belloni@bootlin.com,
	rui.zhang@intel.com,
	stable@vger.kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [RESEND PATCH 1/2] rtc: cmos: Disable ACPI RTC event before handling it
Date: Thu, 15 Oct 2026 13:30:28 -0400
Message-ID: <20261015173029.3091872-2-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015173029.3091872-1-gourry@gourry.net>
References: <20261015173029.3091872-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users of RTC_UIE_ON can stop receiving update interrupts when rtc-cmos
handles alarms through ACPI. In one 50-run test, 40 runs passed and 10
timed out after receiving between one and four of five expected events.

The ACPI ff_rt_clk counter stopped at 218, exactly matching the number
of events delivered to userspace, and reported:

    218     STS disabled     unmasked

rtc_handler() runs in the threaded ACPI SCI handler and calls
cmos_interrupt(), which schedules rtc->irqwork. The work can run before
rtc_handler() returns:

    ACPI SCI thread          rtc->irqwork

    cmos_interrupt()
      schedule_work()
                             __rtc_set_alarm()
                               rtc_wake_on()
    acpi_clear_event()
    acpi_disable_event()

The SCI thread then disables the event that the worker enabled for the
next alarm. That alarm sets its status while delivery remains disabled,
so no update interrupt reaches userspace.

Clear and disable the current ACPI RTC event before cmos_interrupt()
schedules the work. The worker can then enable the next event without
the handler undoing it. With this ordering, 150 runs delivered all 750
events without a stall.

Fixes: 311ee9c151ad ("rtc: cmos: allow using ACPI for RTC alarm instead of HPET")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/rtc/rtc-cmos.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fa04ece151b8..fe514b1aa343 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -758,7 +758,9 @@ static u32 rtc_handler(void *context)
 	unsigned char rtc_intr;
 	unsigned long flags;
 
-
+	/* Quiesce this event before rtc->irqwork can arm the next one. */
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
 	/*
 	 * Always update rtc irq when ACPI is used as RTC Alarm.
 	 * Or else, ACPI SCI is enabled during suspend/resume only,
@@ -781,8 +783,6 @@ static u32 rtc_handler(void *context)
 	}
 
 	pm_wakeup_hard_event(dev);
-	acpi_clear_event(ACPI_EVENT_RTC);
-	acpi_disable_event(ACPI_EVENT_RTC, 0);
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-- 
2.56.0

