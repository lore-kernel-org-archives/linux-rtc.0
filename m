Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E15466B65
	for <linux-rtc@vger.kernel.org>; Sun, 11 Oct 2026 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791759452; cv=none; b=M0+uTB/raVCMPRrS2bbW8uZa/fG/xVO2OxGKEHh5wpYPfKei1RPnJ082y9MMTR3W0GbCyaNs9Uzq/r7qdM2Je9stFCEYlxqyOJ7uRR/sJkToEpgJ5W25bH415tHlzJABTdLxS0fXyH6EgOVcHwQh8MA7F7fx1zktqMuI5InczwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791759452; c=relaxed/simple;
	bh=RZwb0v8NRa8WincdU5oM8nIaW/9Wl4Cz5GrnIGcpkbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErLFZi6Kw7AYDBIQALrVLAQfR0qRaJOdyD5CKofjSyIvh9Snh02J5i+cHagHMJYw53i3mgwbKC7qWnsOnm9q0u9vf2Ydemy2tvkMXBjFjVS4gjnMbdH3zcT3DbJuuu1J6V4Vn4bSB7bX05urSSBBJt9GxRNfxlQ1y0jg5S/DTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy00jf1i; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy00jf1i"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93d92abf38dso130881285a.3
        for <linux-rtc@vger.kernel.org>; Sun, 11 Oct 2026 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791759449; x=1792364249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aJ3lYqdP3s7nQxccxtgd7lYQQBm6qlupyIbypzuH9WU=;
        b=Fy00jf1iliuAYDJkv+MbxZKP7D2f1txnfVnmTGUiDG34L6K2mEV0lRuFKHo012+/N2
         dn7B7lKQ9iYQcrQzypRuuE5rxq9I2Cx7gOLc454E+HKkkKEhaJHHiHWMQwsa9MtVnXoi
         mpCRR/rBvdZMJo4ElVVasRVOThxg05zCh6tMY3RNQXPUMu6PhcvotICdGYXuFyble5MR
         13Z7LdvCHYUAdEzmPoOLPAmD+RGeVXXbh3fDtBdjvF5Y0zjZ1NDAC5TXiI9WTVj+9dP0
         z+ky+NhwwdGM7dmpMJoykBF9M62OjDxQIr+4YekK0Ij33hII2YpDjBBwzYFaCIo6No08
         GLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791759449; x=1792364249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJ3lYqdP3s7nQxccxtgd7lYQQBm6qlupyIbypzuH9WU=;
        b=jEtXoMsoJgT3D9ud3Fz1qCVlcdjSWCFwWUOgDi174H6QtGHWRUQWHH8IPR/0p5mC36
         U1UxgGFedr5kEWe+fDQqXFiWyWgORD9WuBJrwmb+3A8e94XP/skAd8TxWdvV6FyiQsjh
         fRE0I93OmXfVsq1EQzw3BZ3fSgoC2Fe9kjfjJHuO0EPRRJCYCBI/FknkTLNPNMT+sCCK
         5/2pWnXrGYm/MIZX5/HAwFSTJRH5/DlDH+o7rbkVmH+3sm5xkqcb8UsrwjkxuX1kHr2g
         eMTME0RyTnkHaN8Znf9iXYcJDESU6CAJkej1nhI0twEfB5q97TsvBpwcdaXZpdSx6mlz
         eZzw==
X-Gm-Message-State: AFq9FYIgbuvqaBAEJxjnUAXgdI78Bd25Tm1y7+FiRjMY6rNVQsPs/RQJ
	sUabIscvf1BrIiD1jLecyxv8QmwCb5WhSpkQjrPPUcCmSGRKO4QrVhc=
X-Gm-Gg: AYBFou2PfHHm5rrVYlH9gwElsNOzvluw0vkaP0jtLLF2umjIoYD62Poo5y6NxRQUB1l
	MO0uL6/zh4di4B50z9auQJQKgMSvlkKCEcQkD+LMjzeT+YnnS6NNc8W5bzOUMQfVa15xuMwEo7U
	j7v5nOriCCUdZC42HNgv+dtkSgVhm1s6dfM2fYwwy+q3DMMT4vb735gMmUpJBGS8enSV8/6QpWF
	3Pnc2kR9IQIAPMUGGrTfCiKjYMLKdamvyBHzAu3BYRPOORYuEY1PE6opFlM55/ykcZ8q86sy0c9
	+SNjoPyB7xBAO663kAXIn52nqQZx0er8YmWC2RTtK5Dlek1LHxPGKGuLSB01FH2MWsr6wN9Afwj
	UvI3embMsNimuIPaL9OmQb//Oi+dS+9QOQjo4gK+SjCirT5UqISeEkFPfnLmkb3d8NfLRtbhvMF
	+ZWL/cGt60SHsYPZsfEzQIBScZZukApNZ7hx4937fRMSiiiDMQ3X8Bedm9Hfzg3xqNBGA4yLKk9
	qbyHHYfizcbol+j1e5/d25IJ3BbGAYuiFiUXd3Thv35sOQ4sio3AAYW8DKlM/vKe/A5jM1cuqb9
	+AnkDb4fPgJVecLjs4Nw2AvNV7jh
X-Received: by 2002:a05:620a:450a:b0:93c:b10:7243 with SMTP id af79cd13be357-93ebd0cbfe0mr1420548485a.5.1791759449127;
        Sun, 11 Oct 2026 15:57:29 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98cd599sm723647985a.39.2026.10.11.15.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 15:57:27 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 0/2] rtc: renesas-rtca3: Fix IRQ initialization and teardown ordering
Date: Sun, 11 Oct 2026 18:57:23 -0400
Message-ID: <20261011225657.rtca3-irq-ordering.0@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTCA3 alarm handler passes priv->rtc_dev to rtc_update_irq().
Registering managed IRQs before allocating the managed RTC lets devres
drop the RTC allocation reference before freeing and synchronizing the
IRQs. Masking the hardware sources in remove also does not wait for an
interrupt handler that has already entered.

Initialize the RTC before requesting IRQs so its allocation remains
valid until managed IRQ teardown on removal and probe failure. Then
stop both interrupt sources and synchronously disable both Linux IRQs
in remove, before managed RTC unregistration. Serialize removal with
RTC operations and reject later alarm enable or setup requests.

Compile-tested with Clang 22.1.2, W=1 (arm64). No runtime testing.
One existing FIELD_GET comparison warning also occurs when compiling
the unmodified driver with the same flags. No new compiler warnings.

Myeonghun Pak (2):
  rtc: renesas-rtca3: Initialize the RTC before requesting interrupts
  rtc: renesas-rtca3: Join interrupt handlers before unregistering the RTC

 drivers/rtc/rtc-renesas-rtca3.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)
