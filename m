Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282633F8B2
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994320; cv=none; b=r2PpozdlulZgq3h1dWk429yYS0LWHR9rZj1fVtu0gYbe7cyGsZ4QzmlHwNzeijaCHc1R8C6Ww0WecdRd22McpMhJWGdqAER4/5Vt8DHtl7g5E1W18le3BHGIp46H91My2MglOnbeeYJwjfiOJdY1X5beTLwF8bpOTDn97oYOymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994320; c=relaxed/simple;
	bh=w61WNGoIZA/H9B+0UvBqxIy2Jaep+YUPmNtGA17Z5/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2rLMwjgPwaMOy3P+43QmnT2jPlO2QRYBoZHM+9C0F8EsIaf7vrbo2FeMnJ1B1Uvi+EbXPLeYV//TcRQUXyIsy0NvJvmcog7Rw3B7Oo4KBrfwqIhQQYM8CtEHtN9NbihRdIiZOSNsxh17Yzb0vinU+AQkW57wpdwkeA7kX1qGEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MeBpc7kw; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MeBpc7kw"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52ff0b7c98aso58819941cf.0
        for <linux-rtc@vger.kernel.org>; Wed, 09 Sep 2026 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788994311; x=1789599111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v83isyAjdugdAGxxYVFRPX3ygevFsOMhNoKrO0tFt3Q=;
        b=MeBpc7kwl8MqLB5z6n5iVHzQx1veQ4IM9toLUmhGA9TK0cfX3xwiLG1duwcROB5WWV
         3t8SJ1UpJGFjz0VXzPg6jTVGK1wTgmj+j4POwyViHI4ijP2CcjiAtIP7SorPKiZ0mCDc
         6BET0Oc74wQmklv7fW3R53fsvaveV+uTIKhv8oVG6vD/2+vJBWtn9sOCfFbqcR6ts3de
         P//tvGElRAsCY/BjUMQ0hU0RH9M5EO0CMWccNDF6r4pj9gaNBMPec1sGRSe94TWO03IJ
         +U9OLQCSDRovEQ10YsM31o0Y7NNJ+/60enrsA/x2UIeDAkJ/1b56aIuKG1aDF9ta43TD
         x0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788994311; x=1789599111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v83isyAjdugdAGxxYVFRPX3ygevFsOMhNoKrO0tFt3Q=;
        b=oFMi0yRKzvHPKLeDy8sqFgGSZScOvc/qMfMmhiRg3O1BewUPy9Z50NiE/p1hRlAT7q
         rIJzJLUTdkW89Vq2yd1hEATQI/lqCH42DntKPZ7UGF0Oq0VA+qozeDZBehtjMlfz6cHp
         14MzEVzzxzVN6r4goi1UllldNtntdpLvIRMHKlK+kj7/0X4Gtzhrk0tDwmuAgpHQVzok
         +O5VR663Xg3p9S5yDYB+nmMl0XxQ4I865W57CKI6u6GX01KA2rZw7j1qe2C4mHcRBAHc
         S0CLEBMVxgnhEW9hSEThwu4m3Uriz8A6/PISWn85IonfqWZLNf38d/abhKLnOrrAAlFb
         25sQ==
X-Gm-Message-State: AFuF++nDGXLU3hIkJdnTstg5P/sypXS+AGVa+aRvBaUMP57VDka1SN6M
	nXNqtQ+fBdgP1KOJUToceX52RcKzPAJ1+FZsPO9/CXGUaH9Vnw4AwzwrrlfMXer3HRE5BKvydgQ
	Yh6fA
X-Gm-Gg: AYBFou0E4tHIH0QHwJdrTvwXUwu7nQqbX8H3PnPdQO7q/EPnz36sKkXsGUCuSp6JRFT
	wCQ4GG9VpkQUfsdFKje9oDWN2X6YXK/6bYXp7T1XJwGPN/QaNpN6ZPZdFkXEX5oZ9nXTzYyTxue
	2hsx27ZSq05sSdIPkpbScJMK7qrThj7aoQll9GlrcylYKgGgyMBtD7lF21Dh6IYy3cutnZJ9M5z
	2VQAyJxc9JfPOXD50krJ3BsW00Vd424ef+ytXQ8dcqebROn0qnxvfDXw73ULwwqvCUWe2a1j3f5
	/qjcc7CXVnyQXrsmzLD6FfwKBt0fapZ2Wpsaze2Vyli1CKNmaUEkygPfFHsGn9i9PEsAgqvozpG
	WMqHYXnwXCQu+tctJLYvEqfoQuvJlBIFKvUo/1WQhro3tcGp7n0Wx4A4Hd2WxQOwlMs8zjbBCAV
	CaGY6F+kWP0ShXDQ0lrv+NcarHj7jQwUTRJbfbaz14A//Im4XFyp1TKlBH3W+5JgrcaqHNlhxUH
	Hu2E4TnlIyjLkYgh9wCQvfPdP+HPPqie2Mxlji07d27p++i/JCShuD+QtNO
X-Received: by 2002:a05:622a:90a:b0:52e:1e5:4754 with SMTP id d75a77b69052e-53054944d66mr394518201cf.24.1788994311148;
        Wed, 09 Sep 2026 15:51:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm59976696d6.20.2026.09.09.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:51:49 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	alexandre.belloni@bootlin.com,
	rui.zhang@intel.com,
	stable@vger.kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [PATCH 1/2] rtc: cmos: Disable ACPI RTC event before handling it
Date: Wed,  9 Sep 2026 18:51:31 -0400
Message-ID: <20260909225132.1392883-2-gourry@gourry.net>
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
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/rtc/rtc-cmos.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index f89ab58f5048a..462799667aa18 100644
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
2.53.0-Meta

