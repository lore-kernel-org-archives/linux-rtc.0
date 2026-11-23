Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459322;
	b=v/IMKLCm1cXE88pxPsQElyxad2u9c5H+sI5XayO42YR2IgEaAvcJmHC88+zhGDq/L7Fd
	 yHX0ym43uuGaDu0+bBOBKm2LvrTMvY76G25Kle0rjGz4IQGb7CUSRpf0grVGTc6ptkgvF
	 ojyIC7Oe6LP6WqIUF7+y2BBROW91CejnBzLJiz/VeiRE398olGgA6UjPWFCOXRh1NTaJf
	 6iRKZ6qdi7aNjf/u9BD0hPUJUoievuoPmw8/xyEUdg9xDRhEMSAv67CIWZeD24wDy0nEf
	 fwhe8ZBQnh1fTC05AO/aDaP8fMSldptxJs6octOWRf5egOVCgUSf/8xth4dStDtDvsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459322;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	b=YZECpY/JSpqeESnqD7QQqu/1X+SvCn2fr7wdjvdwaEXzm3tOACvEj8/rY27/jZHQWeLp
	 GRURrz7r3pMoVHL+RRzIM8psFVaqASTdPot55um1rsAAbNzWcnRHqOvYc+kUOQjrOw7xS
	 AxPRiv34ev4bj0abwbZNBVIY03WY77cFmcQUyKl36oZB+vQE14aeiaffQ700YQaOqMznl
	 c/IBH49opNrLqUlaBQ39AFzmRmWZ2ztQ6MYjbg6gZ7o495qfLP3m3uvHFgqnXRGXpwg2h
	 Zq5CnaPqwSSQ7hs8c00tyc2i4ZrA6wbUmPPJmMEmJqxWnl9EoBv1D9CsmitgjIhSq4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jIOS/82A";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96393606A685;
	Mon, 23 Nov 2026 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jIOS/82A
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459322;
	b=jPnYBuIxuCR1tn7jeZpvIqWNJGEI/I8ca0Q2DJPULTdS7n1tvMYAXVINDNQnGckXVp9m
	 pDtZCgNYieI16eCHCE5LDYTMN6Pn1AASuLkmcZP/14NfgFWnhHJ64Z2dVmxQVnU5QCWyS
	 oC/ApjfXfNr0SVm0F9bk7wXOZE6FLHHkORYlp2wv6YjUvoyXNkh2C4lt5oPvm+0+l3u00
	 tCYpkJKHEXUi+BgwsIFSB98xT1S1sfKw6B+rzyHIOibaQ69MifAT8t4pd9dySoDkKv/jk
	 BPEc6TY4P3hH8iPXrUEMQv5An1vJsA09crA05/M5RZ6OrK+Xlo9X3lbIoPp0OmPf+cQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459322;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	b=vkPsdxI4c9fNxSL5XN6dxgoYJSJjkpZVoZiGMniMwZpVYPL4IQzOOUDWd4VqIenP1+Be
	 YOTRsAfPd8GJLlyzTBgT2tJFCP/AczNFMyKDaVR6Vuq5NFMd9y8jm7thndJXS+w2hL3I0
	 yQGTTp0odXDWiQ8j4Ns02Ms/VbpKdwfv2Y5hmvKA/KTngacQd4P1ZIGkwMLu4M0zHpKZ1
	 62Oy9BKIF9Q1cqR166vVQIF6XP7KbB26/lO54Qxsgb7OY0Okbz2mhA+3dbWg7oNcZ2lau
	 MhpfaZ0G2SUn0qMaf7dHXS4rnoVJI1ypC8DEIvMnoI8AmR+EqHUzTjrBnMxBUQq4O0w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CC5671F0156C;
	Mon, 23 Nov 2026 18:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459322;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jIOS/82AEYLXbwULLokzXs6m/j1dVApvba9DuBV5pHaq/oo65Jm4qjBarTtURGu8I
	 Bq4PIqZP47d6oPQUI0kHLte7rUnGdqMgJ/tNnTH+k3AEN3WjpKWqN5RWjdm3b4cQkB
	 nigwiOzKpYzN//jSefTdNjaG9mzD288/6qU4MMFfHj0NvwcB3LtrD6zRxrPxIl+oUy
	 dLUq+S0UZOnuPzZ0gRfNor7ev+Nv4KLzzMgTUrtEaNXRvAJvS6UHo3Jd3lARdSFOAX
	 Y4MDqiulmZg1u4mvgAroF2A0AROy90CnoprO0CDbI4UNVyFBG++nsqKDDvGtGxU3+G
	 2ygUgs2N/mE5w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5E9604C5C9;
	Mon, 23 Nov 2026 18:41:32 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 21:41:33 +0300
Subject: [PATCH 3/3] MAINTAINERS: Add Cortina Systems CS7542 RTC support
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
Message-Id: <20261123-b4-cs7542-rtc-v1-3-6c53761ffa03@gmail.com>
References: <20261123-b4-cs7542-rtc-v1-0-6c53761ffa03@gmail.com>
In-Reply-To: <20261123-b4-cs7542-rtc-v1-0-6c53761ffa03@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459290; l=864;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=V966SZMepm42nKofeQHA+zZwJm4nGNGjIsMkGKj6kQA=;
 b=1RBK6/FmZlQkIq1D6w5lUoO68Yaj7bPM2/o7liyZw9RVPl+ArlamOzDlUJCdqEPiZ/IGWGiYd
 Fi5dlQL4fl4B9XM5RhnTvQsMJ62q18bFo7d9/xzklipvNQ7l0GAwjyQ
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Route changes to the CS7542 calendar clock driver and binding
to their subsystem mailing list and the platform maintainer.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb..e7f97fb96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2949,6 +2949,13 @@ F:	tools/perf/tests/shell/coresight/*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
+ARM/CORTINA SYSTEMS CS7542 RTC
+M:	Fil Dunsky <filipp.dunsky@gmail.com>
+L:	linux-rtc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/cortina,cs7542-rtc.yaml
+F:	drivers/rtc/rtc-cs75xx.c
+
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 M:	Linus Walleij <linusw@kernel.org>

-- 
2.53.0


