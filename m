Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459304;
	b=TU7g6QA6fDBfzBH92/MpLjKtb4uGYdrN5/BAHWVZgtdZq7ptPJ3wE0PBp2paX2O8nhGX
	 H089dhrMjdU0TcIc6XVMu9v2UwiCGZ2YpEyfd2UoKrxjJUh1vIMsgQPZgVWPzj2VwZxnU
	 V6HU5xO8AsSQtmFQelg61/gMPrferDdY2CRbJ+vwgU6xrcXqid7z6xI/p2A4FBY4kF5oD
	 S6gVcwOZni0JSFkhD9fnMbHN2bTvX6o2+lUfHk+N2UGd6JUXwq1Atr6f81OWTlkiN9GYT
	 R6Caoxu6WVHdfLvuAVtgsQXUZenCAdV/NbfRCIG1PlvMHn83xPZnls7DoJ7JlvwylcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459304;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=F2ZG4WV1JiH9H3Ur9+LrPBFzjYCXIRCQKo41Iqlytpg=;
	b=FeVh0qZxoohYIyd4yxY3ZcdqWmYM04v2FUhHO+Der3nNzQsGJeb+7Y82+zv3AQiGYDLb
	 36wdMZZYpuHsz+w2uUptITFygNqdYpaWSluCYVCwhk8mu6AQgG26UmUZ9vATycnEpewod
	 3q+gvwk7i2V1ETB/It7FfctqSInjEG/t/vQJ9D41lcB5MED1VwxwhT6HRw7XWNudl0Rlo
	 lxwDtfligKajJyuHGv5m7dR3iulVqytt0d1DH1giMQNImKh4DbJdOqwkq3r/smk1q3QGY
	 AfuUuie3QXf+3DPH+ADWcp3UVyElybK+Qqo8lx8+i9bV06NSiyDNWmik42MUWl2GluA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTMWcZcn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF8606A332;
	Mon, 23 Nov 2026 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTMWcZcn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459303;
	b=ZWvoF5K2I02Y+jm+ltSkrh9lNQlNBWy4pMNMx/yLl/y2Zjfs+km+N0rUXMOC8jwvUGtE
	 0PvtwOvANFG5Ard/APFaWpkrB/aX+gTrEQBloc+pVfdDnE2/v8BnpTBPsRwXwqEdQ6ehg
	 mK4UECkwhqNaCC17Hn0ek+0uQLbDAvMojbJyVdv0hyxF+VpwI0RNc4JyeK2Rs8cJ2VjOa
	 oRbdH//3hXwclNykcg+tOz9ucZcKkLhLZKYW3+bejnRuIpC6RXox8Qj+A0mYvmm7wDA6l
	 BZRelnwOp0aroahm+2mBgQ7pDDZSSLEGt422WGNp4qu4tepfXAzTF9GhUMzL7c+Uehw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459303;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=F2ZG4WV1JiH9H3Ur9+LrPBFzjYCXIRCQKo41Iqlytpg=;
	b=JaEt8NBJoANdmrdlvrrlzq6nM/KWMAQNK3CfSzex8suD9YbzAg//6zlvx7lVMyevEgwX
	 YHVbgoEOI2yRJ3/Jkjlo4KhKHrmamnSwAcl+rb/rrES6Z2F69iAYG4VgqT4xIF/G+6P5Y
	 bLlI194hbXEdxCP3U7D+XIDjwaehFTfcCqoberTfAYvhglrBxFpS9c6jMnqe9LAZ0j0s1
	 ui8a/UCUCYNwJLPw5oJLmE77K7Wh9vKQEAhcV4OsnSbHLR1hyU2TFPkCVQ+bjfAGV+cvP
	 uYijHaGoLytPHaQgZxh9e1CgOBoxC9Os/ybZYENXwI5xiDsCi6rJG1jTjU3UwHJCbyA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 743081F000D2;
	Mon, 23 Nov 2026 18:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459303;
	bh=F2ZG4WV1JiH9H3Ur9+LrPBFzjYCXIRCQKo41Iqlytpg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=KTMWcZcnwd/YS3HyuecHoZBzXDUxaEIO4ljOa7jw9J38bJc9yWVFz39Eb3dCOOL/D
	 3M/uNgMoKz2Bqqkayc9jfco4xhGzg2zfdPTxchowrpccpJ/XeEQ1VQPxOPsG1CKPdQ
	 WATL2WxjrgdzpM4v+Ya5oSw/HyjT2f6NhZQ2CnLw9UEZTMSdWW3Sj824MvUcnRNvbc
	 OHlDm6FFNxHqGlhfBSqhWbzXM32nXrtDucfgMTXr4wgECpaEejVcR+OoXlZ5H/ZlUK
	 Pj5DztnIPrJZJgNKq9MKvbSPXJeo8IT4RgnyzueMNpMZr1Jr9DS5gjdhbxw6+q72HU
	 taI3aB0U2quIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 049F24C5A7;
	Mon, 23 Nov 2026 18:41:32 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH 0/3] rtc: Add Cortina Systems CS7542 calendar clock support
Date: Mon, 23 Nov 2026 21:41:30 +0300
Message-Id: <20261123-b4-cs7542-rtc-v1-0-6c53761ffa03@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz1giLiWIqyCGkDhgBopiQJUQd
 2/ajm/4/wLlJKzQFRckPkXltWaYsgA/u3VilJANVFFjDD1wrNGrfdaEafcYq9a0wdoYHEFutsR
 R3r9fP/ytx7iw378TuO8PDXUHv3EAAAA=
X-Change-ID: 20261123-b4-cs7542-rtc-f0818d77fda2
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459290; l=2778;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=iQVd1OJ/+XSD6K4nQFSIGwUCtR8vm0Wjlv84V073Phc=;
 b=pwhES3U/M+fGPYj3+weEwzyknhA4SjCI1trHk9wpgqNbTH71lD9WJifK/MOox7DX1nDSVooCs
 0H1tD2m1ohzD4esnIKDp3CA1reYz3qLClhRolOc+OFRNpG//s/WLyc1
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

Add the memory-mapped calendar clock of the CS7542, based on the GPL
vendor and OpenWrt implementation. Use an independent OF/HAS_IOMEM
Kconfig option so the driver can be reviewed without the pending
platform series.

The initial driver supports calendar reads and setting the clock in
the 2000-2099 range. It decodes the four-digit BCD year, bounds retries
across second changes and retains RTCEN after programming. The alarm
and suspend-wakeup features are deliberately not advertised.

An alarm prototype was investigated on the board, but the expected
alarm IRQ did not arrive. Time-of-day and calendar comparisons and
interrupt-mode experiments have not yet established the missing
hardware behaviour. Those experiments are retained locally and are not
included as working functionality in this series. This is a calendar
support submission, not a claim that alarms have been fixed.

The three patches are the binding, the driver/Kconfig/Makefile and a
MAINTAINERS entry. They apply to Linux v7.4-rc4 without the pending
CS75xx platform or clock/pinctrl series. 

Validation:
- binding schema, example compilation and style checks passed
- strict source checkpatch with --no-signoff: no errors/warnings/checks
- complete minimal ARM vmlinux and modules builds with both new
  drivers built in and modular, COMPILE_TEST=n, without the platform
- actual driver functions tested with mocked MMIO/regmap and UBSAN
- exact sources booted in a Linux 7.4-rc4 RAM integration kernel on
  Almond+, with platform v9, clock/pinctrl and the accepted watchdog

RTC opened, read a valid date, advanced over two seconds, accepted
setting the current time and kept counting afterwards. The alarm ioctl
was rejected, matching the advertised support scope.
The final combined RAM test recorded 16 checks with no failures and
returned to installed OpenWrt 6.18.64 through the watchdog. Both CPUs
were online. The firmware was not flashed. Earlier incomplete or
experimental alarm runs are not counted as this successful test.

---
Fil Dunsky (3):
      dt-bindings: rtc: Add Cortina Systems CS7542 RTC
      rtc: Add Cortina Systems CS7542 RTC driver
      MAINTAINERS: Add Cortina Systems CS7542 RTC support

 .../bindings/rtc/cortina,cs7542-rtc.yaml           |  48 ++++++
 MAINTAINERS                                        |   7 +
 drivers/rtc/Kconfig                                |  10 ++
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-cs75xx.c                           | 174 +++++++++++++++++++++
 5 files changed, 240 insertions(+)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261123-b4-cs7542-rtc-f0818d77fda2

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


