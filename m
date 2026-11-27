Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798776;
	b=G7DqYEvK5xhkmLNKZXzcMF6+TzXmTNQPCdWaENlc5O+bknloWBlcvDD6+MlVTfQJyLmt
	 iNsTiMuPZJkqNtjlJRcmSroxOKNG/gs17mo3aEiBfBVycNaoI1rL53rQpw0yyOkugAEi5
	 fPc4RKGuqUz9og+McuMucNWRW1gl8xOtH8IBi6+ANX5VXaSLIgj02ELeVX7h3GjPzX6Kl
	 ytsCQrGsPxXwWEb/lOjc7PDTfrvLPFUP3X6tR6rZsX/mzGKaw0N09+Qjo5QX3gqE7M/xz
	 wt6uEWo2l+3t2BXKTpN/r2eJ/H9xxiO5ZBaftuIbDQVC15TDhqQ+dvT0GUfSSnr7/PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dBzotrpNO+SYAnhXJRs2E85Wf07NFcieAoMwmsZqh20=;
	b=Dd3k8QKR589N4vhE3kBIZRROCYx4issblEhyC88FOslDgKBhY0NfDJPKt0h4fCAZ3igP
	 zzi+xMIe1ieBahxB6RH5x0+U4pQ3ymflJzWGHkOaVbf2e2MWKPV5BNnuCazDQZwXyRH3L
	 fEySHTmcgFZy+2tndqU0FbZAwAzCUuNpjzwt1zvDkVjD1TkusI+gfFgDxo7+5+cJR65w4
	 t/rbHhoqsBE1M7x7H+r0DqyfcWtgelDLcFlXbre4ajq1AtuKQn9caINCXw+fxztYbCJW9
	 q+4LGypL9gO37LGx7KW/94jnr/e8f7mq5XogB2qE8Y/jZoO5H97C4xwyCuHPYkPgaMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j+tmm3x0;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5DD606A31C
	for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 16:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A5DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j+tmm3x0
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso7359383f8f.2
        for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 08:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795798775; x=1796403575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dBzotrpNO+SYAnhXJRs2E85Wf07NFcieAoMwmsZqh20=;
        b=j+tmm3x0J5zDd20coTtDnXxikqMbce6ZTTrnYypc02NbTcuv+CL9V6+Zl1SJO3HKVM
         Lz6QACvCZp2E2ntheSnsEtApXPWxiQH/9/PdkNRnWK8o559hKpjDJGP+CZf9b7aB3VwJ
         NwBk31zq3OPDYUO4IAq+KwH57WktxbwqLQIXIeJmrEIa5BxObSISR7eril5rtyMGetyp
         0mgVg4QFLt2TlokKxfvLUxgLB3DGZECV2cKqNV/NKcmXN1IUALHLyBcK4UCd5hVuqViP
         7RUrG487WFUtMzHDnxEBKbGLpPmpPgAUmTDh9Bj4QVFtXqY5rvzOfaRLlJYFHC8d7aZ7
         Zl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798775; x=1796403575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dBzotrpNO+SYAnhXJRs2E85Wf07NFcieAoMwmsZqh20=;
        b=L2gr4KojdTD7piqR39dR0+Kh5mdi2D4GSuya0vpYbOJAHr2nRnqly2OofSgMuimbFG
         QiARLjLNteekc/Phuqj/yxWeyPxUIlfKXEXi4hrSgEmzauysiMPb3eBgI7OUtcXqtDB3
         ELwupHD02ow3UjgoJngw3QMSQx5ylfldJ7LBFWmIwq712C9yFZeqrOQL/DSZpfQWOMXo
         KIpKHxI0ohJrFSclcmOuOYGoESb+PMUDXMkjHNokUcEfxFUMNE8TncrQF5pnkIWG00M3
         95dmG5AzfLskNsO8/ai1yKAuvQF1BwZJizd6pL4aUhaNTAC0w2rQAUQBGg6ytCqvEXFt
         8WoA==
X-Forwarded-Encrypted: i=1; AL+hErHLkPkmmmOzcw6iqsSRsAN7voraOtIAtTizi/tmRlTXXvLP6zz15m+vsQAELN7nT8ns59AaYHk8i+k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tbRkaFPywWod3pMb2b9tnXYgL9pncIVuwwyoDAbzNJpH7S9ib
	2kMyyfI1NgbwimxAXrRll5cX5KteE9+CXH1shYR/tAz1TKGb0+IhJopM
X-Gm-Gg: AZFdTZeHjZNZ2mHxniO7SEKdv1bVmsPysL+Nsvbuw9UkJ5Wc23dtOXAKKJ+qfmJeVxs
	s6hmPVU39InATk7jjvgDIKnPHKxqZIf62pkgu0J5QdDdJq5pdi0jyHsqgOnyyRJU5UmuYyPsAZS
	WLPtSUb7UcacfSgrRYfv+4SAfun+29Ph2i4XNVFXpmBvxKggL/B7G1vK8joqo3zFDizDQcqOIkM
	eh0I8LSOaZO9Yt13f2INFXSGA19U43c/QijnQwwEWYv+cBhV1bYeHx615HtF45HHET1zH/i/bUN
	DfXPTLQoagqRTBPiv4jC54LfDLfa0CbkT5ZoUvhrscM4+HxaOUYQJJs5RD3Oy7cDU4Va7Kc8Aw9
	hjR/f9eu+ExKbWo89UIU7V6U2CuUTKsS+YSTtVYdYxaPRVQwOQYTl6CdFNfKXV2XdeJj0q+BHou
	wjnzkoBhg7N5QjhXAX5XPj72wyNO0ZrV8fs/HEVk5wXMcMwinXviS/MGrSwSbf6f1b0h5ch1wsU
	7uTHPN6cOvZ6VKNy+CV0E+iwQqF9OxOC1Dr8IMCwthmQuJJbDh0+XXMfA4KFfczSEaZOXF2bbtH
	3XgpbwHwruSKYS3L+AHsd2hAQDhwDDehHj3s9tFiY2AHF3ruJGC3CoVDyAxAwzNv8GcjLt/Urrj
	m7gmJzv9aIg5tmX3X6DNxZdQaYWu0R5Rq4Kgs/AwssgisUT2eClMK
X-Received: by 2002:a05:6000:2f84:b0:4a6:4f35:31fa with SMTP id ffacd0b85a97d-4abad5ac888mr52334037f8f.3.1795798774903;
        Fri, 27 Nov 2026 08:59:34 -0800 (PST)
Received: from othello.home (103.153.90.146.dyn.plus.net. [146.90.153.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm50234106f8f.11.2026.11.27.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:59:34 -0800 (PST)
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
Subject: Re: [PATCH v2 3/4] rtc: lib: Implement time64_to_tm() in terms of time64_to_tm()
Date: Fri, 27 Nov 2026 16:59:46 +0000
Message-ID: <20261127165946.40949-1-cassio.neri@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903-time-time64-to-tm-v1-3-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-3-660be972adfc@linutronix.de>
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

These changes look excellent to me.

When I implemented rtc_time64_to_tm and time64_to_tm, the duplication was already there. I wished to remove it, but I was afraid to do so.
