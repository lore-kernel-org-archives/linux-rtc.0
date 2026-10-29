Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284794;
	b=xQJo63SJlymZq7qWv2jjiTv23IbYX1GGsQBLBJRxi1sZ0vH96uJ7Gn2EecBcC4OZk+aK
	 Iy6stVsM1g8jGIiqfKWRx6PKzb6q9rxP8XgHKhFJvzVfgbGPVNiHp1PNmjBkWYPaZ+mK3
	 Nc7Hthm2fsRBViiAkLcPGicbrPOY4Fgs77oFhQlPwbD8YSnH7VTd66COZQiPFvdZ92Tc5
	 NihMIBppSVexDaV32nSgCj3iVM3505x30yurp9YbBBjT4jfL1bNKIr7zBb0s8rpXH8Ktp
	 b0fFyyQayI5/VtdNdWRKn8+YTPD8CRHcDN0bGqiME5fiX5nCTbocDRa+/p8YVHd24xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
	b=t24zjRjf5EMdxdF+vKBw2/kF1DYIogMPcAaPF//ssTyDXBzFIP6J/Kd/N8ufOwE9ldLM
	 Xk94GgvgXzhWrtpwQB+lmBowwUCO6uncU8er088mrsbgNEzC8B0MZ06ULB9UqkU1HS16c
	 z6rxojjbxXamycaU3UqhYA7MvX9PS9ofjZ4UUujeiBdMFbEeJhJBZ2QWpH1gb8Dzj54PU
	 siGFmgDU3zVCvLJA0syqgYpqbGUpvqKvxBbjEtI/XSxLgFIyxzYf8ASTuOSk7/ofFxUxH
	 E8f/sL+IMrgJu9y9w22YFi3rB4Fdp/PgAgCutkm95MfFUr3Tsniu8/CvlTeeopPy37A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fPTlg3YK;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A43606A320
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 14:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A43606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fPTlg3YK
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1846bc43c28so2543456c88.0
        for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284788; x=1793889588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
        b=fPTlg3YKi8LCEYl7MWaRXbl+fOsMT8EooFaEX/qteZRl8FsZt88RyX9Nz4rh62atDU
         N2mi9nkHHOJC4qFeiUXhTHbjbhHQHXOF+NhhfCQK6iUf4J/Q9ypFok7z2wgCKAPn6EjK
         xZ9kY5ZnP4n+8lX6/VsHr77Tn99+eesUK7yOJOQntEtEMQGRE1D1vlqqCLeQI7lI9/6d
         T6b6GWLz4O6TATQ+xATuCOZzKNxV75JOEocPZj36+KoGY18UuoHpbDZjja7BkGHZcM0B
         8XE+KTQjlqXnRe4OF7u9IeoFkO5y9EWni2EDctTAKHudHO9Rp8OhbT05Vxxf/IOtY+cj
         QvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284788; x=1793889588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
        b=EbByiLfRwUjCe86EpQT7rC5TGDs60N27/9mAAsBSaP+7P+o2+jloXUPEk0uqmhSvFw
         yuWeJoSlLZtxtyWOSk/fWEfxJxLmWEB2oM16PU/KfqOpWNpRciVWZsHHECW36buCDEwj
         DyBxcyA8N2i7mGjhzNEHePDQHK41UP25Otz1dj3kweCtbP5SC0EWKSVEmJo79BhnEL9V
         gIaF1uNzrJpVYm4YDqqu/oA7/WY9p2EZVWkfThjYe75tVCl9aOtr0ddcp4RUaMqF1aRN
         xzxsHybWVie3ic6G9J6s4g+Llitbmrk2r05Y6Sqtkjbj+VLhorlb0ATdT0DfgCbXvhqN
         r63A==
X-Forwarded-Encrypted: i=1; AKwUvBz1UXekzz2VCGD0gm2jPR+yQ5uBREgf3nj3OWYcsk+zfK18s46ThI2lRWfkfC3996UXFvyBsK3q3Dc=@vger.kernel.org
X-Gm-Message-State: AFq9FYICJL53ZAhmy+/t4OOcpe3/1fR30UodhRbKhBRfgK59XdlV2E3G
	SAfN1zJZyGMSTnkAh+Fza2FUEoLHDJYP8mf+9mW/DCVkqIRKRMi+EPA=
X-Gm-Gg: AYBFou0yKCDxkzAISonpbpEqm1nCRvkcmUFFwKhy4Np7u3oX4vPnSQYzN0+x3Mg5kyV
	8WZ7Mdc4XgJsh52SxUQKs+YERDJJzG0fuMsLqWIDVj+varfWy2fmUUX3YKfiO3KRudOCM8KS776
	k1NzHl3Ecd5orIHLeMxakZLvkDeQXhIqfpy/Hqw65TtGRNQFMkOt8lws3m5hpb13Lh6w5SfVuf/
	aKN/7GLzHhkRM+uhFD+cyxZ86YBVnAENgGvc8GKNTHhIUA346qypNoZT9UcBTUR8nHVU7lEjcbp
	6/sRk4eopkSR0FLHVc6X4DV8U3ojNBdq2X57RtJw7oX3ITu+KTev8RXoOmroyYk18px3/4gxz6A
	6t56VpVgw69n1kYaRElM5z8ibw501Edwy8mhoAbORs8ZcIheS0zjmErHcLI/nfEge5qqf6eoqPn
	FIVDbZ4tTbAvUNj8SpTVTbSL21B4oRcMGBMkx7D/1Kbhq6R47Kdeq+zeYZKZxyNsOT/HcJVDCxx
	YpIunexdIbO6V91KcgZsgSoi1MO2EfZcDTuMWe37VJSM+rZWHks0gy5tSYzcaGesq+E7WclZoe2
	QbDD/+VjviS72dmV6Tl5yhixLDaMv3aptZf2I2+vfI3l1Xga6AN+Lwh4JLjjcvbRCVU=
X-Received: by 2002:a05:7022:ed07:b0:1a4:c892:b14f with SMTP id a92af1059eb24-1a6ced8e7afmr7393000c88.29.1793284788293;
        Thu, 29 Oct 2026 07:39:48 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.115.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75cdd21c3sm15396439c88.4.2026.10.29.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:39:47 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: k@chaosmail.tech
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
	jic23@kernel.org,
	jmorris@namei.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
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
Subject: Re: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Thu, 29 Oct 2026 10:39:26 -0400
Message-ID: <20261029143926.1246-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
References: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
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

> This should either be dropped from the series, or be hidden behind a
> `melt_my_mac`-style module flag, or switched to a whitelist approach.
> We do not know what keys will be introduced in new smc firmware
> versions, and there are already keys that should not be randomly poked
> at.

1. The patch is required, atleast on intel macs, as without writing GPU and CPU
	states to smc, the system gives PROCHOT signal under small load
	, and heats up a lot.

2. the smc dosent expose keys of nature that can physically damage the system
	it only exposes power/volt data, and the most you can poke is reboot
	keys and gpu/cpu p-states.

3. If a person is randomly touching keys, Its their problem and not ours.

4. There are a lot of things that can mess the system way more and permanently
	than smc (undervolting for example), but they are not safe guarded, why
	should this be then?
