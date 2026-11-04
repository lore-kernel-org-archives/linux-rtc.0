Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822018;
	b=e/KziYV1L1dr5UnnI6zIRY+8P8PA1ZKTLYDaO1DRtfzYf+uBHWgSPTCxSYuOnw9Hjuiu
	 BtJRu69+yEkPXkDAJXpLmucXUwetTsG8WyO/b6YStTTn6NHr/M+Fw8g93XvuZXGzaA7Y8
	 4UUncPtXJ2obIFi6u+22mijfDzVIIwgYkLPzY6R7LeRZiim4d+B5bF2tnlA0MezEnIIiD
	 /rvYH/5bj4rbEk2QKtKBsBVwF8Z0L+AbTumZcUAAXUx1r7Rxx83cc/n+HX8uUaa1Wyt/x
	 gvkcwlSxSSCIVtmy6PH/ta1joCVApW6CRIzcO38VDosAPA6yFz9YBGrQqUye5tObGbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
	b=S0N/l2ykSQ/PCsF/UizvQ/qiALug9JOfr0XT60Nznc0xGfNglDEjnkI89tGmG2GpIK8o
	 CDSsOl2ZjMrrOzFnobaLp3fpVjABps1AIkTTGWEKdZfqPLNnHIW8/uUakMtqWN4JCGQDo
	 2GQgtIMK0lPwB3+eS78yxaA5zLp59kHNocVKKHnzoT63iC6R2KVndFDgQvhe1K9F3HW8+
	 rCk1t4r3MtY2jMou1402TKxdMXy3ihmYzTWZ3+4a2FoweccaecXw1i3aUjYQi3sCNeDhB
	 l8AUNh33FW1/yFp/xIpSsN7v+fIxlrqlvo+TqV8ZNdkZgeY8JOVR7+VySXiXGp4AhLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8445609609D
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 19:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8445609609D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-19305bcb72cso1062200c88.1
        for <linux-rtc@vger.kernel.org>; Wed, 04 Nov 2026 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822017; x=1794426817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=snwKVTUy9LvBIeZYEhCXzEnRQp2wodIFGKY4wUJ7ztWzLVbTd1bI4nr3mGXqrQXFPO
         83/HtfEisb8NH+6TKxRanc+LHldo4EqJ43kuJQJyWdqbEb2qaKJ6REpFD/Jt5EslTB+S
         zscnal0Mvh+NX91kiP+siOH9v7tqEITC6j8TarPFAWvrj5zWcfX48CLTn8neQnUjk0aG
         DdWT6beozrR7hgNmLfQYYUBVHi+K7i2h0gb1c9TLmiQO015gt7sDVMBLhaHB5Rgu8J3E
         vDvOsMZkyxTj1DF9F5rnA3mHVh2Jx0j8rAylzbJGVo40aem9854GCIhJgMsA/lSZgxl8
         K73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822017; x=1794426817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=wUBSPwBGihrGI5uN9NQPriFtUqsSKwKYzoKMWQq0wbhPnPMFvM/VPeb7mItl8cbxyO
         1C5mJGD1/PDW9Fhbbocpgpb2AZfliWZSIEVTKBm9WvSYVKHtWhTdqVzK0JZCGBwWx9ha
         6mpixLBYxz4W3A4Yms5iiGZ6afBAPDQSac8A5v9svRAmZeL3VtFP9MpC90U6ySpGjMWk
         Yn/EWFs5oL8qt1EoKbdqW2JbJMhrZ7UTBuW2hb06zl2yAWo5DjVoNA7cYzrc9cmY04ii
         r/U8mc957612PN2LMuNqnviVpJlnP9/ch4aeKuPtSATPUnx+YaMAKsVsGG22/FX3BwkS
         ZQZw==
X-Forwarded-Encrypted: i=1; AKwUvBwUgZ2nk8e7/InJiGlx8HBtgvfc1VzGdZ7Vi/S3NRkjhJ8Y4BzYo2YYv+z7I7z8BlfbIo+eAfspbPE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RWwBPC6Vx3yMlMTQ/pLfTnGl8UOCPqFSAPg6eJQcWjQF3Q/Dc
	SgraZB/Tn6onCjtFJHrS/vrV9HyD3/lqMXV3xQHOign+dK5AhzLFBqs=
X-Gm-Gg: AYBFou3qKmm+nblkYYy11smYkuLmxaIbk2yOnJ0HIFRRefI4RM8uZmPdISl/fVYCQyN
	kYXZVbsnDqJMps90di5EEvUzXK61BUs7Nt2O7bQwKxK3awBOb1i3D0G1HsMcfgusvugYf++m9NQ
	g1kDFrtlXhVC8Ebvt/QR1N5P8liOTX9YSxCuLZbDXXLgl1UTblMFql21uw+4jWa8Jyu5bwPrByd
	Wy66uRDXHyKC8ccMupLDpxK0T5z3c+92hkvcwAE/zJj5amYkDBeAWHRHRBeIcXdkQSCKM6G+tKK
	xrNeqZ0JMdqcYJGSI8cYy3+LwvqV+amxkn98EXSgOvm0MXmy260RUUj2gVn3pa66Szy4WSubQ1i
	YUCsGWwMdfcaRhyvu+wJnMvfpvfN0LY9kbxPWMA0+6cTRu98frF10EE+dGqzfsXlP/aO4pPZCiN
	OvAUvhuF7+qUqrkiQ4094x2TArLSwyGhiCYCrFvTZCnr21kHFYNLmuWy4Wks7BmtW4Gw2CYMItB
	dGKgoDBUmP3ihbNwl36VWnc4CooSsyyuVvd3mCIf5ucjidn/9EkRCqkxJ3q5/21j8I40YAkuBhL
	uCKCitPAiZYeUP072MUB2DOXJR5P0Fn5MC7HLsj/Tg1Z2YXOGB0SCGYYlTawPpol
X-Received: by 2002:a05:701b:4241:20b0:143:2968:564c with SMTP id a92af1059eb24-1ac5b9cb040mr26455364c88.26.1793822016817;
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2d69asm9239684c88.11.2026.11.04.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
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
Subject: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Wed,  4 Nov 2026 14:53:17 -0500
Message-ID: <20261104195317.8284-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101013817.22d67ea7@jic23-hlaptop>
References: <20261101013817.22d67ea7@jic23-hlaptop>
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

> If this isn't matching some legacy interface, then we need more
> on what these do.  Maybe they are suited to some other kernel
> interface? In particular they might need the various controls
> on how destructive they are that something like fwctl brings.
> 
> Generally an arbitrary opaque path to firmware isn't a good idea...
> 
> Jonathan

Here its required, if we write CPU/GPU Pstates and PPT to
some keys (MSTS MSPC HE0N), we can reduce the temp by 10C
And We can fix the dreaded PROCHOT signals on macs, Giving
Same temps as macOS.

But you and Sasha are right, that exposing all keys is a
bad idea, so i have restricted writing to some keys only.
