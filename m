Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794788710;
	b=dBWS/WRdhqKWb5AaZkbhfL7YzGoVI2SNkiTV4nd2mAQfe8p5uU3LNzjbkctmK5g0Wx6e
	 XWoGMVvQAIYmFhcsthcaswlGCDqV96gt9+acYcqnTRrenXb+rXxdG7rd5Byp+k001ORyv
	 8vpXpz/+KsYSvDH8Gu1XoVVKbavpTqX8XKciq5pRQ9PBMj44pnAo5Ek+52DEaQUB92uyH
	 mMwEanCBxXbBD6m+I0XITRn0Q4wus+i1hfcm3Eslr5pKjOmEVKN26vqUE/JjQSqAHgIUz
	 xezxS670vpRDLkvmiHjli2tZ2ASSXTP6OMZT/WNZlmOP1JykicyRV5Wd4IdzlbsTiaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794788710;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=CP/D1iXhgNBj4XOM5YsrdaeeNdbdCcdhYw0Gszc4ps0=;
	b=Zmj9dhl+pJVXt4gKcYTOd3KJ0afJ8fzjsXVAWo6isV8D1VW+h0MpcA+IDFWLI1Xk0THA
	 LzLValuFQVN1J3J1FabeTZW0pWtAMPR1ecclysb18M41xJF/a+YyH2sIRxeOD+XHCTrcq
	 EJXDIjjiuiRsg9epoDJ/nRYenIxSz/4CaHqGzACBPwfhgk7s9q+PbFphibyOxHgNnb2HF
	 BXF8UjSiEx/bkGtbnCXC+LurHj7AGJ4nPkp1OXquo2lk2aStK+qi1C2XMw8oYjT0l+0Fc
	 w+8k+qKQ2eWwiPRt3DFmdaBQqoU7+BCJO/vdnE3rfyvg8F0g5q2+sqrDuz8EbrRp+Rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ElpHC3iz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10778606A31F;
	Mon, 16 Nov 2026 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ElpHC3iz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794788709;
	b=OYrDPyqnEWDVq+QOwPsp3ch5PS54+8KDrXE/dkvhd62AhdOryfNg7tWRLJgwCDbJraMx
	 nRZ7TbTh5wf66ARtrTvb7JD9R4XPOhdcy6wORysglbAfZvPN+r+S8SKcvAdFUByIf8H8x
	 ONb6/YtutRl5FqMEZSW4+aPDNBhLTI2mNHIpEC8KcI4kBgU+q+dtXHtwrKSd3dDmQ/2pT
	 iLHow4rp9lGzjJUU589+pmaUCmPovFrnD1mg9U6gt87/tQKUCxwp8zWYHTb6Jd28WPOfY
	 LUaRJdzVMjt9A3vFotEYQLDm7sdGE2+bGefoTsGXC22zDxIYVNyq+23UOnxpFbGJ6+Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794788709;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=CP/D1iXhgNBj4XOM5YsrdaeeNdbdCcdhYw0Gszc4ps0=;
	b=W+np2rYgsnQwdB0sPEi5K1kXXdkpFmCgl2n0Cih7ChoXSbNFqA6XLORvKr+n/uSwdK8b
	 SXzYS/n9bhx31chC1ubNPmNg9XewoE8MPwVC3ENYkJZJTwjd2aGoosttUAUgi41mVDFIK
	 rnquMykkfEfGyZ8aZGl9vJOmq9XuSXFzcscCX3mAUMtjFfOkb0qc79ROPnkGj0iQ/3H4z
	 hrUNuSLbaFr0OjxnoMM4NRyOgCx3QbWWkYhKeVxY2zHTCrKYCki0Gy+t5Zw9FS7mXpza2
	 fAeZ5cJzdhSzErh9ncUaa3z1/mcvkRG0ZeOdsiT7KLoNFixcHMBZl1iHjhdn/X3sT+w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 195311F000C4;
	Mon, 16 Nov 2026 00:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794788709;
	bh=CP/D1iXhgNBj4XOM5YsrdaeeNdbdCcdhYw0Gszc4ps0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ElpHC3izxrSQ0iTPf/fMU8xZMNVhbv+i7HMDT14YPbeOOuhldgKfFLnH1SiwQLRKH
	 rmrONddxNpAUkFw18usgeLEc+sPdsbIO0pxzC/sjOp/uPIabyu/T5+PhOWA658n2oi
	 eN0p5RrOeZjbTRzk6/C8rjfLBs59yOiod1pIX7NVTyTjluNYFD1mf1Joktf0VvDlAu
	 a7JgySEcAglmkwNQJCcKRbd+fdjCIvVeg51lByMiJrjtAmpmMsCsb8Ylku11GDsLNw
	 9k+JF55gTDPCOyGa6x9XCnIDwQMw5CLBPvi39+qqeYrNuHF/9Ldvkc1b7vFpuMOuA4
	 kxMrJOzar/J9w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9D4414A293;
	Mon, 16 Nov 2026 00:25:08 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH v2 0/8] alarmtimer: Pick the wakeup RTC per suspend state
Date: Mon, 16 Nov 2026 00:24:59 +0000
Message-Id: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFxN+moC/43NTQ6CMBCG4auQWTumU7GCK+9hWBQcZRL+Mm0aC
 eHuVk/g8vkW77dBYBUOcC02UE4SZJ4y7KGArvfTi1Ee2WCNdUSmxLZEP3gdo4ysqLHDRWVWiSt
 atmc6kbc1XSAHFuWnvH/xe5PdS4izrr+vRN/1r2wiNMh17VxFbWUqdxOfjkOCZt/3D0k86ybBA
 AAA
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3970; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=k9wmTILcWLHAdWH9pEL5KIITiwGEzZ7A8xsajYITXGs=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFm/fONda/jifC9dNHd7uuFW/OXqtxosHxuq10Z0PrspE
 ut7vnJrRykLgxgXg6yYIsuEQxq3MpZc/evvYf4AZg4rE8gQBi5OAZiIwzOGvyJhGqXz0y5GRxW1
 hK34/lHhjbiR95SkH0fuPSp1NdVxm8rwi7nrdS1z+Hf+e3k+dikf7ZmZ12yQWdrms2HO4n0bT2X
 O5AcA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

alarmtimer takes the first RTC with an alarm and a wakeup capable parent
and programs it on every suspend. Which RTC wakes the system can depend
on the suspend state. On ODROID-HC4, meson-vrtc is a register the SoC
firmware reads when the application processors suspend: it wakes the
board from deep sleep only, and only with a BL301 that handles it, while
the pcf8563 wakes it from s2idle. meson-vrtc registers first, so an
alarm does not wake the board from s2idle.

The series keeps an RTC per suspend state, taken from a new
linux,wakeup-states property of the RTC's parent, structured as Thomas
suggested:

  1-2  alarmtimer_has_rtcdev(), the state in struct rtc_wakeup
  3    the freezer delta replaced with per type expiry times
  4    a platform device without a parent, linked to the RTC, with
       sysfs links per suspend state
  5    an RTC per suspend state; suspend is rejected when an alarm is
       pending and no RTC wakes the system from the target state
  6-7  the binding and its parser
  8    ODROID-HC4

Without the property every RTC is taken for every state, so the first
one is used as before.

The user space found to look the platform device up (omarchy-mobile,
hostmobility, z13ctl) matches it by name under
/sys/bus/platform/devices or by a glob over /sys, and still finds it
under /sys/devices/platform.

Patch 8 needs the pcf8563 interrupt [1] for s2idle. Without it the
pcf8563 takes s2idle but cannot wake the board, which is no worse than
today.

Tested on ODROID-HC4 on top of timers/core with [1]:
- s2idle: the pcf8563 alarm wakes the board
- deep: meson-vrtc wakes it, the pcf8563 is not programmed
- a CLOCK_BOOTTIME_ALARM clock_nanosleep() interrupted by the freezer
  wakes the board from deep sleep
- with the pcf8563 limited to "deep", s2idle with an alarm pending
  fails with -EOPNOTSUPP
The PCIe root port was removed for s2idle: pci-meson has no PM
callbacks and the board does not resume otherwise. The same tests
passed on v7.3.4 with the five alarmtimer commits from timers/core and
lockdep enabled. sparse reports nothing new.

[1] https://lore.kernel.org/r/20261019-hc4-rtc-alarm-irq-v1-1-078fc79e596f@iav.lv

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Changes in v2:
- restructured as suggested, no priority property, no list of RTCs
- one platform device for all RTCs, ordered by a device link to each
- sysfs links per suspend state
- the freezer delta replaced
- suspend rejected when no RTC covers the target state
- binding: s2idle, shallow, deep or none; hibernate and off dropped
- based on tip timers/core
- Link to v1: https://lore.kernel.org/r/20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv

---
Igor Velkov (8):
      alarmtimer: Replace alarmtimer_get_rtcdev() with alarmtimer_has_rtcdev()
      alarmtimer: Move the wakeup state into struct rtc_wakeup
      alarmtimer: Replace the freezer delta with per type expiry times
      alarmtimer: Register the platform device without a parent
      alarmtimer: Keep an RTC per suspend state
      dt-bindings: rtc: Add linux,wakeup-states
      alarmtimer: Read the wakeup states of an RTC from linux,wakeup-states
      arm64: dts: amlogic: meson-sm1-odroid-hc4: Describe which RTC wakes the board

 .../bindings/rtc/amlogic,meson-vrtc.yaml           |   2 +
 .../devicetree/bindings/rtc/nxp,pcf8563.yaml       |   2 +
 Documentation/devicetree/bindings/rtc/rtc.yaml     |  17 ++
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts      |   5 +
 drivers/power/supply/charger-manager.c             |   2 +-
 include/linux/alarmtimer.h                         |   7 +-
 kernel/time/alarmtimer.c                           | 228 +++++++++++++--------
 7 files changed, 174 insertions(+), 89 deletions(-)
---
base-commit: 0359ecff58853a491dd0f09792fea8e87235ae06
change-id: 20261104-b4-alarmtimer-rtc-priority-2e25131a2917

Best regards,
-- 
Igor Velkov <iav@iav.lv>


