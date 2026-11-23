Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795474215;
	b=fKrt896nLuS67kEKhPiEB3Mdh81vwGR+bAkpi8lY/+CIq71dgzYv9zIq2BlpGivPVJb7
	 mWSNnq1VhHZqthFeaRdIqxnL15SbL+CJjVfsPtlKcGALlzGaRGm3/Twr2EXwcrmP7h9EL
	 NHaiRt1eOP48Cx573gVxdXVQZBc0lOJG7fyL4Z80dZ3xs5o8tpjhHxq3dczUlchxJr9XZ
	 qEdOJuzVT2k/8iWaeC6+hnJ0FL0kK6E4IdrpoVQtVgo7EExrg1AYNAlFHTFTcf7N35bBr
	 htgTJdXSSrYAC5iokhCViPq3o3g2rbjvtYvO0/hf14pps6VVY3WgpdLfj77W1/Iy5fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474215;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	b=YX56XEjmf9DNsEbfPDcNwAlHwbm1Dnvg1TAPBhtveFn7/mgfWfzgK0t7Pl4lWs9Hab0U
	 EBxWG+Os0waJ48N1FNTmc4oK+NSpa+bHZ8nEWxfoR2igPL2Nb2Oxt2o8iF4MGxMod/4v7
	 PxkIfx0UfHxtNqpdGoMyggJ+Qrqgx2P35oK+A1BigZDZLEAoWQMiL6M0/KFA503KU5frC
	 X1WxEpxrGeyDAD5EyZzgiJCjp7d8vJSUrU5WrHxQz8qhEzv++kp+tQUEn/qLZawWFmo5e
	 GTfWjkA2SApUEbDqOI6SwBasvk7JQFV6+SAtsxCS/QIUMCQKB2kglD7/6IZmtERN9tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7HrBquY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0862D606A33D;
	Mon, 23 Nov 2026 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7HrBquY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795474214;
	b=0mbmyuHE/Fxk3q5deDQiKQyxBissX8h1CaEms4kDTM26U+VpZHPnJUcKWXlT7qNE2Vm0
	 fdDARcctsQhM9ks63HZ2Ca0ltfU1fMJ5Cf8Z2QolDJHHBTYOvUl243Jy2kAPzZ8r2+O/M
	 ZroXNaYpmotqFXnAw8FTVUZQ5cxA1him+1X8sGOtXovoKtXhJ7A131u1tivb9bl+tfOQ5
	 DGkgJRxTD25k4y2Q7W0TcyXIa9uiTcsNOMdfCIdFFenPRbQYPO67PcKsxg8fFqXpPoNRL
	 alHeCmc9cIHGq9s3vWWOeKu81r/AQH4j2NBEa5wliEG1Ea37PS8Psagiw/6jpX6L2hw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795474214;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	b=FWyulz7g+2mh+bS+4cqQ19odDWn1BKIxrOXWjrc5WVAvQ3Q6Diezk5AwHi3TOp0I2RI+
	 2DBlLOJFC3bWTko+5apjbYPXSIr3pGLd3uvP8gZvMJX9sw5RZQmpJ3I2WxSOnjRBOmIDE
	 mjBarvbjEGkzk5+Xip968fh9LOIKaAl9fVXzpAlnwLv50ML2bG7wch/ycIKYs9Z4PnjVi
	 AI4w8+v8wd0BGVYBiDd28BeJmb1nFuCJmY4OOQq9ksXZujZfRBhkxyJ/2az7NHyKMak0X
	 ZLLo1rWbjmXfvEy5XJcFaUbOki66Q3YvhvsUmkzyNEoet78yYuakaMHzxITvgPjqwzg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 33D0F1F000C0;
	Mon, 23 Nov 2026 22:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474214;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Y7HrBquYjf1U/NKd0G56zDe4NMV6NIDq2xLx+griq+OBoLoobRyytxw/ABScnqu9L
	 9Xox7xg6Qdhi3kk1PrTlzbPcWDXM+O5u9N6H7G5W4QLYrrz8PecRNxxxPQl9Q88wyH
	 hYYU+X+W1RTk8tgRkLgvpmv6NhuXYCgcAOkrr53w1HuHZk/Mm8ifo0zfdHGsx6Ixl5
	 RhxeEWixL+CkeMfqlg6HQtY4Xk4UQWBqquffuDsdwozcRMZKuna5SUUzRtoTncZo6J
	 iRky2g8YTMubuSbtQmUwePskwljWyMcnYVsk6qEQOuruywfSRGkaOVfIIXi6knFOLd
	 sDW1ks3UXZd3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A243E4C7B9;
	Mon, 23 Nov 2026 22:50:01 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 01:50:03 +0300
Subject: [PATCH v4 3/3] MAINTAINERS: Add Cortina Systems CS7542 RTC support
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
Message-Id: <20261124-b4-cs7542-rtc-v4-3-bceefd844074@gmail.com>
References: <20261124-b4-cs7542-rtc-v4-0-bceefd844074@gmail.com>
In-Reply-To: <20261124-b4-cs7542-rtc-v4-0-bceefd844074@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795474200; l=864;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=V966SZMepm42nKofeQHA+zZwJm4nGNGjIsMkGKj6kQA=;
 b=jH3/7RTRZDgM5Ow9roOFp0SEyHkgaHTQMntUDX80gCRj08InlZ1mIsiYYxCWn1XrTRG59qjYJ
 5NmtiAT7b/EAje5tvsQrfUvse46I5lMNt6fRXBtX4yD3Y7utJK9dj6L
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


