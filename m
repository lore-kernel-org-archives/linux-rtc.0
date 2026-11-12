Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442888;
	b=AwCV2lRpj+1ecvnIiWbMeaPrX3JsNeO472y8t2Ib+JJq3JkbfNvZRyMVtsLpu3IlEqnq
	 Kv9ZEAtP8Ln46eJNNwMJFDUCTYwMIwkm+8xHDklAVMx/9s2t+SkZIidL63hPim3G1Nwac
	 EcBBu7/ApMoPcC/iwEsN+HOJJv/bsV9+gIRSlzswYKQ4Now0e0VjMUDL4x6TRt3I69+nM
	 oo23huvb+ruk5fvpKVLwGg3RyEnqum5w+xzPHBpTVI/vIkFJBM4crTSCZ/1RvKnUb2DFj
	 WOgGBHtc4Ey6qysTf/W/KD6/WF0VCraha6LKx7zTHm7bM6VEAhw5TrRE+PJAk+rA2IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LI9uvWE3IMO5HhS0brzUkXza2vMATY/vaZhZVTquYOg=;
	b=TMMCXrOq3Ur8y0lilKKvW90iRuniNLx0P1gA1QJYnh0Lq83deEv38VCU7ocOodcX3924
	 ARe7704sxo+sljYepya17aTFr5yjGW0Pj+TLWLlbCIAMGPYHHDcPPm6+h/AUJs1R2dGnn
	 d6ExkKg+NV8vMDeqY0jTSGAFbsM7GdIaErXMvonu38EXFoe/PxxF1EPjLXpFCA9JO70ID
	 0tdw8GCXQgjEQvz9QI+/KlO2G6BLpctzJAxRbaefhE43U6/OgAAnlv/O7NvuuXupPMxQH
	 Fep8GCG5dpbrd1N7V4zMMi9kCxVLkk9nEpd8PZ0SnRsVU/s5gDNL+08x0sKgbtHI5rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qS2Sl6nP;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6EF606A31C
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 00:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D6EF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qS2Sl6nP
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-94937a33cfbso9191885a.0
        for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 16:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442887; x=1795047687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LI9uvWE3IMO5HhS0brzUkXza2vMATY/vaZhZVTquYOg=;
        b=qS2Sl6nPQC5yLWfuX9EiEwpuykjbfjbJ8ngdKlOkuPx70wrphU8cXRLnTBk3RoeWOD
         uJ6UFsYSO/JGPFJXQVLMdAcV+0wyCWFkPuQ+1Cm6nB1eSp6amMxJkohOWRYGgQjiKaK2
         BAYBDRSCgAy3YAM9kSDLdzMQzttS7EiA5lO9iNlwPcwf8QjDnj1C6hTAfVY03dQuebR3
         5jL4nuiZj5BMmqTDGyxRZ5vw6l3hwAlenCA8YJJHFjLEglV/B/7fipcn6Ff0PkqJ49Ex
         qSCOD1ROK0Q4q9fZQb9VidPP8aB+QqAThnXSJDMf0EHpxhsikcQn7K+yczhRIOblcw47
         6N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442887; x=1795047687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LI9uvWE3IMO5HhS0brzUkXza2vMATY/vaZhZVTquYOg=;
        b=NYQQMD1NlTVEqFLvQmvprNYwZc+isZq2mBEdgHBPOlURK4i1Hv1U55c4gPSU+JYLNF
         UpnvmZb1OQiGM2BwXC2nrOShhR7x2Nz+zTSObpMIyi2FFUyEF2iZYVXz6ljxRKpzfvDY
         bG6Vb94jhDYY4dipoRc0Rfn6JDjJ5bwvnxkkvh7N2TsusixsjdWyADgRwdNK14CCUf1I
         mf2poeIJghyBJd8Kg0uiSa+tbXcGfnS2rw1mM81uTv5cRJnOokgjzDZPW/QW4kQiT9qI
         OxHWaw/ITLS8m5/5jIHxUtMgQO2qjDpcvqW/6aMn66hTDCx02dIyDc1OsMfsOKLbT95E
         dXdA==
X-Gm-Message-State: APuU4Z/vH+WtXNvAR5uW1rufwymP0Ncp0FcCm8ifvPzKFTqTtLxaCsMb
	IoIPKpJ/OqBsaXueFLN1TuYXjmFwzNXwSvbzGSYgbutOndnSIpCEeuxQ
X-Gm-Gg: AYBFou3Zm0j/sbF8LNq4WbTPmHYBAjbzpRhk5MUYMofoimDdM2ojI1wWFSiDaEWY2cz
	s3nb7dO7Jv4t4fSbaFB/bo1L4alCjp0/SLj7MZaMr7WRyFA5kwnvjgRJuqD/ZP7jpd5ovuYMXJF
	O1NzqTuOxMOCEKLNqXUX/OkUU0MVl8vzdZvx3bOp3syiTdcGuXBRoEwiGjBH/0ozt1WfuU1nviG
	JPv70a0v7vJInseimp3L5Nv+GbMKeY+uxDphQip/8TEyGntwXQhX6SBqC8IdJgzUyzo/awp6Ti6
	8oZovInhMGmOi41pw4psaL3I0ZZuE29+vYB21KYa6ri0XBZhQztWvNnyKOrV2vs9Ao3hSP7x0tE
	OwpT7yCufrM8xXEaTs9FsA6WnZDdIfmrcoka4HayC8e/nfApWTtMAEF5fVDeXEJmiTnUmWlXcRy
	TZbwpPCAlYM11AEOIEJZBeJ0Rzh+tYoB03eCzHfZkGcvwFkxhzTwrlIUEZq1T1SxPtqAXs3r55v
	iBZduufJY4tW+Fjy8Zr2k2a4smkgHlnBs5SxZHG/1Fq3/GJ4UCWnEvfdZ6sFz5U6xUkldIn9flG
	uXRSGaImWBFeT6Wv5x6u1VMOGCmSBIS4RhpmPalltE0W1RvCplFwBMvF3NXb7MuzZvRfrpPEZxZ
	ryZb5xEqpKKhlhpQKrZg3p/YtPitFVg9yFaT2u8q+wJd25++hEfIwTOhVKRWX82v+l0EidY+QTC
	7Yu95U7snnP47ZMJueiR05XYg7AUuHM0gDm4Las/yuTNs28tskOKrKeS3rig8GF6S2GWL0WzFYp
	niKWNJfZHqsmq9HTkHdeaTUKcSFua0/pdOL1nHjPIUvJw==
X-Received: by 2002:a05:620a:1b9a:b0:943:b019:f011 with SMTP id af79cd13be357-947aff97216mr622570085a.28.1794442886869;
        Wed, 11 Nov 2026 16:21:26 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net ([2600:4041:5024:4b00:c182:d409:44ac:104f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7a7aebsm602111585a.28.2026.11.11.16.21.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:21:26 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: interface: fix wakeup source leak in rtc_timer_do_work()
Date: Wed, 11 Nov 2026 19:21:25 -0500
Message-ID: <20261112002125.24566-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
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

rtc_update_irq(), rtc_set_time() and the -ETIME paths of
rtc_timer_enqueue() and rtc_timer_remove() call pm_stay_awake() on the
RTC parent device before scheduling rtc->irqwork, and
rtc_timer_do_work() balances that with pm_relax() when it is done.

Since commit e8ba8a2bc4f6 ("rtc: check if __rtc_read_time was successful
in rtc_timer_do_work()"), a failed time read returns early without
calling pm_relax(). A single read error then leaves the wakeup source
active, reads of /sys/power/wakeup_count block and suspend cannot
proceed.

Seen on an ASUS Zenbook A16 (UX3607OA), where reads of the PMIC GLINK
RTC time out and the pmic_glink.rtc-glink.0 wakeup source stays active
from boot. With this change the source is released after each failed
read.

Fixes: e8ba8a2bc4f6 ("rtc: check if __rtc_read_time was successful in rtc_timer_do_work()")
Cc: stable@vger.kernel.org
Signed-off-by: Jesse Casco <jesse.casco@gmail.com>
---
 drivers/rtc/interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 96626f8068f9..ba4f92ac0f89 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -980,6 +980,7 @@ void rtc_timer_do_work(struct work_struct *work)
 again:
 	err = __rtc_read_time(rtc, &tm);
 	if (err) {
+		pm_relax(rtc->dev.parent);
 		mutex_unlock(&rtc->ops_lock);
 		return;
 	}

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

