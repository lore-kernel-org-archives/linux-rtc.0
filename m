Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794239099;
	b=yMsP2yPuqOFYae610qbWZOCBRwpwiqwByGxDbTLrrb55phVUAbcnY2DIrXxtUfhYp5tk
	 ivl8Nw6adrE3MvXX+AwC/uwYShhCU/Rqyid2l78Zxyzh8Nxxhn8CvigC5eh6v1FTic8Xo
	 y07zejOXv5Pm9cSuS9sq7j2AuGoEitTp8cyIAVMRRY+YkKkDDc/JYcCJ1LMK460clVObJ
	 wFVimuZ0YECnOCKIjPAnZimFwprWDqM3pwxBlNmcSJW4yXm8KsUbJcz7alWBumb0BDgnf
	 VWOFcLwls8nCpg+pWYeVDZ123cMgOS9bwLRX0us0BVal+8FLdjjFXsRHGTb1rnXyvTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=NUErs7NoE/3bV36QmlDjG5zSS9BL+CCDMLSs4x6fzbQ=;
	b=WDUj6dL0dpk23YosSMSLc40xx/GWygZVriRjYd/t+obaU+stTYFyM7IgHlfDrrqsKZ8U
	 HhY4OiYvhkbH7zr3SmqlFgXy4h8mJUMaPKLZXJRrjXiE4Y3N+QAlTfY7ixbPviPghpAd3
	 O5ud2PqbBFoWxlM8Em5RiyChjYh+3snV+SqC023Mwt1I5XaW9k5zsWapuA2RCjb0QBn3d
	 TrSoByPoRx+yaelQubOdTsYTu5Et0ma5HaIK6WDcG9oE+xl2cYLqei9Px5Sr8VcK2FBPU
	 fK6e9w+pHmwF6qYZRWUwVWnE8/FDl3OAHSn7NAmFH6qLSxWQJSL9T+MQZG5r3Q1b/qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=djbvy4bw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9103606A31C
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 15:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9103606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=djbvy4bw
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2020314eec.0
        for <linux-rtc@vger.kernel.org>; Mon, 09 Nov 2026 07:44:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794239098; cv=none;
        d=google.com; s=arc-20260327;
        b=JHKqJ7SwEs/egTZz9sImmt2GFIy5ok6IPLN6ybeTtpui6PikLW9RdXR42A/X9K/IEM
         kUhnp5KP3Ar4ewtTyxCPoYnXR8kAbWKTV2M4GgE4EIBKQ0SqVzLyCci9+enwmcsl12/K
         C8t23ib2uTavFRS3soonHxdiIaA0fQAQ9HwiV/IpcfFF8m+mDGAogk5/pcmCj/d8D+mP
         Rc1VqgfnzTfsImsGFmOzfcm7M9OQ2wLK5IvtLyPDl4S5kQZwVnNNsTxTZiSvbGjbWmfc
         ens1j9ZTVKQtHrfoW6nofg3EaUNTXkRD3sw4CH3TvIfvRY7kBKSbvIqcqK8igeHciKR9
         8spw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NUErs7NoE/3bV36QmlDjG5zSS9BL+CCDMLSs4x6fzbQ=;
        fh=ycDV0IHZqUtHEL4g3zEQCvcNpLE6OqSGUyY61UdNuCw=;
        b=Gsy0fLdx4NdTyTCX++wWi/C7NH/xe9ZO5UOjnJTAHn0tjTFwgUQcGOawne0G3NNoGe
         wqyhUf10BYr7lIDBuODIaBiARXLDTpHYxEwIC5h8vrucgSGmsbBstyvOA5mZLaDpddh8
         8tfAfvzaiD7LHga1LGmiF5+hQEPcTKcutPxJzS/kPcBNNoXSLe2OqPv6iQiwGGJv1Ny9
         Fj/q2dTC9HX+JR96Y3vc+0+LrhIUaN+9ZSeSOejk1UfbmsfMNvR/ngsna8PEDYCHM8EJ
         gQk3+6QJSzAsvVPM4j3b1jv8/KeJ6m4pPpaceaxyA73UCTPxxZSKAhNV/CiYZPyIHHqo
         A2Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239098; x=1794843898; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUErs7NoE/3bV36QmlDjG5zSS9BL+CCDMLSs4x6fzbQ=;
        b=djbvy4bwkHrZROZXukKzRSHh2GUcPF03DKtky9fbjTceOp33XSQPCXoAdSN77x4T33
         LctwVm6RKcbmcj69zO/r9OSQE96RNK4cryEgnUJ4VIjlvXN6HJuz4COF8XIywfjPcWgj
         TnC19638IQRnLdrPykQ+FnRI2ki8Aa+AOUZUjD0Bjfa+8Mje384QKNaWOs+3eyceTKAa
         42+IM5oNSdk8HgJ+YNwhAI0YDSIQZkKhWlGf84WQSH01H0Ahi0RjWdWsrxapEygkeEBy
         V8ud9zrJzjx5o3O2dzZFLVWNYOXJXUvE6y7hAKV6dRLU5Z8l/zJXkFoCmQCGYbwuhQAw
         rgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239098; x=1794843898;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NUErs7NoE/3bV36QmlDjG5zSS9BL+CCDMLSs4x6fzbQ=;
        b=Ue9Ku3fHV+FSL1kPaAGdBHoW0xJuANw0Yui95AE9MmsnkpF/0zz/lqWnjj7mFm7wCU
         hYMo4IN1H/EXtm9Ur3OVDaOUGus07tsv9CzHgNB+tbWOHOLWvUZ6oT4oAF200Vq7aEpC
         8zShfRhahoy5kKNZaFULxh874g9CNw9SKECUN3zeLMpBR6rk07icXfi1PpCxJukqLNdg
         0W6T9eFcmBv4n+fiKfwi+4YeTEwx8ktjqbvTtOrTVL6SAKvaZQaf70otEi5XBmxZvu0A
         WFqdnMB58rTbTGwc3e7ZRlJfhXHcVubo4jKfKfw1rJEipgzNKxo9h/+xULG14RBn7w4A
         JgWA==
X-Forwarded-Encrypted: i=1; AL+hErFL9wsPpgXtpFUhd8r+YRYrHV6278tX4iE5hJUrsL/JlyGSL/V+1o86QQBhdPYcd2twOxt7d5NyfA4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Pot8GxLcSHcwVsWq/Iin0ssKUjdp5LJsyt6N/ouf1oS0nJfpc
	UGlkvnUcvJAK/V8XYw2nZJEo0udY/yZySzPWlBi7dwZc2Pt1XjnGnF4MnzqMsSEKpbeJUCdfUwF
	hopYFG9oC+bzYeAEdrdWjoerPyNj0jxo=
X-Gm-Gg: AYBFou1Fi1V7V17RpF8u9su+QjfCdUXfWtLAFfkQ4dERjiwlaltTkUuAi/C1rix82Q7
	0uQYYrxNc4piSL6TCK9RxpRSoI44waZQ7UpQ9W9zYZ8DGXcw4l3G99puWaT7ynMKwJ7/RLLoxIW
	tEkooUe9zfBB9erSYpbckN6JLiL4Rj9dTN9nqfFtM7SjhWQPz9C3KK+MnFXKsd/7rW0KtAD12QK
	jfu3m+vXp8WCPAkVCs+tVOzM6GDFBQvpIOLl3MXT5arI1N2O1yGVTwLene1WeHuPmooyMgP0H3i
	9KDnjQowI1m+J5kA35t02hPYvWh7RsFnVjq8zPI7DzaEhQQwnopLkOFk+VMpjt8VN5uujaFzRzD
	eFX1u4HnIW3H0wYOzotzNCvVbCpw2oa9A0pwY
X-Received: by 2002:a05:7301:da8b:b0:36f:4d62:2884 with SMTP id
 5a478bee46e88-372575c62b8mr8103918eec.30.1794239097992; Mon, 09 Nov 2026
 07:44:57 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108212826.15890-1-oo.hehir@gmail.com> <20261108212826.15890-5-oo.hehir@gmail.com>
 <d9f4a750-5f9d-4749-929e-330c8776971e@freeshell.de>
In-Reply-To: <d9f4a750-5f9d-4749-929e-330c8776971e@freeshell.de>
From: "Owen O'Hehir" <oo.hehir@gmail.com>
Date: Mon, 9 Nov 2026 15:44:20 +0000
X-Gm-Features: AclHuK9x9EpRxZ7OnBIKVHuPQ20ucbS7TGPBTpDY5y8PK69Mzss7MIfYBHErfIg
Message-ID: <CALp3LZ6HRs9pxPHj-4TYPS483cEaVBJ_kOGYmaWr--MhfQ6hCQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] riscv: dts: starfive: jh7110: Add the RTC node
To: E Shattow <e@freeshell.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Hal Feng <hal.feng@starfivetech.com>, "ziv.xu" <ziv.xu@starfivetech.com>, 
	Conor Dooley <conor@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

Hi E,

> Is status property applicable to SoC rtc? If not, then is 'rtc' label
> appropriate when there's no status applicable?

The RTC is in the SoC always-on domain and its clocks come from aoncrg;
the 32 kHz oscillator is set in jh7110-common.dtsi, which every JH7110
board includes, so no board needs to enable it. It is left enabled in
the dtsi like the other always-on nodes (aoncrg, aongpio, pwrc). Other
SoC RTCs do the same, e.g. Allwinner (including the D1), Sophgo CV180x
and i.MX snvs_rtc; the ones disabled by default, such as STM32, depend
on board parts that not every board has.

An alias is only needed when a board has more than one RTC, and none of
the JH7110 boards in the tree do. A board can still disable the node or
alias it through the label.

> Note that Mars CM / CM-Lite System-on-Modules may be used commonly with
> board carriers which implement a battery-backed RTC on the I2C bus, and
> so another 'rtc' label may be applicable, something to consider.

Good point. v3 renames the label to soc_rtc, leaving rtc free for a
carrier board's RTC.


Owen
