Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798570;
	b=bByaGdS/NACCAmoeTNv328PdSxlMcNTL+LD065u4KeB0Kv8r5ixM+xqkBVaNKjxotxkV
	 990ylRMLTpzQcm0g5uNgIpmVSO+85Tf9WR7ZZCJtMUGAagFDHPtI4Hkq/emGCr92SrIWc
	 urJbWyFEVQH2fy4VUMBMa6R573lkDzvDiThqzfkVY/pWIlyUWYqNAS79MdfPOIVaaKI78
	 JFNScsgBLCay9PbpSnTbHZD6YnNXeiP6ZzN6r5gufMiNc1lUYSc6XXr/X5qN9IgFie+Lk
	 v0SgM3V2Tj3uzf4Yzkm/WZJs92idKi20Lkfut7ZA9W5/gy51XCG+ZffNXY4AIoYD98w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=quHNvbQRn8H67Iq0kxiILrUyTDkIf1n5cs4RNseeoRo=;
	b=oFsptgKpPPj8XtsJ9FlOZKsVfdMfrW9GesHrBKQIGTyPifWLRreqWnvolOftUzOoeTLW
	 nmTxrePLPTko3dX0L35Lj8lGuyaQuyDaok7oga2VUG/Ayoo1v/J0pEJZl0bUAB9mjg5m9
	 Tq1E4jDDp8qznlvxXl9DxwR56f7zfSKpsLODz+GHdY71W0orr7YoMrRj7mWJ78RxyaEp/
	 wNS+Efo7ZVtwrhk0iWtNkM+Fq9XVz4ABV6fNPBREAteGmqe1lzDbKcdcEsaBDuE/jSAqw
	 8oqVBUkb7vsiwl1/wTzCzNH+PhyYUP4XXTe7xG2vKwuGQSs2zQudlH4BKaHA32ppkqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=slFQninl;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A7606A31C
	for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 16:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C28A7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=slFQninl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490f38e9688so5776957f8f.0
        for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795798568; x=1796403368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=quHNvbQRn8H67Iq0kxiILrUyTDkIf1n5cs4RNseeoRo=;
        b=slFQninlxmbGqzusDFzKTSdSae0xCitAw0Inxz2dycLHH2As7Sm/l7iooX9Hm3Tq8Z
         bzViPFyQR+tpbRX/8ClszfCr0MBMfYFUBIEi/xTOfw1rpzVYmc2ZOiGlpqE/LNNUh20F
         9pAUaRI6to5l9Il+y9wLkxzmF7jmQ/+BxZ0KQUQEcTEiyriEvPx4CL0ULqXoeTqpQjkr
         yHNuG2fffgLge2SgbANo6vpwMV1KFb0h+QERfmfglck7DJDFE5wGJxwMSK4pWxzTjy7O
         fwh+RqhlwkFkOsXHpFm1wc8YlUmeL4n+VTogBbI4OtB19fJVtfkctfE924xBnrmk78ph
         F2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798568; x=1796403368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=quHNvbQRn8H67Iq0kxiILrUyTDkIf1n5cs4RNseeoRo=;
        b=fNWauTbHSfGItIv67E0TuxoNaAScXvBdvskPlW3H56xm7xdxUg3kYGEd2o+tpTUYIO
         sH53+Z8u3ZfiQRWUA/eZ1kdetTkcC38n/oUaoQ7CpMKEeaE6VhNMzm3PQfE7R4oIwDaS
         7yXwLejZo39anlGTwURKlYCTKWRkzuMvhbK9V1aQxdBW4FtWJjQoUiMLqoX6B2jgDF/h
         CHclSVeXJxW9JsyWPd1+Psoy4oG2gWcnfnQHn9MRErcAx7U4aDSusYEq/ar9Z50leMUB
         dIzU/ejkT+yUXIRx+dFQhXGYfUBSF668ogkqx47e5bKFEBh39mpufM5OhM1a58XtmhEd
         ftfw==
X-Forwarded-Encrypted: i=1; AL+hErEQSBxvOMkCaxTDm4NiJGSwPSqexbguVvZOLHy5ur5rxGZCPnzlgbzGNVoDhKFXyuIqeneqiOQrw90=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wjjucMFPVW94IPe/cACG36mejWjsg4PsYWxB4/rJl2qjwKfSe
	aTE3bVJ10ucvOYfrCDQnzxP/jnRrJiMWvrkGhJgtajxBR3b2dvya1jOW
X-Gm-Gg: AZFdTZceXStz6W80L+nqdshx4gmWdMm181wSono2ioSN5wPqNxeOiFH4UxCYEwR8R6R
	/rFhN19fuIh64T+dYvqleZ0oa3lXumid7/+Rcu+looDpWj/6ZJksb1gk7t5+GT0eVq786AdxEtd
	sg/IJoO2vUL4BpO/BR2NjX0bXqOatxsigh8AkuPMlpO6mnjPTxd+4mpd7xja6cY7LeAA/np/Xmo
	cywrI5ibkaDF4n3mJBv6LP+niDr4UxMPuogLXcoKN8amjc6EOyrps4tlQGbFHpOCz0W69plMpL0
	j1dfdP0cDQJffjZ/PTZena79W5uCeYG2rvfervPnlnfBhrfMMSvSflWAaxPyEUeSPmm+cUnMswS
	uMH+EziEkeFgSqP1IKKJW/KNrVOH4yAcNIC8q1an4QmGt0l/iXWRbgXiVVz0SJYYAYryaaPtMgV
	4mA2KdKrk+JjimqU9Q91VKQNgmBZbt0KnB04Aj2XM/2K78mnvO/bVtX3UqTtJdgZ0Nl4I1RGdbx
	IqYCfcY5cwn+RR3SQayMsM9/Ezf2P4fmB0TPWFhyI7vq3PF80UqewdubhJQecbGSjox1eyhHd2A
	h7BZ21oOwp9Nn9NYTZGoIJc16hJUQ45Iw9opYK57VAs7VnarTlKoNpKzNuleGg+0+pgQLWwiz/h
	h5kUfVqeerllzpcoTMSNxwkqiVr8SPPi/qOpMiCsib/UYDq6DgiRt
X-Received: by 2002:a05:6000:1acc:b0:4a7:a8f:5297 with SMTP id ffacd0b85a97d-4aa57b91bbcmr55960348f8f.19.1795798568084;
        Fri, 27 Nov 2026 08:56:08 -0800 (PST)
Received: from othello.home (103.153.90.146.dyn.plus.net. [146.90.153.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm40575449f8f.46.2026.11.27.08.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:56:07 -0800 (PST)
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
Subject: Re: [PATCH v2 2/4] time: test: Avoid unnecessary divisions in time64_to_tm() test
Date: Fri, 27 Nov 2026 16:56:19 +0000
Message-ID: <20261127165619.40736-1-cassio.neri@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903-time-time64-to-tm-v1-2-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-2-660be972adfc@linutronix.de>
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

Moreover, this test is overkill (my bad!): it loops through every single date in the range of [1,970-80,000, 1,970+80,000] years, i.e. a total of 160,000 years. I pragmatically suggest reducing the range to something more realistic. (Unfortunately, I don't have bandwidth to do it myself.)
