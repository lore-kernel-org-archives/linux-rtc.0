Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794354680;
	b=N+6OGbZvKZy2sYrpXm/sd1a7qv5E9BpPgDUWfCVtLTxwlQAiN5ZHJ9mCA66wPmxrR2E8
	 OZ+fbFHoekwkprcUma3pt1ffg0NTL9odLjkbvDUFLqvcI4BUvOgkaazXFp40gvgqlf3dH
	 Li0hzldbBixOKUnMp+FC2sHKgD6ntvq/XN80w0tQlyKeBtQRw9PMZ7LhjKoFC+Q0D5HH/
	 wjuqYd+a489cnDAOa+yTdzMNneezDcdU56kYsRB3VP37lT4prChOKDLXqgLClkPEs3auF
	 +36E33e3wCed/spFEdiuW6/bLhj7nNkwod71zSoRmzJYPySfCTolDJWVP+UVDrc9Dng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354680;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6OGx1XmvR4VQSMtCunhvhj/SAy3XKm9gDW0pRMSvWtQ=;
	b=Gj4AOWO7oc83omY0caXeE5G+3UX3elSB6wbmCA7wWiH3mx3PLvLH/TBCxrLBgR6GlpFC
	 tGLqRKF8SkfrYEwjZD1Y20u5ClQHVQxNN4Dm3t8n0puHSOU6I3EeJ0fmSyto0Ozugvias
	 Wy+HtK3otczMKTm6AKHChEMpwjoUAZHDQSpAQgHr/4Bj1Z2UPD48cW20D1dV71uWZZDa+
	 1LgtSos5I15hAGFNeleIHl41474h9JOi0iQ5NO/EFpBtpJmQgFVn+2RGf3kwARuNOAqXI
	 xIlFlA7cbFmlS4zAZXUXjSr0imqyL8lHdjz1/8KLGO9eX+wCrbcSip3lKco+I2y/tlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=bahWWZtl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63671606A31C;
	Tue, 10 Nov 2026 23:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63671606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=bahWWZtl
ARC-Seal: i=1; a=rsa-sha256; t=1794354641; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=EmDBqOAib7RPXs2Io35hafHp06Hu8sNthICZOfB8436c4fJxyM9K9xhpSByg1kigzVuy/x76YyssPzVCVqW+rvhpOkOwUB261nfiICr22l2l5Z4cszJwVUM3NfA19KgM9iQzCj5FXRFrhJwHbHoemfSW5vG/khZcaoRW7pGdoCk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794354641; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6OGx1XmvR4VQSMtCunhvhj/SAy3XKm9gDW0pRMSvWtQ=; 
	b=FCNoKGcgVXUbIPq+vnn3rxyBAnYqhKEiOY8Rwvu3h3oBYJHnL418VXLdGhrM3A0sFy8LV8I+awBiwxhqq8aBptLfXu8kVO5ug5u/BoY5GDuEwMr8KFodwj9qvE6tIMzDpz8iKNVXcWsae+tHqhtiWKZdwkXVng/wEGk9yzcdKsM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=bahWWZtlIwNX1VYG4dzqH49d9CZ7bv4qhRrXlRBuzmiXDRUV3OqPoEEAyzQjRapbU3UIJ9dJTKF10km2gaFVn/fcMf0gBzDT5j+q3lyyRlCuTc9NpUEJpQQ/bSA+n1O6TCZx3rq2BgCZWHWTGSUbtbKNSRHhlU+8ucReRvAzmiM=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=6OGx1XmvR4VQSMtCunhvhj/SAy3XKm9gDW0pRMSvWtQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794354638934632.5692174558644;
	Wed, 11 Nov 2026 00:50:38 +0100 (CET)
Date: Wed, 11 Nov 2026 01:50:37 +0200
From: Igor Velkov <iav@iav.lv>
To: Thomas Gleixner <tglx@kernel.org>
Cc: John Stultz <jstultz@google.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH RFC 2/3] alarmtimer: Choose the wakeup RTC by sleep state and priority
Message-ID: <20261111-re-tglx-alarmtimer-rfc2@iav.lv>
In-Reply-To: <87qzgsth2g.ffs@fw13>
References: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv> <20261104-b4-alarmtimer-rtc-priority-v1-2-e996681b8086@iav.lv> <87qzgsth2g.ffs@fw13>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 11 2026 at 00:14, Thomas Gleixner wrote:
> So this gets _ONE_ suspend() and _ONE_ resume() call and nothing more
> and everything falls in place and is comprehensible, no?

Thanks, that is much simpler. v2 will first replace the freezer_delta
handling as you sketched, then add the per-state wakeup_ctl with one
pseudo device and no priority, and reject suspend into a state without
an RTC while an alarm is armed. It will be based on tip timers/core and
follow the tip style. I'll also check whether user space looks up the
alarmtimer device.

Igor
