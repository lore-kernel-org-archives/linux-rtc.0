Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821554;
	b=cVk1IMDyd5rzUGyWCoWEuj5W3ZRh+RxljtyYaudCLeNkHrDj0XZhzlmTnad+0EF0fzzu
	 FTWo5vbJCSD2fv0mvuEGrxs7OjXsPdm7sDPrUVszzwHm2egir7mHpZ3O0tjz7Yp3MxaJO
	 JE1+O6lhibKhPxkjDdS2GC022ScXh2Haz/YH8op/yAJSSrsLnrCCQUwOYKikrHqAR4fBN
	 x7c8VIfibB3BsmEqYqUw7q5QBtHgHFd1n1koQNzvbz/Wa65+JZjMnozNbn9FVeogNwSRt
	 82b57HmCi4zMQ7gVIGPsCGcNLEuInUqeJHAicgFqLEXbfvzNYOtPhk3EINlivPPiU8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
	b=hZLvkNkfNUrQnS3/7OuSNrnm7d7iQbkhVvgBFK/BXWPBC4OAcI6tK/66/DaDbHiXB+wk
	 apT9zs96Fgn6YKU0z5OiBH40CkRReAkaStBx2HnWWTaHLSNGryVe0FXte5YLFj5FSoBkd
	 n/L8mZnROoF9jcodKh+hhp7055GMCA2Apc8xkmBh4GmsQUbyYmN+aJDI3KRVK/eRuzWrc
	 y7N5u1IpMfW+swFUXv7JbxU8BHJvefhJMqGNisBj/+9RQGYVgDL/09Sp9tBZEdJ9KqXLw
	 /ukl7g6V9SRA7LDPwXeKtMxTSmSjTdaOHFRGCoLhZ5rw0hl8p3PFinMMFdsS/IRhmrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A9B608337B
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 19:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14A9B608337B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1adbf62dd31so1554465c88.0
        for <linux-rtc@vger.kernel.org>; Wed, 04 Nov 2026 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793821553; x=1794426353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=PhgChsRRxoaFlSlkRP6+eJT4KYEi14DqTMP0leDLu81FxLUk2LAC65QwDPBooqvAsn
         iH6XkP8S1MK/SwZxO3AJkItw8VOGPpqeDmiiYKv7myO0lnlZgnop7KC9K2NAgM6ukplu
         Gjsdpkx1k0Dhr49FqliSxtq+PV7zOW1rF8RqXf/q22186XabS9LOxL3XW958WfiYw+PV
         JBjD6srBvq+hK2XBFDtCmpOIf+gS9iJ5nhxA+IIgHZhp3x3Dcb+TLxzecX64kH4ggJZ8
         fI8gag+0WQBADwjfb6rFBnw2H4YR37v7+5aiBzykie/3yy5MmRaIYgT31jdFJ3lzFtA6
         N3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821553; x=1794426353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=sQwwBGKg+scwN8RJJGRFTnQ2zL7ZrnAIhQlVziDmBigIUiPM3ftVeaorukrHIMri9z
         hwzawV/u2Z7avenhElFULAMfc8wQdVROrGSHvYnDch9UhJFEt/BmQxNEUbnqp9TKlVNa
         /dzDSQxPtUZ+zZKoNyWnCdSCggrcomV7PeRB3PBeSgfW+tfO3veRZNFKFJzichSUSkj9
         4TbIcIHb8Q4nHjfIusu+qiMkL3XGdypMXJ/9ETwCdNt5WkZkDbLU6pEGLnCiBdmEfbcO
         wXC4BZ47YYh3UjbuNgXqtACJ0wOHemOqAy/P7ct3lyKb561jY7TrjQBK3fVUtPYFqV7A
         SzwA==
X-Forwarded-Encrypted: i=1; AKwUvBzUxBsSaoU63jAOP3SDxk8y+68cwzPGL9k2AcbyDoBkA0TTi3aMJfIazWVoc+muYOlXITHrAOrpBds=@vger.kernel.org
X-Gm-Message-State: APuU4Z9grNibZxaq1+ZXAHpfXK7eQRSPBl5Fx/OKRZiJWD5wH2tiUUTS
	1o8G4cEJ9XI/WtXB+gjOqtgLd8fOZRxDPhK9wgWQ7GRgaVkEHsj7soI=
X-Gm-Gg: AYBFou1WAZX4SGUg/VsVrdch9mD1pR3DdfTcDqZYzfkHkEwWLHV3FdHAIKLs3udR99g
	52eUbehwhBbkdV3kThfjUyzQ2AtkGOIWHM2JWjn1dZFxb+HWyot/i2zhd2Y0GL0w8621Exxr4vR
	L6D3DJRp4ro5ypv3M55344pb3QzOGjoHJO9Q/XfqLKb3EShLXqlq/h4Gv7atsJtwC36PiGa2cVd
	dy2DS/wzWzLh+NfqRJBqCUbvnokdnMq/l+cIqUQriIT5MzdjCPM1COeF5cppIKBpvH0v14iHAas
	bYgsmh9XnYxSVtFP6h17Z9hxhGEBzeWPJThlGkhVlSOhKig1Uj1rRNQncIEDyGTVHqEXy3+HbI8
	XJurHBOLFPIqa1kM6sO+Ez49zpbJcezz1rVCPbdiyeisrjRt/2Q45sYujpc2RcqFxJHOXaUxtYb
	L6OPiPE+3Ch23bXzkLDE6GriDKuChYQIH2Kf5XZ5GEHlAT1R1h+0v3Av8BQ2mNj5mYjUiGI/lA/
	lOWCygEBMXBtNbdYPKheKBvhsK5ta7dWbeegTAFWYvJblscEKeIrC0HkzUNP6qeg/Y6u/1EsC/K
	912Dz9vqMvT5InRpKj8gSBfa747SM2js4qwFmxyqgkTq+qPnPJ27327AKUhw2N1++w==
X-Received: by 2002:a05:7022:3a02:b0:1ad:e740:e51e with SMTP id a92af1059eb24-1ade740e699mr23857533c88.42.1793821552953;
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm8652168eec.9.2026.11.04.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: [RFC PATCH 00/14] Add macsmc support for Intel Macs, replacing applesmc
Date: Wed,  4 Nov 2026 14:45:32 -0500
Message-ID: <20261104194532.8259-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101010737.203951cd@jic23-hlaptop>
References: <20261101010737.203951cd@jic23-hlaptop>
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

> Are we looking at ABI changes as a result of this? That
> tends to happen with split ups of unified drivers and mapping
> them to more standard kernel subsystems.
> 
> What is the plan to handle them if so?
> 
> Thanks,
> 
> Jonathan

Most of these changes now expose the stats using standard api's, so this
should not be that big of a problem.

The worst possible thing that can happen is that, the user will have to
change their fan daemon (macfand/t2fanrd to any other standard fan daemon).

And also, sorry for the late reply.
