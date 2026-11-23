Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474301;
	b=qep1TGq/yrkr/7Ql1BxIF/nyUmAUXCjX/qEniJMhSElsf2dIRGEt1TYf6UB+Uw7VdWTF
	 hX7XrK5X5vvuBm+lDkdx3AvMoWGiV8WBOoqXt6I+HyBu8lEk//WnEHZahLVJ5FcG1DWgV
	 MteF7iqtu+WUGjTm8kLaIPYFO0XcZ12JRIJuMuryiBXvOd5XXznOfVjAdbL6gltCxOmhT
	 uaXR3xE6K4HCJ5OKD39rWHiN7xP5rLZsbHlVxju87hTzK+gZJQRTjJ5isf0/I3OCFyVLk
	 zvSuwZXYWwQJVPp09ebjLRHkKQpK1e1hIJvsi9e2czVaOvsYchMdzXa5HlUbtPfawig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=ahaMej8DG5x+niwqDwGDjqEkplFHIH2ZYDylFYU9oY0=;
	b=REp3fcgaOvBTEJaaQMPvhzKjhqugwiqvFkcluqEriAzpFvi53kl/4/aiD0qy1XZLRKk/
	 bD0b7skUPcjR3knQo5HYsdFCD44+eDjYUUGXE0yl8nLocMQjNthbfuf/ja4OdneANxRql
	 4F31aw1hSlwdqW5eb7IKpQxzNZ3XHO93Bs222OP/hx85Nwv3aVbz+kaLIUri3WMLbF4AZ
	 fqV/tpWqQYHD8dDVM03/3pu2z6ETaTuzk3eUtHhG54/gygy5FH3/qLeztwL/I+hIQg7wm
	 DUmZfeyRbcFgvjECi5T88ptdFnatH0TnxRLaoPLeTfWjRYom4Y8Mt/+IHbBuDK2OJlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YRbfmsEb;
	arc=none smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA942606A321
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 22:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA942606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YRbfmsEb
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ae25d9e2fdso39569211fa.0
        for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 14:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795474299; x=1796079099; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ahaMej8DG5x+niwqDwGDjqEkplFHIH2ZYDylFYU9oY0=;
        b=YRbfmsEb/hQOGAmXBF7R643OZKuSR1qRrsgm7LHHfGRqxf8k8EwaQUaNDaegKDxgeM
         ZV4ML0hnBAjir8ppobqGrNENghuxdG8FjKejkD1JluhPwmDT7R3RXaKFkCA0e8UTYWTI
         3WVz8N7nUWxpT2By0hCJRR1sqLwKyVwcVWIgkPPZQOlsxP3/jjJYyzwJkdqlSUdxntAN
         92TJEQcfjbpud8ss9bN7pb9K6Ht01WVHRuu+++I8niqFgIqrma2h+vwPQyjBe+gpsBcO
         S4UolxbVHleBsrryCLTiSxVwBcDYdUtVAG6WotTc0lvQUVnfQ9NSB2NmOoM5Qf/eM2Cu
         GJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795474299; x=1796079099;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ahaMej8DG5x+niwqDwGDjqEkplFHIH2ZYDylFYU9oY0=;
        b=w6Gfg5WWmGvsiaZ+ntI9bNbxqWGT07B9GTHRvA5R/iYZNJ7G/i1ZK7eM4p1Gk7F2gO
         /BixsTWnnm3vN0t6yspHKMaSDIyFgr+QQoh4sVPqRM7FGahsVuLlv7mOXhjsxnsd9EnG
         wCyuc/XhPpfeHuqVrcfDmfrWeE/V2HHHjG07LD5XHPHV2ow/nSPei2adjD6T80fMfaiN
         8OzMLPaau2V9cNVTv06n5IvH3LBevfQW6t8OafxigbGaYI2Qp/wq4WHiwqVkQGEqku0k
         8ZafX9aOZwzDTBem0kwtP74YBh9aVrtziIIrAmbEwyvXgbtNhHSzd0iFvLprc4/pLJqE
         FM3A==
X-Forwarded-Encrypted: i=1; AL+hErGPb6a37rvNaXPizA+nMNmAPs3A78HrVLU8um9/jLL0bOcxBjYMbiaa9hrYT4MBKTOoPCYQVYC+XJ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RCrjrKEitOX48YYCvD0WS4dl0NtUxlXuqJxSXsGIFaYDv2CpZ
	waLv/FZ3p5uSm9KWa2y3rI8b9AKWqGJYOnRB9QxMsE8iC0GCKdpg9whG
X-Gm-Gg: AZFdTZcnSQxPZkYmrGcQsAXu7/jX5R6PO/RbHNFQ+Y7CqyjCxmTXyXVsj6rmAk9ml98
	N4l1PnrEfFn/hpqBkgjO2Jm6M9yMUSHkv5Bkqz0sSQAtGeoxbKxWQGVafmSqRNwLWUBi1ZCiPgH
	XbvXWCotvp6v1fO+CVHWEW+2qrn4NNckSVYdlNJpWrNr9i3mD52kxT16F8IAPRVRSRG2jPECk5S
	3Eoifzm4dOTT41Mqbw+75/sRDHeuDM/Aqyte5EqzJV8D9PUg0VIpf53geD8JLfoldKRpBQXp8h3
	H+LvoRJr+COOhdkVDeQJqZrKEwKevMgEQqvCQe4LTmo2aJTbpDbtNsUq0iFeMc7XmPbbO8ssuMG
	rsmIH29rnFrq/odWHJ9azC0G9D9Qr3DlY3s39ZS6g00E20WX45qX8IW3SMtCcV3LSuTjp60JZYf
	3Uchy2yiNn9r2HMBm2n7+BtiKLphS8Zgsc+KqmQCkfdl1XAny+wTdPE42iK+eNvi3iCl+Q1URVG
	KY0LK2cBS4NCyqubscudhQsYXXxUcWJ9U60hKw8zb3Ys9xlVE2Aecw7mpWQ5ooXnnppqApM7Cbi
	bz0A9/0KwznX9KI+gE84OwlHDyh+T97dtlhFCg+GjYy9u5nHAuqF36c=
X-Received: by 2002:a05:651c:a149:b0:3ac:e4fe:49c with SMTP id 38308e7fff4ca-3ae7fa65ademr37338301fa.21.1795474298759;
        Mon, 23 Nov 2026 14:51:38 -0800 (PST)
Received: from [127.0.1.1] (ip-024-180.users.dtel.ru. [91.210.24.180])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8051bfbfsm36143811fa.20.2026.11.23.14.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:51:38 -0800 (PST)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rtc: Add Cortina Systems CS7542 RTC driver
Date: Tue, 24 Nov 2026 01:51:35 +0300
Message-ID: <179547429575.493865.18130205107556064582@gmail.com>
In-Reply-To: <20261123220804bcab0f99@mail.local>
References: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
 <20261123-b4-cs7542-rtc-v2-2-31ab43f2cc8e@gmail.com>
 <202611232056209fabb078@mail.local>
 <179547125963.75567.6386430167092445665@gmail.com>
 <20261123220804bcab0f99@mail.local>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

You are right: I used the core's calendar-validation boundary for the
minimum, but range_min should describe the physical hardware calendar
and its offset handling.

I checked the lower range on Almond+ with a separate Linux 7.4-rc4 RAM
fixture calling the driver's set_time/read_time callbacks under ops_lock.
The normal RTC core rejects pre-1970 dates, so the bypass was confined to
that test module. These six cases passed:

- 0000-01-01, 00:00:00 to 00:00:01, with raw BCDYEAR=3D0
- 0000-02-28 to February 29
- 0099-12-31 to 0100-01-01
- 0100-02-28 to March 1
- 0400-02-28 to February 29
- 1969-12-31 to 1970-01-01

The direct callbacks succeeded for the low years while the unchanged
core validator returned EINVAL; the 1970 transition became core-valid.
The module recorded 219 checks with no failures and restored current UTC.
The RAM supervisor independently restored UTC before watchdog return,
and fresh host UTC was verified again in installed OpenWrt. No firmware
was flashed.

V4 uses RTC_TIMESTAMP_BEGIN_0000 through RTC_TIMESTAMP_END_9999. Its
Kconfig help explicitly describes the hardware's four-digit calendar;
ordinary core calendar validation is unchanged. The source tests cover
all 10000 BCD-year round trips, and the ARM built-in/module builds passed.
The hardware evidence consists of the boundary cases above plus the
previous upper-century/9999 tests, not a hardware sweep of every year.

V4 is posted here:
https://lore.kernel.org/all/20261124-b4-cs7542-rtc-v4-0-bceefd844074@gmail.co=
m/

Thanks,
Fil
