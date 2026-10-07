Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF160334374
	for <linux-rtc@vger.kernel.org>; Wed,  7 Oct 2026 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336959; cv=none; b=K+yfNKuczQr5yzDcKholz5AM0ErwZhkreZU1lsnjmJDkggU8cTGGVU5s2vjqcciOFACk+M4RIUJaAE/6OZ4LWgn2h6JYIhCG2OvHPLsR31Gr4GkuC5D5xFKMdiSA9askDGmCbUFXS/9A7c2fKh+KIBVNOLTZbrC0vpJHDE3MLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336959; c=relaxed/simple;
	bh=Q4YqXzmI+9oOgBh2DPw5n0DcgX3aRz5kn5SKwSjH6p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=FrxM2JDoMKhXx6gR4QpXLXwnx5DT4A4+v0qcKnWXpXISL65/GW07RqMaoCG+8bxTJbElq7Z7vRNUmtb2NgUsqJc/nixIx/JceAM4oYu9s82CmfY5sUzKvFa0IEaGbEq/DMuvXcYhyXKNPafNNybZK666LzIAEL+Lz3cz4Cy9s7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgEjoFgA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgEjoFgA"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92f0b5ed131so140187585a.3
        for <linux-rtc@vger.kernel.org>; Tue, 06 Oct 2026 18:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336958; x=1791941758; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q4YqXzmI+9oOgBh2DPw5n0DcgX3aRz5kn5SKwSjH6p0=;
        b=cgEjoFgA5kDVdN8GkgKVWnvwk5Yrok9MBVJphnYa1UGqemfFBzJVVrFeTlEjosXg3E
         PdtZGH37k8p3giDuhKO6O2KyzEGxGCYGqA7QzYDNd3LfUIp2CbbpV2EpDTBpRevG6/Jb
         1+90yBuhOn90xI9iRRWxA6hWSxjlFYyDa/hUiji2gt6M548aF3IZP6fXyO08OOgy0/sD
         xcevFsCEzO+5jhPGYZUKHqrB4VfxpHII23iJIMshvZSjUYennRr0dorH919QXHcRZ3VN
         pRGwDe/G3eGXnKcvP2e+Z9OwT173aJK7Lvj9DYNA/yw1TPm/i2nz2mdaWJHP3BRM0+IW
         hA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336958; x=1791941758;
        h=content-type:content-transfer-encoding:mime-version:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q4YqXzmI+9oOgBh2DPw5n0DcgX3aRz5kn5SKwSjH6p0=;
        b=Yi22lNjDdYdDPhBI7NbveR3oIaxc9doemCWF9a1yeI1iCY8W+dmlGf/7WCiGvS96Pw
         yBM8rkfRp/ZR7puJZ/ZhHA1fMt03JLvjx0ajAE56TOWwp/Qf6XVMfPu7Ff9wfyoVEzEB
         glzHY3/JJfo1MTBNY0d15HnX+dZe0J+Dj6qEMh99T8KT1loBnQ3wrYT/8J/9LG8lNjdi
         HYcgwmp5FLwhbZ/eIq/QYKypVcspuHsPNBwRtnBYeBATCnl3amUw2aQfQiGjC5MB1ec8
         BqcEhi8qiD9XPcw33GoX30krsWiyYXLgbGJrFaZ/TxgpCNpUzodo+GkG9JfrG1+0hr9t
         MWqg==
X-Forwarded-Encrypted: i=1; AKwUvBzCLxwWqX7T38+Yg9PO6mhKB25hmZh7x7pMGlsXo9wSVvjq4AM+SZvOWE2+N4AoECwOAD6HUlVL1V8=@vger.kernel.org
X-Gm-Message-State: AFuF++m9o2VeN+6Q/3g7oYBOK4pJbOTXo6VEPD67P2ZFa5nWqwtzvfZw
	A5XEDtzRebqEaMNVtD7pFejnozdqhvZ+q4ajrRyxpA0EzqvEZeAG8mPO
X-Gm-Gg: AYBFou3GT2duF+NmQaLo2Yji8DVaRdet+wrcMomUzZdaOM+MN7mctDqRqY0D0PlHDHK
	5qFXix7OZQoOs8QWdJf38hB8pd6MbYOudNZwBqc3Db7f6s0eQFJGXtkhUcneFIIn4jDKXeI058e
	8qyAe8arLrGeVMPWmQIH39ivYl7rC5yirUAslKJ7r30aQY5ezWa2n9dtB/XROTPEEfl3rLsZMxM
	VTMvz+ofAa8oOKxX0H77R4ulSw+CQuhVH2mh95deoc+bBpV+bFzHGtzLJxYaH4NaguS2hbFlTbs
	U3/cC9fBUkmn0L0NcMqPbLWg8hr3Zozafba8BxxR7v6IPsX2BQxWjLz/dtE6pVcTBdwPKpm2YhT
	Q0E4r2RR4XDzS4OeJ6wRkUZAsO4jl5hXRkIk0k1bXGf/+J6J+ZZkj15lcGFnrwDGfha2ZwwqSyT
	TQHjezDq6du6q/4pPaKS3ATu5OPrsD2eKgQYZY5juAkPYwuTGMzHHVkovBphCqXSENfOZ4sQP8a
	6BZn9o7HyDvcyvbtzj4Sm49Dw==
X-Received: by 2002:a05:620a:a18a:10b0:93e:9807:9790 with SMTP id af79cd13be357-93e9b8581c6mr104499085a.81.1791336957720;
        Tue, 06 Oct 2026 18:35:57 -0700 (PDT)
Received: from daniel-desktop3.localnet ([204.48.77.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e98f6f8desm101574785a.3.2026.10.06.18.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:35:57 -0700 (PDT)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: rafael@kernel.org, linux-rtc@vger.kernel.org
Cc: alexandre.belloni@bootlin.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bart@gpxbv.nl
Subject: Re: [PATCH v1 2/7] ACPI: TAD: Support RTC without wakeup
Date: Tue, 06 Oct 2026 21:35:55 -0400
Message-ID: <5383347.31r3eYUQgx@daniel-desktop3>
In-Reply-To: <1959268.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Someone's previous patch hid some sysfs attrs when without ACPI_TAD_AC_WAKE
support. Should you add something similar?

Link: https://github.com/linux-surface/linux-surface/blob/bf1921fc63f33d03a007fb38c4f88ff7e7bc1a55/patches/6.19/0015-rtc.patch


