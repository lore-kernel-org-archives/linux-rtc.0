Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794278014;
	b=jeIuOTO1A2pyk4SMjG1BxMvx7uPPsZRVn1BulLDhApBJsrOVvpNLb/FM4BvOlX9qIi2r
	 AmJ2Lu0Lfoj3i3XRVhCkfEXAkTqu56EzewTgczsxU+tbGSIO/a4NlS/DXbt2BvLmMDL+p
	 MoZBuE0yBulkIfuHhlJOAt5581am6yC7kgDYRMNmB02BgQ/Q+kTBs5NL8L6MXuDNVjUjG
	 aN+bbgN3olle5UtK0qvmDr2YcJa5DfEKEr+aCMVogALFbZ8RZK+MM3mI1dhXJtZntz6n7
	 BUmtxDRArtfdhHkvQf9ttkBbZjMER6jZsOr+G5v9ARWeV6nppU1PZ/BxT5K35lr/6fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
	b=WlBW3C41I+H5RZZa3/3waTmCCKC4ssZBgAG+1sfu2V08stLQAwWP2VjAE0Qw4ehdWQIw
	 kyK3ud43NmFwe20DPsqF/AiwA+yyvYCDJmwWJzC3sVIEJppwRk1/vWykmDg5qrfwO+BQf
	 IRDer370ClAEDl65mtvDsXOrq2W2+wntkVwpjWmqvdoKVqWPWn/LrWOO+YCjHJ9W6p6Rj
	 h9NNJj1wSr0Yp5Uw7UGRd0wdDcGRUbUqMedunIDVLcz+0jnE10UA9cFkhR2CbpPRKzq9b
	 bu8F+r8cHBkTa0K9zx56d47ANKsHwqPTtpFk4N4S6WsRSdqIqbCR7bVJs+gIRl14WVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPwTGqod;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBCC606A31C
	for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 02:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECBCC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPwTGqod
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d21051042so235951866b.0
        for <linux-rtc@vger.kernel.org>; Mon, 09 Nov 2026 18:33:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794278012; cv=none;
        d=google.com; s=arc-20260327;
        b=LdCYHRHsQgNERuCMgwDpKKuYYXqxhZTuTlk3TV5IJVsiDFN3V/4k/YadKpJsTFp4FI
         7X50c5f16iZUTX2jRfdeoU5kSDRVP37MJjqGUA+WO4hkRUDfTfFbeDi4KjCLvAOTr+ni
         rX/wNXjlkgbcgBErYRJhqT0m2sgcq5wmoNwezlMonXM9uPcNblw3rBYs9OTFHlqSZztq
         7Dc1dV92g6QCmpt2HAjtlQRkFQIycZm2jqkDW3S3HjjDuxxC2syyn6ktyisHQxQ19Kgt
         kMAKEOJ3FErD36pz7UEYIOO1x3BlJYQppsWHi91Zaa+aKl5ImopMwqOlW/6WF81LeHPN
         eYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
        fh=D3ul2r940ZugjEiSK3u6OKn1iwzUePRse/z4oNA5xJE=;
        b=MKWS2sbtRWTzZ5dIANu18pRT10xMFbOHR176skFZzQeSdOnyUER2r0lOEn/4KhLD/w
         puw+dTp32bhgzWg1mHyzly92o/mAK5gFGSYT8YvCTmsQfw8eMA836MdGqFVKEz3VTYCX
         pCfxRUHvtElPpwseTouW4GHsMYWqCCj79wffQ4Ec5n6YZ1rhkWWUjvdTHL5xYhVzQieP
         480zHBR4IkI+dprMjJ9Mntz1g4oR0GC/gTRLkQXIAwsp6cbg+t3fI5Gm3p1J59UcLjnZ
         1t/+p0b1/kgaFi//3Ayat1FNirMxlvo7W6dMZPp61pf2YrJspmwSRxqHr/Fk5KfYqMbk
         gZhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278012; x=1794882812; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
        b=yPwTGqodd7n8H1mxcfS43lExUvi0jzQJU+ntBIlR4pprDZdl1TVrV7IbOibnNXcuNF
         DfuCSXoUIjxEK/WuoROirOzkOtDBCuOYUf8FTQuhGN/3OSpvmWL9upVt+5OSUY+BA1Md
         EP51Wv7G3gWQ/TjLOxX/nlHk+lT/lByA+C9Y2XOloW3P50RtVZOHu1p6THXe4zxqIZWc
         HtA5gxGAzy6tlbJp2T5twXh+f6WvRnTzeFgFCgRnDBNd8qMU9WETLMADtfnjGT3rP6aR
         8umd9BDxeT55xe3RiTcauiFKWvpIAeV9D8cmRfLcw/X/L8yNYtl1ln9HMc2idk8YD0Yp
         R4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278012; x=1794882812;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
        b=U3gBeK8rZMCZgff7uNGR/MUR1Hfnx9oEO9UA31POgoobZnB2D23Ee8865g5uPXRp6b
         wTzcP4PjJ83PhzCzqEYZxCAi4JMjBlnZ+k7MNS7H2fKm0vMOgyj/+//K0RQtip7B4MGu
         qZOJlND7qrhdnqnWob9V6KQJFtI6dT2hbd0BdEtQUm6/yL+/nXFurnGRoBeALy8zm2AL
         D8cwlEWyipMTNl16fFA8T7ZtopS+RpZgfyZtG4kmMzwG4oa934lYoRn2BO4s9cjzioRH
         8dHj9omV53Zqw1Ia6LDtvc3UWdLjUhzQO1naNIVEw7FZLpj/ygp/gt+k3EtrGENKSYFQ
         cYNw==
X-Forwarded-Encrypted: i=1; AL+hErH2YhfxTTCnta1HSzGWmghFRPNHkz/0Y1EsqfQigB38kEIg8QX9iI052XTxBrb4mvv8Ll1lckdDHGU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xdgLwnfpfT3av3ULE3u2Zm37FW0JxxpCnQuqMjBqsZMJaj6fz
	hPWa7nfrVIq848CyZWJuc+r+/7YessJQU8g6OI7OSnR+uQoeXVbF3ZO1+tbWfK4w/wkBrV3aWKj
	+WDx6HCrnVhiLYIYqs2yAwyzZIWb8zQ==
X-Gm-Gg: AYBFou3X4qSvFrLFw9mSz4Yf+LVIFRzMgXeipMnHmDh3aHdXyG9lCC3I7jguVbSsYCB
	UXMErcYl8s0E1q5KROoeQxCsJ75hpyvBVTj2h2Y8KNHYX1MQTWJGkPa79VLK4c1ZImZHM4Wz3aw
	Ycyo3/MAKlqmROViYnXE/Y+a95BiVaY4er9pJ7BxOdNvLu13PLDwFbMOlWxCGF1HC4YaXd/A4GJ
	omo8/jfNbvq9bsd6jfX2NCSjCneaY3sZdcbzNFf4ORLZpAbtH5yvTDOFM3dcsN6y6jkRrnfQqfQ
	HpWGHU5UZp2qoWFIa7w/1SkRJjLucjDw3Dl7ExSCM1ejoojj61Ijaivb4zbq+uotQU+jSZYezT3
	rdwTF53R9x9L+wVvB2bZfHN1qVAwes6AHEgD6H2AdvLjwXkGY69tPle7eF5U/WkZx4IONkroN+c
	R3QANSt7bSAN4rBrWFDd8iXHgF9aY+LxDslhMI8opsamwMDCwHD5ECGGs/g41v26pT
X-Received: by 2002:a17:906:c150:b0:c2c:d06f:cf89 with SMTP id
 a640c23a62f3a-c50491bd3b6mr89682666b.2.1794278012315; Mon, 09 Nov 2026
 18:33:32 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 10 Nov 2026 02:33:30 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
In-Reply-To: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
References: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
Date: Tue, 10 Nov 2026 02:33:30 +0000
X-Gm-Features: AclHuK8--TocW2ifUYfCFyXaag8s9F_8MyrCNuCPPkZVo7e4LGqYlTsfOEWdPSA
Message-ID: <CAGEsz8HEtP7c-JSV=LvhTH9k5uRxq4z+4GgypbE-gmCurghong@mail.gmail.com>
Subject: [PATCH v2 1/2] mfd: core: Reject failed IRQ domain mappings
To: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Ijae Kim <ae878000@gmail.com>, 
	patches@opensource.cirrus.com, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

irq_create_mapping() returns zero on failure. Storing that value in a
child IRQ resource lets registration succeed with an invalid IRQ. The
child then fails to probe, and retrying its probe cannot repair the
resource after a transient allocation failure.

Return -ENOMEM through the existing resource cleanup path when mapping
fails, before registering the child. Leave successful mappings owned by
the IRQ domain provider, since other consumers may share them.

Fixes: c94bb233a9fe ("mfd: Make MFD core code Device Tree and IRQ domain aware")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
No hardware testing.

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 16ad4fd26..e00f31402 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -255,6 +255,10 @@ static int mfd_add_device(struct device *parent, int id,
 					cell->resources[r].end);
 				res[r].start = res[r].end = irq_create_mapping(
 					domain, cell->resources[r].start);
+				if (!res[r].start) {
+					ret = -ENOMEM;
+					goto fail_res_conflict;
+				}
 			} else {
 				res[r].start = irq_base +
 					cell->resources[r].start;


On Tue, 10 Nov 2026 02:32:49 +0000, Myeonghun Pak <mhun512@gmail.com> wrote:
> Hi Lee and Dmitry,
>
> This series fixes WM831x IRQ resource mismatches and follows Dmitry's
> request for managed onkey IRQ/work cleanup and MFD-provided mapped IRQs.
> The provider and consumers are converted together to keep their IRQ
> resources consistent.
>
> Changes since v1:
> - Use managed IRQ/work cleanup instead of storing the onkey IRQ.
> - Move IRQ mapping into MFD and update all platform consumers.
> - Reject failed mappings and unwind consumers before removing the domain.
> - Retain polling for release detection; the chip only interrupts on assertion.
> - Drop the previous Reviewed-by tag because the implementation changed
>   substantially.
>
> Compile-tested with LLVM, W=1 (arm64), for all 11 changed C objects.
> No hardware testing.
>
> Previous discussion:
> https://lore.kernel.org/r/atJycIEnUZKVdTjW@google.com
>
> Thanks,
> Myeonghun
