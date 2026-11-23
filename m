Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795471216;
	b=J0xRSjGQTVGMYleSpMwlL08P6cApzCB+y26WFl/xMuAI59Ujx+SJUdp6UD4W2mr9C+Ku
	 WfkqwEdskWrw6IvbognyVQAKaZiChmgp97BA49yUmV4FGCqIHwhm6kWphw8YtGmHdgLHj
	 jPj9GF/+ohQtWSwmEqvTR6dt3disr3iqe/HFwOZQ0uc8wo2yawr5C8OZvo9aLiWmrz7p8
	 XZIKIDLAwxJUiMrCOlb07sFSLWrizgLNX2/n9Y+7+sx2wcFPFazZcPKzrFbTdQq12TUJV
	 BM5BlsV7FJ6B3yOTKvYGe29YfqJT8gXdNGzt9uwR22FmZ4gbVTbEHdqAHpsj0GNkh/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471216;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	b=vvzlypsDUDW9GlBxL5ZPjeqj8kMGlk5TBSuJo5gTQ4ScXYGHbC9soHH9vZ2sW9wftBxJ
	 Z7fuaaUI2cnkf2zFWnFvwHTfL1EW4vqK/rQjETD1u2NNlHVUoZAjCHY6+vpIqxYZT0A2W
	 BMswDDUG/V8c7DXUysnHhGTGKsw+z9m+QCXDRUugPyuF2DXwkht7+fL60aM+3XYj4hN+j
	 StCS4DbtTOWAcTrBTl21jPmuSEN/agRNr/ZzFA3W8AeRafhcUC8RT52NzaqdfN2mopAHy
	 SkIO9lD9oMlwV6ccu3RPUIvhsBl0weycS5v2UfLF1UbN3w1VUAkEzalnQm6g5EpK1gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgoFi4+I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03407606A321;
	Mon, 23 Nov 2026 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgoFi4+I
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795471215;
	b=ihTfVDZ3sEeYoXVDdZ2j75ik70sdR+5iNRFp8zOmBWdbRUde44tLCtGoovC9G+Jw2py7
	 iSXr+7GixrAt8kondCQb2Sa6ZMo+SKHkv6sNRIb1ShRB/pPCmk43loKMMG50qHjWmufQj
	 iTLlwydK4P6Xh689kS+X1OTW0H27JeUyIlxPD8Z9PS3F6nRJfNUQpVT6Whe0NckCicIHA
	 DxP4emaBONNCDj0Onc2SfGoMbu/dlUrpNHxsTduEAC5lzg4WXQGbi4LPilwyJyu+ly47/
	 XOo4p8Lr3Pa6R17xjDQLzWmmEq6yfpfS5Qn6G/aijGVkP9yyAWMGE2oHcamdYtc+WJA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795471215;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	b=XBz32LczNfSSGSGioARdIK/bZFUM34WoO7WOEwWUEBnhHTKuY4FQ0wHubaG4gLDwocIt
	 3ARGXn+OXV5A9U6+8pl8vLVdL3qWyV/bxKnz+BB7fjuq3DhQcvqFsr4PcZAKqPkuZHMHy
	 qjZX5/sslwUjR2uKn++MLx+x3ZVw1HKj3BZ2stOpRFvs4+YhkOhsLX1tB+YTVrLBjrDBn
	 ag9udvmDBV60l3khS5CiBaSrTRJgtB7SrFMkAM5RzDgCTyn8EEW0sNmNqIN98KDUr5OCt
	 zOwGMqdkrchyZKQWU5b0FN7aK898gvbswtjAReT9Yh+lBDKXBqLM+QgyVwU9VTjfzBw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9FC571F000CF;
	Mon, 23 Nov 2026 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471215;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kgoFi4+IZv25XzK0f+NV0H6tSkFirkabpFvlpjdXWTTSQrl4bBToioWNfM8g6qtjq
	 zXwfPsC8S4g9qnbpzr32eZ4jpJHE1Wx6cPlLCTdIF5SWLwHRigEynbHcY7rrFOTfh1
	 NeGSOER0ZTUtIWW4W9qy6Fbcrb/hwMX/uRZq24VcYQrdlAVknUl3+unOn/j/9N0b/O
	 nLClDYlN8cpu8c8m27AfD3nrKfcg15bvfmq2J9ugKzPEeLOzFw2mz1KUxM26Oz2SyJ
	 os1+dLcV34R5K6oIeZhv6h3TnrrnwVkdWknhXD2Mm1n4YBncn58bDyHRyeEu1YqPN8
	 qm4tngmh/ZYAw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2F61C4C79B;
	Mon, 23 Nov 2026 22:00:14 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 01:00:15 +0300
Subject: [PATCH v3 3/3] MAINTAINERS: Add Cortina Systems CS7542 RTC support
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
Message-Id: <20261124-b4-cs7542-rtc-v3-3-53902bfbe0ae@gmail.com>
References: <20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.com>
In-Reply-To: <20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795471212; l=864;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=V966SZMepm42nKofeQHA+zZwJm4nGNGjIsMkGKj6kQA=;
 b=A9V7/mpPv+/bcY+uKssDtaSgc00coIaWRpY0v3mYhojSvOltGnigrmmlCd8lMUXRhVPhtyjN6
 e9XyC1ZUMfEA7n9JxjlYJWWqjC6LEC2EWA725FQ0m4z6nN7cWAEPctG
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


