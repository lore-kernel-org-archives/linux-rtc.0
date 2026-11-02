Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638962;
	b=0l3Zmf+4H6g/GWtzi7efv8vXkimmUCq8804snmMRbPhwf4n/T0xiAsCu2xeYOWZcqyAa
	 shAo+VifGQRXRoQiIAVbBGMvSGjKjawSMXwJtIJ4ijVQK0l4ceR73QsIjodObaFBLu4Ro
	 IW0qEIn5YJDSanHAKO4U7Ew0+8BchHc27V9q4R+VLHKiJ/n+D96Gv/o0+JoNET2GTzHpe
	 Sx6Y0OcJBpAr/7cfxiIuf87XoTuLKRvyhhekkNnfo9T88YDx8VxriFA8Aqc/6PamXKg5Y
	 UUILZG5enfazHXs3fKd3V0s0ATTFAIrNX6kqthTZOBr+l4T0hKO5kedzgBY2/n6DgNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nWXGfPUOc13SuA6FFyuHk3rQc4/OvREkwHvZPGh/a5c=;
	b=D3i6l5dX0a+5XP0ZEq7zmz++6JiTbXhmOHIDDOiXfJiY8pnEcGcdW5JIFSV5AKmW8oSG
	 cvCdwEz4+3efkGSesVm/7ZXOgc8NwAJ0v0DmCsORrPIIubyYnD0HWKsykXYWgPvqLah7R
	 QncPNcF3tdpMEYUcF9cbSzbuWJwv5C1iKn4jjjGqj95itW5hR44xC4Y5U7vv8Pu8D6mLp
	 Rr1mQ2fCAc7A8uC+dLx2TSMGtZYdPBujKmEpLqg3+Vy93u+5klW/F1K4mal9MkXV7QKT+
	 kAGW0DFKJmi42vILy/Aiv2v6i2ZJ/UTa3i6gOpKi3kQfsu0dyrLsHX9Lwm63tdYaphA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fHq+bxYU;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA46606C3D1
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 17:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA46606C3D1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fHq+bxYU
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a208d93758so34877365e9.3
        for <linux-rtc@vger.kernel.org>; Mon, 02 Nov 2026 09:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638960; x=1794243760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nWXGfPUOc13SuA6FFyuHk3rQc4/OvREkwHvZPGh/a5c=;
        b=fHq+bxYUyTZU7T/M4VkzMD9PTj5WuzskCvXpwQat9XEItrjDOA6qyi9K0mb851vPIo
         pi+jDRSjCovMUfdjpPOc97s1OIFSiUYOnUW+QCKZ+Zn81uv1ds0Y2lYBKuldVSl2N26F
         tj8xE63rd8t8ITtSNYt+iCXMo5tEz9o/v8LeV8vtXz290kbnk+46ejH3zs5GqGx2X8Ma
         T9sZfClkmXylQ/17q8UsejBwSbUWiVm06syKwgroEnEjdFFybEfJ6C/HME1ldhkAWAse
         uTkj2uqpP7ZPI0WBNQEdnZCavSBvdGFPRLrLNY4k8DJ50/GKRaDa4hl1VJ3Y047DwB9u
         A+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638960; x=1794243760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWXGfPUOc13SuA6FFyuHk3rQc4/OvREkwHvZPGh/a5c=;
        b=MFV82nINSq6wmYIoSOBMfeGxlVOgaqzsragAwyfU+BEhd2eU25cHs06/7QoCfyzGHV
         TEsCQ58dc9aJ6bo15ZOu/2dZGuq3hJq30z6J0xUG25jmFgzVd0iIVtwBBbhsYF59+Tvk
         cZZr0tq/H6jAURGdG56/J9faQRZUWop/BOoIw1s7+aySu0DsqMpU7aT9ANlD71KWXQC+
         dRFVjt9zEh86YkYMsPTr6WO0yPH9BpXd3D7V1jO4CY6M1tKl2xR8qm9rwqe2T7ZOP2xW
         y5+/MbL0nIfj+qLvzYxJEFDs6xQBTSCGlV0jh4cOLdcY5m8ScoMmsun/k4/fLw9vxyMZ
         oTjA==
X-Forwarded-Encrypted: i=1; AKwUvBzeGhNs5QpdsbBbqnwulmnT4+AAOphbb/75eHHElHfzbuSANBtGojaG9fcWhPHv1YlLwXQ8vU3tHo8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIv8fcTVa7EwZEbFtxf8W1QsNuYcEhu+5qZmparONs5Ms8FIXxD
	Fs9s5ia3zpM2g67fn80nYh4PPwxq1BZwhG3RqI70zdI8BK+1eotS36LG
X-Gm-Gg: AYBFou3zAj2jnN/ozCcFSuo2Pp6JBTPMAyX0X34rl59Mo/nhqFa9mLhB/g7y5wRiO64
	lPIUvwMe+YabRBl8P8N2xKYpul8wi6988Wg37ToOfTMgtxrgZZxuPr1krxt3p8Z+B/zabuyqU32
	qQ8DoC4eVPaJAu05W+vP+wzSpv2RhKSXMBhhRZ8L8sTZ7om80ZLt341l3QQcNAjKq/CCDgu+k0y
	MLD64GjpyrBG5WCwQLTccEGQvM4gKwUrg7xstdvhNRXZwR3yTXqFxOMGBeo+l9TMh8rDKQ0D36r
	dI6mWKxbobTl6BGQ5PAoCoagxTVS2O/wynCMmQkJGIXf1qYqZO9Ju/NVdap0M9Yu1euh/NjD1OV
	95PCu33B8meybZqCI0Um8FKWSy5zazMiX2JwyjGCMLN5LzYMR49bBdf/GDwajoiLC4Jp42n7IKU
	HjB+dpkjwHGHpqSw1VUJVSnafVZPCHILT/zYtZs+vDx9Xf3LPWpIf1wDpKXE9lptieixFaxuc/w
	1O+JpvNJb/siOapwV6gwYYYoLMQh+KyehsQ8syQHShP69dWp5H8+BDW+fRdicm+QUmxxMpN1wcj
	f2Nbhu6C5Wvo2VJr5XrN7Ftd/jtdFqLcdxA5aoYmnPMgWp5T6aca8KqYcxP1d5TAX+4kuTD6D/J
	6CSGNxVC327JqNigWz3/BEvzE1Ysj395jOUhDaruynQ602b1EUJy3A/Y9aI4FKaeleHd+uTwOrK
	lDaoB0urGMcl1y
X-Received: by 2002:a05:600c:1385:b0:4a3:5991:718 with SMTP id 5b1f17b1804b1-4ac182dc0a1mr261658075e9.16.1793638959973;
        Mon, 02 Nov 2026 09:02:39 -0800 (PST)
Received: from cypher.home.roving-it.com ([2001:8b0:fb11:0:3889:86e0:d449:e2e1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4b2a82cf248sm700105e9.2.2026.11.02.09.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:02:39 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sander Speetjens <sander.speetjens@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] firmware: raspberrypi: Add bcm2712 revD compatible check
Date: Mon,  2 Nov 2026 17:02:24 +0000
Message-ID: <20261102170227.1719206-1-pbrobinson@gmail.com>
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

The bcm2712 revD doesn't contain the base SoC compatible of the revC
because they're not fully compatible, we need to check both else we
don't match for newer devices and the RTC doesn't get enumerated.

Fixes: dba67294e2151 ("rtc: Add Raspberry Pi 5 RTC driver")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/firmware/raspberrypi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 443459c8c90fa..ab1c77aeb199c 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -240,7 +240,8 @@ static void rpi_register_rtc_driver(struct device *dev)
 	 * Check if our model of Raspberry Pi board is from the 5th gen
 	 * as the RTC is only present on that model.
 	 */
-	if (!of_machine_is_compatible("brcm,bcm2712"))
+	if (!(of_machine_is_compatible("brcm,bcm2712") ||
+	      of_machine_is_compatible("brcm,bcm2712-d0")))
 		return;
 
 	pdev = platform_device_register_data(dev, "raspberrypi-rtc",
-- 
2.56.0

