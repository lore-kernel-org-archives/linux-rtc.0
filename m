Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798341;
	b=s2/Of4aJoXxTuDet6fougZjmilT+elAHRLmWgHWfgTwOorrB/z0KEaEKCdRkvD7Fa6aW
	 /Gkm5ClDuK50Rr/dLycRnMBv6Uf4Bg5NvbTZANsFxyKLAW4XhvzYFaHFdKMtG/ryaOwi0
	 gVgww+QoHOrHBWYPx+KOWSO63A+bjXXQCTYeZQFD1xyyabJSrmUBFO1JO65+WCRPckEL2
	 WhW3ItIYuZ06xiG4Urd47pUjn0ZPocn4Yo+T6Dbrr4gA+29hoJ3KJqPZ2QXvPXRaAne74
	 F6KQsEL+UVvHgw4bio73qlIcPDYMYxcrYydeKG+fiRH4HZM10R+r3Qm92dJX4uJYREw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EDMWVesK5h/G+OAeuVJlhdz6opzFKvO3nN9e5kJXKQ4=;
	b=FOhkL0sPlbNKpsyzElSKI5QoELFN5lCwTgQJk2LlbfTfDjXY6m9XD2qG88QtOuuqD1kV
	 TrAqLyOeXyH/tpXCrsyPGNJhGI3I6XV57NgV4zunrlE5pjlrLGMHmklU+qb+swAhxscre
	 jgG1LuSXro46NVT73o2EryGSjhMeWrtPXnlCmP6kGiK5vh+gyCtTapvHnTghr4LVtTdIm
	 QH8ovL7AgHLDrGLs0v1jEPSsHlR+ZOFQ+mrVKqkXpmlG9qDwdrqdf1CgQd7ksfmALXrD6
	 jRA3a1yMOV2rdnmlIayjNW903rNwOgkyUB9tR4D5FLOxnY9AvV1z0qSFL5LoTlocZzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHn3Qg18;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F05606A31E
	for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 16:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28F05606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHn3Qg18
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso101839415e9.1
        for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 08:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795798339; x=1796403139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EDMWVesK5h/G+OAeuVJlhdz6opzFKvO3nN9e5kJXKQ4=;
        b=UHn3Qg180o3Y0JkGA9NcjQcC29XNgx52gvObAzf2SoIIts2HX2yJYkQk1KyjktYYnL
         rXhMaABPQ0BjnCdhYKiDApZRTF5tlNKj9YJDxPIzShc0ICBdDZnHJ7fbktYnJIm6G5e1
         eRPybXXHTqoG1D8zXT1LkbFUJKQ0KKsdjLO3mwST21i0uLbbmGzuDH7AggQEfcLgClPZ
         zweE2rXq6vutZJ17n7cFtOG8gZm559+hiN1qyIjuoqp+wQ+ICoupHXmvCnIXrDS7g1AD
         tGrs9xWGNtra8dvGxtF1mZXyVObfn8rlNBXU2II95T+A0kM3R1Yen+hQwB+L2TTZ6QOp
         RDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798339; x=1796403139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EDMWVesK5h/G+OAeuVJlhdz6opzFKvO3nN9e5kJXKQ4=;
        b=HT1a4n0FUMZ3XGkbUQjElEte3PM1Jgv0vERTprio2vtE8zo4s0l6oI2Xph3uxryYoV
         u/4nYXYOc0FmTsny3A6agjsfFdEbHvFz9yDgIqiAIA7BngJLeA9/pm2MVSnZXTcrojMR
         BsCkv91HTmYk3jmhE3mMvp8Y8szrwBxJ4+Gpf4Xn8JpAS391qPoz5pOigrcKcDqcxZAd
         TytBVuQPRxkADd3ZQas7a2/06FIy2qXTvx0pkvw4PafiYhdl247nkpmTYOeZeOegC+K2
         qmhCiHMRsq7plY9fqtu0an/AD0upIMksG10dJYrmrHLM86q6hsloP2zGYGBkC6NBzTYj
         S00Q==
X-Forwarded-Encrypted: i=1; AL+hErFC9nUZ39BzU7ElQj2xthkh6MPliSXo2jLZKmqDdewRoAtHpy6s6/ku0ga8Y5jB7Gkctt6pCppSZA0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EV7Of73uKpigylCjazeP5fz+51tdDL8hjzRjBIk/K+HyG/ghv
	YiFqJeusJGjQnxx/s2R1fmSEVGlvb96IUWYJGhMQVzGcA4x4zBX411/9
X-Gm-Gg: AZFdTZcW1jD84ph/ySn9+WVjwCRh+cyS09CT8rXBPEIKOiaOdAS/seFL0NIEpUp8M9m
	RD9ZHeOUIB5JapTB8KApq4yylfjxkfkOt1rX8hE0eNJ88VIFFhh2BcB0X4CyhfpCGGe9FPlJ7zN
	pPu4ip3iALnXHKLOVpfUlGak7Q8rg8sdCZqdRix8/Cd+OreSCv0d4GEEQEO08Z6RgV2Y32ha/DZ
	6cga+CG3aYsPsVp/MHSilQ3hwnZ3xKPUnxHvV3Vux/30+a+5pXpUHVnNKRjZnCGhxkMi6QjzD3a
	r5UImp/pPiQh1FRcZaLTDiA1Zlwm14wIJNBhT+LuluyQcjZBJo8Q1hUBQrFCVYvgCTTeHWn2hzb
	w46QV6ld3yw1Cffl/hQCskifoVRD1YgQJQi+/5B43sOBfRUpgHFPWS37zbxNyrmpisK4ZekzYxW
	MYShTMfxnp/nYzl5EPUuv4A9tcjFj2TXUDTFYiwp7VJ4jeBlkID7oyF+7krscMY758CwWwZRG3Q
	qpx6LpEaYsAmDnghZ+xfot9CbxYjtpHpcgg5gw420/+jx5XofWYNnqQWpYC9WZU+AsQfr/RI3/X
	kw8C8dYFgwpEasrZ88gn56FDkKTXEhCzRVR5xwJZoWc0lQIADbe83BMoiqkr0VkrDzAmGvKDe5n
	5FwPKHesV7PCc+3bSsM0zqV4ERLhrGeCv7BTI7K2q5y8/QJBF5LRFJ3N4z/NWq0CFxUJQYts9KA
	==
X-Received: by 2002:a05:600c:8486:b0:4ac:aae6:6401 with SMTP id 5b1f17b1804b1-4bb8880606fmr516863545e9.12.1795798339356;
        Fri, 27 Nov 2026 08:52:19 -0800 (PST)
Received: from othello.home (103.153.90.146.dyn.plus.net. [146.90.153.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm696593655e9.10.2026.11.27.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:52:18 -0800 (PST)
From: Cassio Neri <cassio.neri@gmail.com>
To: thomas.weissschuh@linutronix.de
Cc: jstultz@google.com,
	tglx@kernel.org,
	sboyd@kernel.org,
	mlichvar@redhat.com,
	alexandre.belloni@bootlin.com,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	cassio.neri@gmail.com
Subject: Re: [PATCH v2 1/4] time: Avoid 64-bit by 64-bit division in time64_to_tm()
Date: Fri, 27 Nov 2026 16:52:30 +0000
Message-ID: <20261127165230.40533-1-cassio.neri@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903-time-time64-to-tm-v1-1-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-1-660be972adfc@linutronix.de>
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

I agree this is a good change.
